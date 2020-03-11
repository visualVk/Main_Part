//
//  CardBagView.m
//  MainPart
//
//  Created by blacksky on 2020/2/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CardBagView.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <SJAttributesFactory.h>

@interface CardBagView () <GenerateEntityDelegate>
@end

@implementation CardBagView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.cardImg);
  addView(self, self.cardTitle);
  
  [self.cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(0.5 * SPACE);
    make.centerY.equalTo(self);
  }];
  
  [self.cardTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self).with.inset(0.5 * SPACE);
    make.centerY.equalTo(self);
  }];
}

- (UIImageView *)cardImg {
  if (!_cardImg) {
    _cardImg = [UIImageView new];
    _cardImg.image = UIImageMake(@"pay");
  }
  return _cardImg;
}

- (UILabel *)cardTitle {
  if (!_cardTitle) {
    _cardTitle = [UILabel new];
    _cardTitle.numberOfLines = 0;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append(@"我的卡包\n").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
      make.append(@"个人特惠卡").textColor(UIColor.qd_placeholderColor).font(UIFontMake(14));
      make.alignment(NSTextAlignmentRight);
    }];
    _cardTitle.attributedText = str;
  }
  return _cardTitle;
}
@end
