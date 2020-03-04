//
//  CalerderViewController.m
//  FSCalendar
//
//  Created by zjc on 2020/2/26.
//  Copyright © 2020年 zjc. All rights reserved.
//

#import "CalerderViewController.h"
#import "FSCalendar.h"
#import "LVCalendarCell.h"
#import "UIColor+Hex.h"
#import <EventKit/EventKit.h>

static NSString *const cellID = @"cell";
static NSString *const dateFormatterType = @"yyyy/MM/dd";
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width
@interface CalerderViewController () <FSCalendarDelegate, FSCalendarDataSource>
//日历组件
@property (strong, nonatomic) FSCalendar *calendar;
//存储日历数据结构
@property (strong, nonatomic) NSCalendar *chineseCalendar;
//农历数组
@property (strong, nonatomic) NSArray<NSString *> *lunarChars;
//日期类型
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
//节日数组
@property (strong, nonatomic) NSArray<EKEvent *> *events;
//作为传出去的字符串
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@end

@implementation CalerderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //设置导航栏背景颜色
  self.navigationController.navigationBar.barTintColor =
  _navigationBarTintColor != nil ? _navigationBarTintColor : [UIColor blueColor];
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                   style:UIBarButtonItemStyleDone
                                  target:self
                                  action:@selector(doneTestAction:)];
  self.navigationController.navigationBar.titleTextAttributes =
  @{NSForegroundColorAttributeName : [UIColor redColor]};
  //改变 Item字体图标颜色
  self.navigationController.navigationBar.tintColor =
  _navigationTintColor != nil ? _navigationTintColor : [UIColor whiteColor];
  
  [self initData];
  self.view.userInteractionEnabled = YES;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.calendar];
  
  self.isEnd = YES; //表示后续
  if (![_startDate isEqualToDate:_endDate]) {
    // isEnd初始值为YES
    _isEnd = NO;
    [_calendar selectDate:_endDate];
  }
}
- (void)initData {
  [self initDeaultsInfo];
  //获取事件列表
  __weak typeof(self) weakSelf = self;
  EKEventStore *store = [[EKEventStore alloc] init];
  [store
   requestAccessToEntityType:EKEntityTypeEvent
   completion:^(BOOL granted, NSError *_Nullable error) {
    //            if(error){
    //                NSLog(@"添加失败，，错误了。。。");
    //            }
    if (granted) {
      //            NSLog(@"ok");
      NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-3600 * 24 * 90];
      ; // 开始日期
      NSDate *endDate =
      [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * 90]; // 截止日期
      //设置过滤器(开始时间,结束时间,日历)
      NSPredicate *fetchCalendarEvents =
      [store predicateForEventsWithStartDate:startDate
                                     endDate:endDate
                                   calendars:nil];
      //日期存储,事件数组
      NSArray *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
      //设置节日数组
      NSArray *events = [eventList
                         filteredArrayUsingPredicate:[NSPredicate
                                                      predicateWithBlock:^BOOL(
                                                                               EKEvent *_Nullable event,
                                                                               NSDictionary *_Nullable bindings) {
        return event.calendar.subscribed;
      }]];
      weakSelf.events = events;
    }
    
  }];
}
- (void)initDeaultsInfo {
  //初始化时间字串
  self.dateFormatter = [[NSDateFormatter alloc] init];
  [_dateFormatter setDateStyle:NSDateFormatterFullStyle];
  self.dateFormatter.dateFormat = @"yyyy/MM/dd";
  if (self.startDate) { self.startTime = [self.dateFormatter stringFromDate:self.startDate]; }
  if (self.endDate) { self.endTime = [self.dateFormatter stringFromDate:self.endDate]; }
  //如果返程日期小于去程。则返程设置为和去程同一天
  if ([self.endDate compare:self.startDate] == NSOrderedAscending) {
    self.endDate = self.startDate;
  }
}
#pragma mark - datasource
//最小时间
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
  return [NSDate date];
}
//最大时间
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
  return [self.chineseCalendar dateByAddingUnit:NSCalendarUnitYear
                                          value:1
                                         toDate:[NSDate date]
                                        options:NSCalendarWrapComponents];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
  
  if ([self.startTime isEqualToString:[self.dateFormatter stringFromDate:date]] ||
      [self.endTime isEqualToString:[self.dateFormatter stringFromDate:date]]) {
    return [self titleToRemind:date];
  } else if ([self.chineseCalendar isDateInToday:date]) {
    return @"今";
  }
  return nil;
}

