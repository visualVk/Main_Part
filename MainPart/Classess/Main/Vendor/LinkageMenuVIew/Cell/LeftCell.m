//
//  LeftCell.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LeftCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface LeftCell ()
@end

@implementation LeftCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  //  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
  addView(self.contentView, self.label);
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self.contentView).with.inset(5);
    make.left.right.equalTo(self.contentView);
  }];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  NSString *text = self.label.text;
  if ([self isSelected]) {
    self.label.font = UIFontMake(16);
    self.label.textColor = UIColorBlack;
    self.label.qmui_borderWidth = 4;
    self.label.qmui_borderPosition = QMUIViewBorderPositionLeft;
    self.label.qmui_borderColor = UIColor.orangeColor;
    //    NSAttributedString *str =
    //    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    //      make.font(UIFontMake(18))
    //      .textColor(UIColor.qmui_randomColor)
    //      .shadow(^(NSShadow *_Nonnull make) {
    //        make.shadowOffset = CGSizeMake(1, 1);
    //        make.shadowColor = UIColor.qd_mainTextColor;
    //        make.shadowBlurRadius = 0.5;
    //      });
    //      make.append(text).underLine(^(id<SJUTDecoration> _Nonnull make) {
    //        make.style = NSUnderlinePatternSolid | NSUnderlineStyleThick;
    //        make.color = UIColor.qmui_randomColor;
    //      });
    //    }];
    //    self.label.attributedText = str;
  } else {
    self.label.attributedText = nil;
    self.label.text = text;
    self.label.font = UIFontLightMake(14);
    self.label.qmui_borderWidth = 0;
  }
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.selected = false;
}

- (QMUILabel *)label {
  if (!_label) {
    _label = [QMUILabel new];
    _label.font = UIFontLightMake(14);
    _label.text = @"默认";
    _label.textColor = UIColorBlack;
    _label.highlightedTextColor = nil;
    _label.highlightedBackgroundColor = nil;
    _label.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
  }
  return _label;
}

//- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView {
//  [super setSelectedBackgroundView:selectedBackgroundView];
//}
@end
