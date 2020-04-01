//
//  LoginMainButton.m
//  LoginPart
//
//  Created by blacksky on 2020/4/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LoginMainButton.h"
#import "MarkUtils.h"

@interface LoginMainButton () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *label;
@end

@implementation LoginMainButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self addGestureRecognizer:tap];
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
    _container.backgroundColor = UIColor.systemGreenColor;
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = YES;
    addView(_container, self.pic);
    addView(_container, self.label);
    
    [self.pic mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(_container).with.inset(20);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.centerX.equalTo(_container);
      make.right.lessThanOrEqualTo(_container);
    }];
  }
  return _container;
}

- (UIImageView *)pic {
  if (!_pic) {
    _pic = [UIImageView new];
    _pic.image = UIImageMake(@"weixin");
  }
  return _pic;
}

- (UILabel *)label {
  if (!_label) {
    _label = [UILabel new];
    _label.text = @"使用";
    _label.font = UIFontBoldMake(16);
    _label.textColor = UIColor.whiteColor;
    _label.textAlignment = NSTextAlignmentCenter;
  }
  return _label;
}

- (void)tapPress:(UITapGestureRecognizer *)tap {
  UIView *view = tap.qmui_targetView;
  if ([self.delegate respondsToSelector:@selector(tap:)]) { [self.delegate tap:view]; }
}
@end
