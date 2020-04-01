//
// Created by blacksky on 2020/2/17.
// Copyright (c) 2020 blacksky. All rights reserved.
//

#import "BannerViewSpot.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
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
  self.banner.localizationImageNamesGroup = [self getArray];
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
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                     imageURLStringsGroup:[self getArray]];
    _banner.placeholderImage = self.datas[0];
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

- (NSArray *)getArray {
  return @[
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1585728804851&di="
    @"e8278d3456daec9c01baa3a4e6b5fa78&imgtype=0&src=http%3A%2F%2Fimg1.qunarzz.com%2Ftravel%2Fpoi%"
    @"2F1806%2F18%2F42413e19ce497737.jpg",
    @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/"
    @"u=1853571223,3568240217&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1585728804850&di="
    @"89cb8a957738b6143faac79c50bd76d5&imgtype=0&src=http%3A%2F%2Fb3-q.mafengwo.net%2Fs9%2FM00%"
    @"2F89%2FE3%2FwKgBs1efDaWAUfEYAAOi6EHRWcY30.jpeg%3FimageView2%2F2%2Fw%2F680%2Fq%2F90"
  ];
}
@end
