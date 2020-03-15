//
//  MineQRCodeController.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineQRCodeController.h"
#import "MarkUtils.h"
#import "MineQrCodeView.h"
#import <LBXScanNative.h>

@interface MineQRCodeController () <GenerateEntityDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MineQRCodeController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  self.view.backgroundColor = UIColor.blackColor;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"个人二维码";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.scrollView);
  
  self.scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
  
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view);
  }];
}

- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = UIColor.clearColor;
    MineQrCodeView *qrView = [[MineQrCodeView alloc] initWithFrame:CGRectZero];
    qrView.qrString = @"星星点灯";
    addView(_scrollView, qrView);
    [qrView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_scrollView);
      make.left.right.equalTo(_scrollView).with.inset(SPACE);
      make.height.mas_equalTo(DEVICE_HEIGHT * 3 / 5);
    }];
  }
  return _scrollView;
}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
//转场效果
- (NSString *)customNavigationBarTransitionKey {
  return @"MineController";
}

#pragma mark - <QMUINavigationControllerAppearanceDelegate>
- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (UIImage *)navigationBarBackgroundImage {
  return [NavBarBackgroundImage qmui_imageWithAlpha:0];
}

- (UIImage *)navigationBarShadowImage {
  return [NavBarShadowImage qmui_imageWithAlpha:0];
}

- (UIColor *)navigationBarTintColor {
  return UIColor.whiteColor;
}

- (UIColor *)titleViewTintColor {
  return [self navigationBarTintColor];
}

@end
