//
//  WefareCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "WefareCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface WefareCell () <GenerateEntityDelegate>
@end

@implementation WefareCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.image);
  //  addView(superview, self.title);
  
  [self.image mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"navigationbar_background");
    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.numberOfLines = 0;
    _title.text = @"我,秦始皇,大钱";
    _title.font = UIFontBoldMake(14);
    _title.textColor = UIColor.qd_mainTextColor;
    addView(self.contentView, _title);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.contentView);
    }];
  }
  return _title;
}

@end
