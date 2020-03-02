//
//  EditInfoCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "EditInfoCell.h"
#import "MarkUtils.h"

@interface EditInfoCell () <GenerateEntityDelegate>

@end

@implementation EditInfoCell

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
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(0.25);
  }];
  
  [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title.mas_right);
    make.top.bottom.equalTo(self.title);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"名字";
    _title.textColor = UIColor.qd_placeholderColor;
    _title.font = UIFontMake(18);
  }
  return _title;
}

- (QMUITextField *)content {
  if (!_content) {
    _content = [QMUITextField new];
    _content.placeholder = @"请输入";
    _content.clearButtonMode = UITextFieldViewModeAlways;
  }
  return _content;
}
@end
