//
//  SimpleImageTitleView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SimpleImageTitleView.h"
#import "MarkUtils.h"

@implementation SimpleImageTitleView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.userInteractionEnabled = YES;
  UIView *container = [UIView new];
  container.userInteractionEnabled = false;
  addView(self, container);
  addView(container, self.image);
  addView(container, self.title);
  
  [container mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(self); }];
  
  [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(container);
    make.top.lessThanOrEqualTo(container);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(container);
    make.centerX.equalTo(container);
    make.top.equalTo(self.image.mas_bottom).with.inset(0.5 * SPACE);
    make.bottom.equalTo(container);
  }];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    //    _image.userInteractionEnabled = YES;
    _image.image = UIImageMake(@"pink_gradient");
    //    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    //    _title.userInteractionEnabled = YES;
    _title.text = @"全部订单";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontMake(14);
    _title.textAlignment = NSTextAlignmentCenter;
  }
  return _title;
}
@end
