//
//  LeftCell.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LeftCell.h"
#import "MarkUtils.h"

@interface LeftCell ()
@end

@implementation LeftCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  //  self.selectionStyle = UITableViewCellSelectionStyleNone;
  addView(self.contentView, self.label);
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self.contentView);
    make.left.right.equalTo(self.contentView).with.inset(10);
  }];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if ([self isSelected]) {
    self.label.font = UIFontBoldMake(18);
  } else {
    self.label.font = UIFontMake(16);
    self.label.qmui_borderWidth = 0;
  }
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.selected = false;
}

- (UILabel *)label {
  if (!_label) {
    _label = [UILabel new];
    _label.font = UIFontMake(16);
    _label.text = @"默认";
    //    _label.textAlignment = ;
  }
  return _label;
}

- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView {
  [super setSelectedBackgroundView:selectedBackgroundView];
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//  if (highlighted) {
//    self.label.font = UIFontBoldMake(18);
//  } else {
//    self.label.font = UIFontMake(16);
//  }
//}
@end
