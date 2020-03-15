//
//  MineSportTitleCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineSportTitleCell.h"
#import "MarkUtils.h"

@interface MineSportTitleCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *title;
@end

@implementation MineSportTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_customBackgroundColor;
    addView(_container, self.title);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container).with.inset(0.25 * SPACE);
      make.centerY.equalTo(_container);
    }];
  }
  return _container;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.textColor = UIColorBlack;
    _title.font = UIFontMake(20);
    _title.text = @"拥有仪器";
  }
  return _title;
}
@end
