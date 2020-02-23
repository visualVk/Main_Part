//
// Created by blacksky on 2020/2/17.
// Copyright (c) 2020 blacksky. All rights reserved.
//

#import "BannerViewSpot.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#define BANNERHEIGHT DEVICE_HEIGHT / 5

@interface BannerViewSpot () <GenerateEntityDelegate>
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) QMUILabel *aimBtn;
@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation BannerViewSpot
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect frame = self.aimBtn.frame;
  QMUILogInfo(@"banner view spot", @"frame={x:%f,y:%f,width:%f,height:%f}", frame.origin.x,
              frame.origin.y, CGRectGetWidth(frame), CGRectGetHeight(frame));
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:[self
                                          selectorBlock:^(id _Nonnull args) { QMUILogInfo(@"tap", @"label tap"); }]];
  tap.numberOfTouchesRequired = 1;
  tap.numberOfTapsRequired = 1;
  self.aimBtn.userInteractionEnabled = YES;
  [self.aimBtn addGestureRecognizer:tap];
}

- (void)loadData {
  self.banner.localizationImageNamesGroup = self.datas;
  [self setNeedsLayout];
  [self layoutIfNeeded];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self, self.banner);
  addView(self, self.aimBtn);
  addView(self, self.imageview);
  
  [self.banner mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(self);
    make.height.greaterThanOrEqualTo(@(BANNERHEIGHT));
  }];
  
  [self.aimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self);
    make.width.equalTo(self).multipliedBy(0.8);
    make.bottom.equalTo(self.banner).offset(SPACE);
  }];
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.aimBtn).offset(-0.5 * SPACE);
    make.centerY.equalTo(self.aimBtn);
  }];
}

- (SDCycleScrollView *)banner {
  if (!_banner) {
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:self.datas];
    _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
  }
  return _banner;
}

- (QMUILabel *)aimBtn {
  if (!_aimBtn) {
    _aimBtn = [QMUILabel new];
    _aimBtn.text = @"当前位置:温州";
    _aimBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _aimBtn.textColor = UIColor.qd_mainTextColor;
    _aimBtn.font = UIFontBoldMake(18);
    _aimBtn.backgroundColor = UIColor.qd_backgroundColor;
    _aimBtn.layer.cornerRadius = 5;
    _aimBtn.layer.masksToBounds = YES;
  }
  return _aimBtn;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"locate");
  }
  return _imageview;
}
@end
