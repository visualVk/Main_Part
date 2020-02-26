//
//  LinkageFooter.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageFooter.h"
#import "MarkUtils.h"

@interface LinkageFooter ()
@property (nonatomic, strong) UIImageView *image;
@end

@implementation LinkageFooter

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    addView(self, self.image);
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self).priority(100);
    }];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"border");
    _image.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _image;
}
@end
