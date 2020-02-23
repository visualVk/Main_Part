//
//  SpotHeader.m
//  LoginPart
//
//  Created by blacksky on 2020/2/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SpotHeader.h"
#import "MarkUtils.h"

@interface SpotHeader () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *title;
@end

@implementation SpotHeader

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
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
    make.left.equalTo(self).offset(0.5 * SPACE);
    make.centerY.equalTo(self);
  }];

}

- (QMUILabel *)title {
  if (!_title) {
    _title = [QMUILabel new];
    _title.font = UIFontBoldMake(24);
    _title.text = @"当季热门";
    _title.textColor = UIColor.qd_mainTextColor;
  }
  return _title;
}
@end