- (NSString *)titleToRemind:(NSDate *)date {
  //    if ([self.startTime isEqualToString:self.endTime] && [self.startTime
  //    isEqualToString:[self.dateFormatter stringFromDate:date]]) {
  //        return @"入/退住";
  //    }
  if (self.startDate && [self.startTime isEqualToString:[self.dateFormatter stringFromDate:date]]) {
    return @"入住";
  }
  if (self.endDate && [self.endTime isEqualToString:[self.dateFormatter stringFromDate:date]]) {
    return @"退房";
  }
  
  return nil;
}
- (NSString *)normalTitle:(NSDate *)date {
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"dd";
  NSString *dateString = [dateFormatter stringFromDate:date];
  //    NSLog(@"deselect date : %@", dateString);
  return dateString;
}
- (nullable NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
  //传入时间
  EKEvent *event = [self eventsForDate:date].firstObject;
  if (event) { return event.title; }
  // 0~29
  NSInteger day = [_chineseCalendar component:NSCalendarUnitDay fromDate:date];
  return self.lunarChars[day - 1];
}

- (NSArray *)eventsForDate:(NSDate *)date {
  //判断节日数组是否等于今天
  NSArray *filteredEvents = [self.events
                             filteredArrayUsingPredicate:[NSPredicate
                                                          predicateWithBlock:^BOOL(EKEvent *_Nullable evaluatedObject,
                                                                                   NSDictionary *_Nullable bindings) {
    return [evaluatedObject.occurrenceDate isEqualToDate:date];
  }]];
  return filteredEvents;
}
#pragma mark - delegate
//使用AutoLayout适应时必须实现的方法
- (void)calendar:(FSCalendar *)calendar
boundingRectWillChange:(CGRect)bounds
        animated:(BOOL)animated {
  
  [self.view layoutIfNeeded];
}

//选择了时间
- (void)calendar:(FSCalendar *)calendar
   didSelectDate:(NSDate *)date
 atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  
  [calendar reloadData];
  // endTime选择 ,否则为订房时间
  if (self.isEnd) {
    //           NSLog(@"退房的时间 %@",[self.dateFormatter stringFromDate:date]);
    //如果退房比订房早显然不合理,所以回到最初的状态,isEnd 为NO ,下个选择为开始
    if ([date compare:[self.dateFormatter dateFromString:self.startTime]] == NSOrderedAscending) {
      self.isEnd = !_isEnd;
      NSLog(@"选择的退房时间比订房时间早");
      //这里与下面重复
      [self selectAndUpdate:date atMonthPosition:monthPosition];
      [self deselectAndUpdate:_endDate atMonthPosition:monthPosition];
      [self deselectAndUpdate:_startDate atMonthPosition:monthPosition];
      _startDate = date;
      self.startTime = [self.dateFormatter stringFromDate:date];
      //显然每次选择之后都需要改变flag
      self.isEnd = !_isEnd;
      return;
    }
    
    [self deselectAndUpdate:_endDate atMonthPosition:monthPosition];
    [self selectAndUpdate:date atMonthPosition:monthPosition];
    _endDate = date;
    self.endTime = [self.dateFormatter stringFromDate:date];
  } else {
    
    //          NSLog(@"顶房的时间 %@",[self.dateFormatter stringFromDate:date]);
    //需要滞空防止每次点击reload又改变了文字(每次deselect实际上都是正常的)
    _endTime = nil;
    [self selectAndUpdate:date atMonthPosition:monthPosition];
    [self deselectAndUpdate:_endDate atMonthPosition:monthPosition];
    [self deselectAndUpdate:_startDate atMonthPosition:monthPosition];
    _startDate = date;
    self.startTime = [self.dateFormatter stringFromDate:date];
    if ([date compare:[self.dateFormatter dateFromString:self.endTime]] == NSOrderedDescending) {
      NSLog(@"选择的订房时间比退房时间晚");
    }
  }
  self.isEnd = !_isEnd;
}
#pragma mark -CustomFunction
- (void)deselectAndUpdate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  [self.calendar deselectDate:date];
  
  [[self.calendar cellForDate:date atMonthPosition:monthPosition].titleLabel
   setText:[self normalTitle:date]];
}
- (void)selectAndUpdate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  
  [self.calendar selectDate:date];
  
  [[self.calendar cellForDate:date atMonthPosition:monthPosition].titleLabel
   setText:[self titleToRemind:date]];
}

