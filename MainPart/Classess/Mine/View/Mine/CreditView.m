//
//  CreditView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CreditView.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <SJAttributesFactory.h>

@interface CreditView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIViewController *parentController;
@end

@implementation CreditView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.creditImg);
  addView(self, self.credit);
  addView(self, self.gain);
  addView(self, self.exchange);
  
  [self.creditImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(SPACE);
    make.centerY.equalTo(self.credit);
  }];
  
  [self.credit mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.left.equalTo(self.creditImg).with.inset(2 * SPACE);
    make.right.equalTo(self).with.inset(SPACE);
    make.top.equalTo(self).with.inset(0.5 * SPACE);
  }];
  
  [self.gain mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.creditImg);
    make.bottom.equalTo(self).with.inset(0.5 * SPACE);
  }];
  
  [self.exchange mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self).with.inset(SPACE);
    make.bottom.equalTo(self.gain);
  }];
}

- (UILabel *)credit {
  if (!_credit) {
    _credit = [UILabel new];
    _credit.numberOfLines = 0;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_mainTextColor).font(UIFontMake(22));
      make.append(@"积分:");
      make.append(@"1620").textColor(UIColor.qmui_randomColor).font(UIFontBoldMake(24));
    }];
    _credit.attributedText = str;
  }
  return _credit;
}

- (UILabel *)gain {
  if (!_gain) {
    _gain = [UILabel new];
    _gain.userInteractionEnabled = YES;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_tintColor)
      .font(UIFontMake(13))
      .underLine(^(id<SJUTDecoration> _Nonnull make) {
        make.style = NSUnderlinePatternSolid | NSUnderlineStyleThick;
        make.color = UIColor.qmui_randomColor;
      });
      make.append(@"如何获得");
    }];
    _gain.attributedText = str;
    [self addTap:_gain];
  }
  return _gain;
}

- (UILabel *)exchange {
  if (!_exchange) {
    _exchange = [UILabel new];
    _exchange.userInteractionEnabled = YES;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_tintColor)
      .font(UIFontMake(13))
      .underLine(^(id<SJUTDecoration> _Nonnull make) {
        make.style = NSUnderlinePatternSolid | NSUnderlineStyleThick;
        make.color = UIColor.qmui_randomColor;
      });
      make.append(@"兑换礼物");
    }];
    _exchange.attributedText = str;
    [self addTap:_exchange];
  }
  return _exchange;
}

- (UIImageView *)creditImg {
  if (!_creditImg) {
    _creditImg = [UIImageView new];
    _creditImg.image = UIImageMake(@"credit");
  }
  return _creditImg;
}

- (void)addTap:(UILabel *)label {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
  [label addGestureRecognizer:tap];
}

- (void)labelClick:(UITapGestureRecognizer *)gesture {
  UILabel *label = gesture.qmui_targetView;
  QMUILogInfo(@"credit view", @"click:%@", label.text);
}

@end
