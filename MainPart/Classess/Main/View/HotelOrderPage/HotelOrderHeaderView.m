
//
//  HotelOrderHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelOrderHeaderView.h"
#import "MarkUtils.h"

@interface HotelOrderHeaderView () <GenerateEntityDelegate>

@end

@implementation HotelOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.image.frame = CGRectMake(0, 0, DEVICE_WIDTH, NavigationBarHeight);
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.image);
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"navigationbar_background");
    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (void)didScrollView:(CGPoint)offset {
  if (offset.y < 0) {
    self.image.frame =
    CGRectMake(offset.y, offset.y, DEVICE_WIDTH - 2 * offset.y, NavigationBarHeight - offset.y);
  } else {
    self.image.frame = CGRectMake(0, 0, DEVICE_WIDTH, NavigationBarHeight);
  }
}
@end