- (void)calendar:(FSCalendar *)calendar
 didDeselectDate:(NSDate *)date
 atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  
  //    [calendar selectDate:date];
  [calendar selectDate:date scrollToDate:NO];
  
  return;
}
#pragma mark -cell
- (__kindof FSCalendarCell *)calendar:(FSCalendar *)calendar
                          cellForDate:(NSDate *)date
                      atMonthPosition:(FSCalendarMonthPosition)position {
  
  LVCalendarCell *cell =
  [calendar dequeueReusableCellWithIdentifier:cellID forDate:date atMonthPosition:position];
  return cell;
}
- (void)calendar:(FSCalendar *)calendar
 willDisplayCell:(FSCalendarCell *)cell
         forDate:(NSDate *)date
 atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  [self configure:cell date:date position:monthPosition];
}
- (void)configure:(FSCalendarCell *)cell
             date:(NSDate *)date
         position:(FSCalendarMonthPosition)position {
  LVCalendarCell *rangeCell = (LVCalendarCell *)cell;
  
  if (position != FSCalendarMonthPositionCurrent) {
    rangeCell.middleLayer.hidden = YES;
    rangeCell.selectionLayer.hidden = YES;
    return;
  }
  
  //设置头尾
  BOOL isBegin = [_startTime isEqualToString:_endTime];
  BOOL isStart = [self.dateFormatter dateFromString:self.startTime] != nil &&
  [self.chineseCalendar isDate:date
               inSameDayAsDate:[self.dateFormatter dateFromString:self.startTime]];
  BOOL isEnd = [self.dateFormatter dateFromString:self.endTime] != nil &&
  [self.chineseCalendar isDate:date
               inSameDayAsDate:[self.dateFormatter dateFromString:self.endTime]];
  if (isStart) {
    rangeCell.selectionType = leftBorder;
    
  } else {
    rangeCell.selectionType = rightBorder;
  }
  rangeCell.selectionLayer.hidden = !isEnd && !isStart;
  //中间图层的显示
  if (self.startTime && self.endTime && !isBegin) {
    BOOL isMiddle =
    ([date compare:[self.dateFormatter dateFromString:self.startTime]] == NSOrderedDescending &&
     [date compare:[self.dateFormatter dateFromString:self.endTime]] == NSOrderedAscending) ||
    isEnd || isStart;
    rangeCell.middleLayer.hidden = !isMiddle;
  } else {
    rangeCell.middleLayer.hidden = YES;
  }
}
#pragma mark actions
- (void)doneTestAction:(UIButton *)target {
  if (self.selectedCalendarBlock) {
    self.selectedCalendarBlock(self.startTime, self.startDate, self.endTime, self.endDate);
  }
  //        [_calendar reloadData];
  if (self.type == FullScreen) {
    [self.navigationController popViewControllerAnimated:YES];
  } else {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

#pragma mark -getter
- (NSDate *)startDate {
  if (!_startDate) { _startDate = [NSDate date]; }
  return _startDate;
}
- (NSDate *)endDate {
  if (!_endDate) { _endDate = [NSDate date]; }
  return _endDate;
}

- (NSCalendar *)chineseCalendar {
  if (!_chineseCalendar) {
    //设置中文日历
    _chineseCalendar = ({
      NSCalendar *object = _chineseCalendar =
      [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
      object;
    });
  }
  return _chineseCalendar;
}

- (NSArray<NSString *> *)lunarChars {
  if (!_lunarChars) {
    _lunarChars = @[
      @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
      @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
      @"二一", @"二二", @"二三", @"二四", @"二五", @"二六", @"二七", @"二八", @"二九", @"三十"
    ];
  }
  return _lunarChars;
}

- (FSCalendar *)calendar {
  if (!_calendar) {
    _calendar = ({
      FSCalendar *object = [[FSCalendar alloc]
                            initWithFrame:CGRectMake(0, 0, screenWidth,
                                                     screenHeight - NavigationContentTop -
                                                     SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
      object;
    });
    _calendar.delegate = self;
    _calendar.dataSource = self;
    _calendar.allowsMultipleSelection = YES;
    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    _calendar.pagingEnabled = NO;
    [_calendar appearance].borderRadius = 1;
    
    [_calendar appearance].headerDateFormat = @"yyyy年MM月";
    [_calendar registerClass:[LVCalendarCell class] forCellReuseIdentifier:cellID];
    
    [_calendar appearance].selectionColor = [UIColor colorWithHexString:@"#29B5EB"];
  }
  return _calendar;
}
@end
