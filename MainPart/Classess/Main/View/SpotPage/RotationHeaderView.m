//
//  RotationHeaderView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RotationHeaderView.h"
#import "MarkUtils.h"

@implementation RotationHeaderView

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
  addView(self, self.title);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self).offset(0.5 * SPACE);
    make.right.equalTo(self).offset(-0.5 * SPACE);
  }];
}

- (QMUILabel *)title {
  if (!_title) {
    _title = [QMUILabel new];
    _title.font = UIFontBoldMake(18);
    _title.text = @"优惠券";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.qmui_borderColor = UIColor.qd_mainTextColor;
    _title.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _title.backgroundColor = UIColor.clearColor;
    _title.highlightedBackgroundColor = nil;
  }
  return _title;
}
@end
