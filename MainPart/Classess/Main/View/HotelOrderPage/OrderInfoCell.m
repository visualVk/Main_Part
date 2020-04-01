//
//  OrderInfoCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderInfoCell.h"
#import "CheckInInfoCell.h"
#import "CheckInTextFieldCell.h"
#import "MarkUtils.h"
#import "PeopleNumController.h"
#import <BRStringPickerView.h>
#define CHECKININFOCELL @"checkininfocell"
#define CHECKINTEXTFIELDCELL @"checkintextfieldcell"

@interface OrderInfoCell () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource> {
  NSString *_date;
  NSInteger _roomNum;
}
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIViewController *parentController;
@end

@implementation OrderInfoCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  //  addView(self.contentView, self.tableView);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).with.insets(padding);
    make.height.mas_equalTo(4 * DEVICE_HEIGHT / 15);
  }];
}

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:CheckInInfoCell.class forCellReuseIdentifier:CHECKININFOCELL];
    [_tableView registerClass:CheckInTextFieldCell.class
       forCellReuseIdentifier:CHECKINTEXTFIELDCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.cornerRadius = 8;
    _tableView.layer.masksToBounds = YES;
    addView(self.contentView, _tableView);
    
    UIView *shadowView = [UIView new];
    shadowView.layer.shadowRadius = 8;
    shadowView.backgroundColor = UIColor.qd_backgroundColor;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowOpacity = 0.25;
    shadowView.layer.borderColor = UIColor.clearColor.CGColor;
    [self.contentView insertSubview:shadowView belowSubview:_tableView];
    [shadowView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_tableView); }];
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  if (row == 1) {
    CheckInInfoCell *ciCell =
    [tableView dequeueReusableCellWithIdentifier:CHECKININFOCELL forIndexPath:indexPath];
    ciCell.title.text = @"房间数";
    ciCell.content.text = [NSString stringWithFormat:@"%li", _roomNum];
    return ciCell;
  }
  if (row == 2) {
    CheckInInfoCell *ciCell =
    [tableView dequeueReusableCellWithIdentifier:CHECKININFOCELL forIndexPath:indexPath];
    ciCell.title.text = @"住客信息";
    ciCell.content.text = @"小a";
    return ciCell;
  }
  if (row == 3) {
    CheckInInfoCell *ciCell =
    [tableView dequeueReusableCellWithIdentifier:CHECKININFOCELL forIndexPath:indexPath];
    ciCell.title.text = @"预计到店";
    if (_date || [_date isEqualToString:@""]) {
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"HH:mm"];
      NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
      ciCell.content.text = strDate;
    } else {
      ciCell.content.text = _date;
    }
    return ciCell;
  }
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  cell.textLabel.text = @"入住信息";
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  if (!self.parentController) self.parentController = [self qmui_viewController];
  if (row == 1) { [self selectNum:indexPath]; }
  if (row == 3) { [self selectHours:indexPath]; }
}

- (void)selectNum:(NSIndexPath *)indexPath {
  PeopleNumController *pnCon = [PeopleNumController new];
  __weak __typeof(self) weakSelf = self;
  pnCon.pepleSelectBlock = ^(NSInteger num) {
    _roomNum = num;
    [weakSelf.tableView reloadRowsAtIndexPaths:@[ indexPath ]
                              withRowAnimation:UITableViewRowAnimationNone];
  };
  [self.parentController.navigationController pushViewController:pnCon animated:YES];
}

- (void)selectHours:(NSIndexPath *)indexPath {
  NSDate *curHour = [NSDate date];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"H";
  NSString *curHourStr = [formatter stringFromDate:curHour];
  NSInteger hours = [curHourStr integerValue];
  NSMutableArray *hourList = [NSMutableArray arrayWithCapacity:12];
  for (int i = 0; i < 12; i++) {
    [hourList addObject:[NSString stringWithFormat:@"%@:00", [[NSNumber numberWithInteger:hours + i]
                                                              stringValue]]];
  }
  __weak __typeof(self) weakSelf = self;
  BRStringPickerView *datePicker = [[BRStringPickerView alloc] init];
  datePicker.pickerMode = BRStringPickerComponentSingle;
  datePicker.title = @"选择预计到达时间";
  datePicker.dataSourceArr = hourList;
  datePicker.selectIndex = 0;
  datePicker.resultModelBlock = ^(BRResultModel *resultModel) {
    QMUILogInfo(@"order info cell", @"选择的值：%@", resultModel.value);
    _date = resultModel.value;
    [weakSelf.tableView reloadRowsAtIndexPaths:@[ indexPath ]
                              withRowAnimation:UITableViewRowAnimationNone];
  };
  [datePicker show];
}
@end
