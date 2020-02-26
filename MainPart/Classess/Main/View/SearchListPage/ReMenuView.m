//
//  ReMenuView.m
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ReMenuView.h"

@interface ReMenuView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *moreImg;
@end

@implementation ReMenuView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  self.dragEnable = YES;
  self.isKeepBounds = YES;
//  self.backgroundColor = UIColor.qmui_randomColor;
  self.frame = CGRectMake(0, 0, DEVICE_WIDTH / 10, DEVICE_WIDTH / 10);
  self.center = CGPointMake(DEVICE_WIDTH * 19 / 20, DEVICE_HEIGHT * 5 / 6);
  self.layer.cornerRadius = DEVICE_WIDTH / 20;
  self.layer.borderColor = UIColor.clearColor.CGColor;
  self.layer.masksToBounds = YES;
  [self addSubview:self.moreImg];
}

- (UIImageView *)moreImg {
  if (!_moreImg) {
    _moreImg = [[UIImageView alloc] initWithFrame:self.frame];
    _moreImg.image = UIImageMake(@"add");
    _moreImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _moreImg;
}
@end
