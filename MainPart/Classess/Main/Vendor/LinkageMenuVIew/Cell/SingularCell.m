//
//  SingularCell.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SingularCell.h"
#import "MarkUtils.h"

@interface SingularCell ()
@end

@implementation SingularCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.imageview);
  addView(superview, self.title);
  
  [self.imageview
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  
  CGSize size = [self.title sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview);
    make.bottom.equalTo(superview).with.inset(10);
    make.height.mas_equalTo(size.height);
  }];
  
  superview.layer.borderColor = UIColor.clearColor.CGColor;
  superview.layer.cornerRadius = 10;
  superview.layer.masksToBounds = YES;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"pink_gradient");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imageview;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.textColor = UIColor.whiteColor;
    _title.font = UIFontMake(15);
    _title.text = @"滑雪胜地";
  }
  return _title;
}
@end
