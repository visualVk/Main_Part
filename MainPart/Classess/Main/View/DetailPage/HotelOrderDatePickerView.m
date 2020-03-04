//
//  HotelOrderDatePickerView.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelOrderDatePickerView.h"
#import "CalerderViewController.h"
#import "MarkUtils.h"
#import "PeopleNumController.h"
#import <SJAttributesFactory.h>

@interface HotelOrderDatePickerView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) QMUIModalPresentationViewController *datePickCon;
;
@end

@implementation HotelOrderDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.days.layer.cornerRadius = self.days.frame.size.height / 2;
}

- (void)generateRootView {
  addView(self, self.stDate);
  addView(self, self.edDate);
  addView(self, self.days);
  addView(self, self.configuration);
  
  [@[ self.stDate, self.edDate, self.days, self.configuration ]
   mas_makeConstraints:^(MASConstraintMaker *make) { make.centerY.equalTo(self); }];
  
  [@[ self.stDate, self.days, self.edDate, self.configuration ]
   mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
   withFixedSpacing:SPACE
   leadSpacing:SPACE
   tailSpacing:SPACE];
  
  //  [self.stDate mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.leading.equalTo(self).with.inset(SPACE);
  //  }];
  //
  //  [self.days mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.leading.equalTo(self.stDate.mas_trailing).with.inset(SPACE);
  //  }];
  //
  //  [self.edDate mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.leading.equalTo(self.days.mas_trailing).with.inset(SPACE);
  //  }];
  //
  //  [self.configuration mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.leading.equalTo(self.edDate).with.inset(SPACE);
  //    make.trailing.equalTo(self).with.inset(SPACE);
  //  }];
}

- (QMUILabel *)stDate {
  if (!_stDate) {
    _stDate = [self generateCommonLabel];
    _stDate.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate:)];
    [_stDate addGestureRecognizer:tap];
  }
  return _stDate;
}

- (QMUILabel *)edDate {
  if (!_edDate) {
    _edDate = [self generateCommonLabel];
    _edDate.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate:)];
    [_edDate addGestureRecognizer:tap];
  }
  return _edDate;
}

- (QMUILabel *)days {
  if (!_days) {
    _days = [self generateCommonLabel];
    _days.highlightedBackgroundColor = nil;
    _days.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    _days.layer.borderColor = UIColor.qmui_randomColor.CGColor;
    _days.layer.borderWidth = 0.5;
    _days.layer.masksToBounds = YES;
  }
  return _days;
}

- (UILabel *)configuration {
  if (!_configuration) {
    _configuration = [UILabel new];
    _configuration.userInteractionEnabled = YES;
    _configuration.textAlignment = NSTextAlignmentCenter;
    _configuration.text = @"1间1人";
    _configuration.font = UIFontBoldMake(16);
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectConfiguration)];
    [_configuration addGestureRecognizer:tap];
  }
  return _configuration;
}

- (void)selectConfiguration {
  if (!self.parentController) self.parentController = [self qmui_viewController];
  PeopleNumController *pnCon = [PeopleNumController new];
  [self.parentController.navigationController pushViewController:pnCon animated:YES];
}

- (void)selectDate:(UITapGestureRecognizer *)gesture {
  CalerderViewController *cvCon = [CalerderViewController new];
  __weak __typeof(self) weakSelf = self;
  cvCon.selectedCalendarBlock =
  ^(NSString *startTime, NSDate *startDate, NSString *endTime, NSDate *endDate) {
    //点击finish 按钮,执行该代码块
    if (startDate && endTime) {
      weakSelf.stDate.text = [weakSelf generateDate:startDate];
      weakSelf.edDate.text = [weakSelf generateDate:endDate];
      weakSelf.days.text = [weakSelf generateDays:startDate edTime:endDate];
    }
  };
  cvCon.type = FullScreen;
  if (!self.parentController) { self.parentController = [self qmui_viewController]; }
  [self.parentController.navigationController pushViewController:cvCon animated:YES];
}

- (NSString *)generateDate:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"M月d日"];
  return [formatter stringFromDate:date];
}

- (QMUILabel *)generateCommonLabel {
  QMUILabel *label = [QMUILabel new];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = UIColor.qd_placeholderColor;
  label.highlightedTextColor = nil;
  label.font = UIFontBoldMake(16);
  return label;
}

- (void)loadData:(NSDictionary *)infoDict {
  NSDate *st = infoDict[@"stDate"];
  NSDate *ed = infoDict[@"edDate"];
  self.stDate.text = [self generateDate:st];
  self.edDate.text = [self generateDate:ed];
  self.days.text = [self generateDays:st edTime:ed];
  self.configuration.text =
  [NSString stringWithFormat:@"%@间%@人", infoDict[@"room"], infoDict[@"people"]];
}

- (NSString *)generateDays:(NSDate *)stTime edTime:(NSDate *)edTime {
  NSTimeInterval st = [stTime timeIntervalSince1970];
  NSTimeInterval et = [edTime timeIntervalSince1970];
  NSInteger days = (et - st) / 60 / 60 / 24;
  return [NSString stringWithFormat:@"%li天", days];
}
@end
