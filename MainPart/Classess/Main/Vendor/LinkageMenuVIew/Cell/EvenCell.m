//
//  EvenCell.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "EvenCell.h"
#import "MarkUtils.h"

@interface EvenCell ()
@end

@implementation EvenCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.backgroundColor = UIColor.systemGrayColor;
  UIView *superview = self.contentView;
  addView(superview, self.title);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview);
    make.centerY.equalTo(superview);
  }];
  
  self.layer.borderColor = UIColor.clearColor.CGColor;
  self.layer.cornerRadius = 5;
  self.layer.masksToBounds = YES;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"热门冬令营";
    _title.textAlignment = NSTextAlignmentCenter;
  }
  return _title;
}
@end
