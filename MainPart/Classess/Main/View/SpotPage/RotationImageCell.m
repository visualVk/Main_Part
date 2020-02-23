//
//  RotationImageCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RotationImageCell.h"
#import "MarkUtils.h"

@interface RotationImageCell () <GenerateEntityDelegate>
@end

@implementation RotationImageCell

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
  [self.imageview
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"ticket");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imageview;
}
@end
