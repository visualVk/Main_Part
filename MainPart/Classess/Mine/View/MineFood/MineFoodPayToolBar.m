//
//  MineFoodPayToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodPayToolBar.h"
#import "MarkUtils.h"
#import "PayMethodController.h"

@interface MineFoodPayToolBar () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) QMUIButton *payBtn;
@end

@implementation MineFoodPayToolBar

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
  addView(self, self.container);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    addView(_container, visualView);
    addView(_container, self.payPrice);
    addView(_container, self.payBtn);
    
    [visualView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
    
    [self.payPrice mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container).with.inset(SPACE);
      //      make.top.equalTo(_container).with.inset(0.5 * SPACE);
      make.centerY.equalTo(self.payBtn);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_container).with.inset(0.5 * SPACE);
      make.top.equalTo(_container).with.inset(0.5 * SPACE);
      make.bottom.equalTo(_container).with.inset(SafeAreaInsetsConstantForDeviceWithNotch.bottom);
    }];
  }
  return _container;
}

- (UILabel *)payPrice {
  if (!_payPrice) {
    _payPrice = [UILabel new];
    _payPrice.textColor = UIColor.qd_backgroundColor;
    _payPrice.font = UIFontMake(20);
    _payPrice.text = @"¥30";
  }
  return _payPrice;
}

- (QMUIButton *)payBtn {
  if (!_payBtn) {
    _payBtn = [QDUIHelper generateDarkFilledButton];
    [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_payBtn setBackgroundColor:UIColor.systemGreenColor];
    [_payBtn
     setHighlightedBackgroundColor:[UIColor.systemGreenColor qmui_transitionToColor:UIColorBlack
                                                                           progress:.15]];
    _payBtn.titleLabel.font = UIFontMake(18);
    _payBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_payBtn addTarget:self
                action:@selector(payClick)
      forControlEvents:UIControlEventTouchUpInside];
  }
  return _payBtn;
}

- (void)payClick {
  PayMethodController *pmCon = [PayMethodController new];
  pmCon.price = self.payPrice.text;
  [[self qmui_viewController].navigationController pushViewController:pmCon animated:YES];
}
@end
