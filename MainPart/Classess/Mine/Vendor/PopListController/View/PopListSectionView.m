//
//  PopListSectionView.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PopListSectionView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface PopListSectionView () <GenerateEntityDelegate>

@end

@implementation PopListSectionView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.clearColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.popListClear);
  addView(self, self.popListTitle);
  
  [@[ self.popListClear, self.popListTitle ] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.lessThanOrEqualTo(self);
    make.centerY.equalTo(self);
  }];
  
  [self.popListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(0.5 * SPACE);
  }];
  
  [self.popListClear mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).with.inset(0.5 * SPACE);
  }];
}

- (UILabel *)popListTitle {
  if (!_popListTitle) {
    _popListTitle = [UILabel new];
    _popListTitle.text = @"已选商品";
    _popListTitle.textColor = UIColor.qd_descriptionTextColor;
    _popListTitle.font = UIFontMake(15);
  }
  return _popListTitle;
}

- (UILabel *)popListClear {
  if (!_popListClear) {
    _popListClear = [UILabel new];
    _popListClear.attributedText =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_descriptionTextColor).font(UIFontMake(13));
      make.append(@"清空");
    }];
  }
  return _popListClear;
}
@end
