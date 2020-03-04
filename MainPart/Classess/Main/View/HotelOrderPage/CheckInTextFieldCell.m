//
//  CheckInTextFieldCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CheckInTextFieldCell.h"
#import "MarkUtils.h"

@interface CheckInTextFieldCell () <GenerateEntityDelegate>

@end

@implementation CheckInTextFieldCell

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
  UIView *superview = self.contentView;
  addView(superview, self.title);
  addView(superview, self.inputText);
  addView(superview, self.markImage);
  
  //  self.markImage.hidden = YES;
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.leading.bottom.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(.25);
  }];
  
  [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.title.mas_trailing);
    make.top.bottom.equalTo(self.title);
    make.trailing.equalTo(self.markImage.mas_leading);
  }];
  
  [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(0.5 * SPACE);
    make.top.bottom.equalTo(self.title);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"xxx";
    _title.textColor = UIColor.qd_placeholderColor;
    _title.font = UIFontMake(16);
  }
  return _title;
}

- (QMUITextField *)inputText {
  if (!_inputText) {
    _inputText = [QMUITextField new];
    _inputText.font = UIFontBoldMake(16);
  }
  return _inputText;
}

- (UIImageView *)markImage {
  if (!_markImage) {
    _markImage = [UIImageView new];
    _markImage.image = UIImageMake(@"pay");
    _markImage.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _markImage;
}
@end
