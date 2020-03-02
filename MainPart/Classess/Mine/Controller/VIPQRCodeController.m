//
//  VIPQRCodeController.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "VIPQRCodeController.h"
#import "LBXScanNative.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface VIPQRCodeController () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *powerQrCodeImage;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation VIPQRCodeController

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
  self.powerQrCodeImage.image =
  [LBXScanNative createQRWithString:@"星星点灯" QRSize:self.powerQrCodeImage.bounds.size];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"会员权益码";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.powerQrCodeImage);
  addView(self.view, self.refreshLabel);
  
  [self.powerQrCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.width.equalTo(self.view).multipliedBy(6.0 / 7);
    make.height.equalTo(self.powerQrCodeImage.mas_width);
  }];
  
  [self.refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.powerQrCodeImage.mas_bottom).with.inset(0.5 * SPACE);
    make.centerX.equalTo(self.view);
  }];
}

- (UIImageView *)powerQrCodeImage {
  if (!_powerQrCodeImage) {
    _powerQrCodeImage = [UIImageView new];
    _powerQrCodeImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    addView(_powerQrCodeImage, self.logo);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_powerQrCodeImage);
      make.height.width.mas_equalTo(30);
    }];
  }
  return _powerQrCodeImage;
}

- (UIImageView *)logo {
  if (!_logo) {
    _logo = [UIImageView new];
    _logo.image = UIImageMake(@"power");
    _logo.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _logo;
}

- (UILabel *)refreshLabel {
  if (!_refreshLabel) {
    _refreshLabel = [UILabel new];
    _refreshLabel.userInteractionEnabled = YES;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"more_bottom");
        make.alignment = SJUTVerticalAlignmentCenter;
      });
      make.append(@"\t刷新会员码").textColor(UIColor.qd_tintColor).font(UIFontMake(14));
    }];
    _refreshLabel.attributedText = str;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeQRCode)];
    [_refreshLabel addGestureRecognizer:tap];
  }
  return _refreshLabel;
}

- (void)changeQRCode {
  self.powerQrCodeImage.image =
  [LBXScanNative createQRWithString:@"dfad1" QRSize:self.powerQrCodeImage.bounds.size];
}
@end
