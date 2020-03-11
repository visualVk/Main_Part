//
//  SimpleImageTitleCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SimpleImageTitleCell.h"
#import "MarkUtils.h"

@interface SimpleImageTitleCell ()
@property (nonatomic, strong) UIView *container;
@end

@implementation SimpleImageTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.clipsToBounds = YES;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  
  addView(superview, self.container);
  
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(superview); }];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"pink_gradient");
    //    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"全部订单";
    _title.numberOfLines = 0;
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontMake(14);
    _title.textAlignment = NSTextAlignmentCenter;
  }
  return _title;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.clearColor;
    addView(_container, self.image);
    addView(_container, self.title);
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_container);
      make.right.lessThanOrEqualTo(_container);
      make.left.greaterThanOrEqualTo(_container);
      make.centerX.equalTo(_container);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.image.mas_bottom).with.inset(0.25 * SPACE);
      make.leading.trailing.equalTo(_container);
      make.bottom.equalTo(_container);
    }];
  }
  return _container;
}
@end
