//
//  CheckInInfoCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CheckInInfoCell.h"
#import "MarkUtils.h"

@interface CheckInInfoCell () <GenerateEntityDelegate>

@end

@implementation CheckInInfoCell

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
  addView(superview, self.content);
  addView(superview, self.markImage);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(superview).multipliedBy(0.25);
    make.top.bottom.left.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.title.mas_trailing);
    make.trailing.equalTo(self.markImage.mas_leading);
    make.centerY.equalTo(self.title);
  }];
  
  [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.bottom.trailing.equalTo(superview).with.inset(0.5 * SPACE);
    make.centerY.equalTo(self.title);
    make.trailing.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"none";
    _title.textColor = UIColor.qd_placeholderColor;
    _title.font = UIFontMake(16);
  }
  return _title;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.text = @"none";
    _content.textColor = UIColor.qd_mainTextColor;
    _content.font = UIFontBoldMake(16);
  }
  return _content;
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
