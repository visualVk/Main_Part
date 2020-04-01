//
//  ImageAndLabelCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ImageAndLabelCell.h"
#import "MarkUtils.h"
@interface ImageAndLabelCell () <GenerateEntityDelegate>

@end

@implementation ImageAndLabelCell

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
  UIView *superview = self.contentView;
  if (!self.imageview) {
    self.imageview = [UIImageView new];
    self.imageview.image = UIImageMake(@"icon_grid_toast");
    
    self.imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  if (!self.label) {
    self.label = [UILabel new];
    self.label.font = UIFontMake(12);
    self.label.text = @"all";
    self.label.textColor = UIColorBlack;
  }
  
  addView(self.contentView, self.imageview);
  addView(self.contentView, self.label);
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).with.inset(5);
    make.centerX.offset(0);
    //    make.size.lessThanOrEqualTo(superview);
    make.width.equalTo(self.imageview.mas_height);
    make.bottom.equalTo(self.label.mas_top).with.inset(5);
    //    make.height.greaterThanOrEqualTo(superview.mas_height).multipliedBy(0.4);
    //    make.bottom.equalTo(self.label).offset(-10);
    //    make.width.equalTo(self.imageview.mas_height);
  }];
  CGSize size = [self.label sizeThatFits:CGSizeMake(DEVICE_WIDTH / 4, MAXFLOAT)];
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.height.lessThanOrEqualTo(superview.mas_height).multipliedBy(0.4);
    make.bottom.equalTo(superview.mas_bottom).with.inset(5);
    make.height.mas_equalTo(size.height);
    make.centerX.offset(0);
  }];
}

@end
