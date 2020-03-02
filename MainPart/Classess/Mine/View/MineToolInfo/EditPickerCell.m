//
//  EditPickerCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "EditPickerCell.h"
#import "MarkUtils.h"

@interface EditPickerCell () <GenerateEntityDelegate>
@end

@implementation EditPickerCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.qmui_borderPosition = QMUIViewBorderPositionBottom;
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
  UIView *superview = self.contentView;
  addView(superview, self.title);
  addView(superview, self.content);
  addView(superview, self.image);
  
  [@[ self.title, self.content, self.image ] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(0.25);
  }];
  
  [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title.mas_right);
    make.trailing.equalTo(self.image.mas_leading);
  }];
  
  [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (BRDatePickerView *)datePicker {
  if (!_datePicker) {
    __weak __typeof(self) weakSelf = self;
    _datePicker = [[BRDatePickerView alloc] init];
    _datePicker.pickerMode = BRDatePickerModeYMD;
    _datePicker.title = @"选择时间";
    _datePicker.selectDate = [NSDate br_setYear:2019 month:10 day:30];
    _datePicker.minDate = [NSDate br_setYear:1949 month:3 day:12];
    _datePicker.maxDate = [NSDate date];
    _datePicker.isAutoSelect = YES;
    _datePicker.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
      NSLog(@"选择的值：%@", selectValue);
      weakSelf.content.text = selectValue;
      weakSelf.content.textColor = UIColor.qd_mainTextColor;
    };
    _datePicker.pickerStyle = [BRPickerStyle pickerStyleWithDoneTextColor:[UIColor blueColor]];
  }
  return _datePicker;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.textColor = UIColor.qd_separatorColor;
    _title.font = UIFontMake(18);
    _title.text = @"title";
  }
  return _title;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.userInteractionEnabled = YES;
    _content.text = @"content";
    _content.textColor = UIColor.qd_separatorColor;
    _content.font = UIFontMake(18);
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
    [_content addGestureRecognizer:tap];
  }
  return _content;
}

- (void)showDatePicker {
  [self.datePicker show];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.contentMode = QMUIImageResizingModeScaleAspectFit;
    _image.image = UIImageMake(@"more_bottom");
  }
  return _image;
}
@end
