//
//  BannerZoomView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "BannerZoomView.h"
#import "MarkUtils.h"

@interface BannerZoomView () <SDCycleScrollViewDelegate, QMUIImagePreviewViewDelegate>
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) QMUIImagePreviewViewController *imagePreviewViewController;
@end

@implementation BannerZoomView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.userInteractionEnabled = YES;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.banner);
  [self.banner mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
  self.banner.delegate = self;
}

- (void)loadData {
  self.banner.localizationImageNamesGroup = self.datas;
}

- (SDCycleScrollView *)banner {
  if (!_banner) {
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:self.datas];
    //    _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _banner.showPageControl = false;
  }
  return _banner;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  //  //可放大视图区域
  //  UIView *contentView = [[UIView alloc]
  //                         initWithFrame:CGRectMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT / 2,
  //                         DEVICE_WIDTH, DEVICE_WIDTH)];
  //  contentView.backgroundColor = UIColor.clearColor;
  //  QMUIImagePreviewView *imagePre = [[QMUIImagePreviewView alloc] init];
  //  imagePre.delegate = self;
  //  addView(contentView, imagePre);
  //  [imagePre mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(contentView);
  //  }];
  //放大视图控制器
  if (!self.imagePreviewViewController) {
    self.imagePreviewViewController = [[QMUIImagePreviewViewController alloc] init];
    self.imagePreviewViewController.presentingStyle =
    QMUIImagePreviewViewControllerTransitioningStyleZoom;
    self.imagePreviewViewController.imagePreviewView.delegate = self;
  }
  if ([self.self_delegate respondsToSelector:@selector(presentZoomView:)]) {
    [self.imagePreviewViewController.imagePreviewView setCurrentImageIndex:self.index animated:YES];
    [self.self_delegate presentZoomView:self.imagePreviewViewController];
  }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
  self.index = index;
}
#pragma mark - QMUIImagePreviewViewDelegate
- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView
                             assetTypeAtIndex:(NSUInteger)index {
  return QMUIImagePreviewMediaTypeImage;
}

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
  return self.datas.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView
     renderZoomImageView:(QMUIZoomImageView *)zoomImageView
                 atIndex:(NSUInteger)index {
  zoomImageView.reusedIdentifier = @(index);
  UIImageView *imagev = [UIImageView new];
  [imagev sd_setImageWithURL:[NSURL URLWithString:self.datas[index]]
            placeholderImage:UIImageMake(@"pink_gradient")];
  zoomImageView.image = imagev.image;
  [zoomImageView hideEmptyView];
}

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView
                             location:(CGPoint)location {
  if ([self.self_delegate respondsToSelector:@selector(singleTouchInZoomingImageView:location:)]) {
    [self.self_delegate singleTouchInZoomingImageView:zoomImageView location:location];
  }
}
@end
