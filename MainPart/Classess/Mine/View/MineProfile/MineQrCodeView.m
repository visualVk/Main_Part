//
//  MineQrCodeView.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineQrCodeView.h"
#import "MarkUtils.h"
#import <LBXScanNative.h>

@interface MineQrCodeView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *refreshContainer;
@end

@implementation MineQrCodeView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    self.layer.borderColor = UIColor.clearColor.CGColor;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.qrCodeImg.image =
  [LBXScanNative createQRWithString:self.qrString QRSize:self.qrCodeImg.bounds.size];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self, self.avatarImg);
  addView(self, self.username);
  addView(self, self.locate);
  addView(self, self.qrCodeImg);
  addView(self, self.detailLB);
  addView(self, self.refreshContainer);
  
  [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(self).with.inset(SPACE);
    make.height.width.mas_equalTo(DEVICE_HEIGHT / 15);
  }];
  
  [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.avatarImg.mas_centerY).with.inset(2.5);
    make.left.equalTo(self.avatarImg.mas_right).with.inset(0.25 * SPACE);
  }];
  
  [self.locate mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.username);
    make.top.equalTo(self.username.mas_bottom).with.inset(5);
  }];
  
  [self.qrCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.equalTo(self.avatarImg.mas_bottom).with.inset(3 * SPACE);
    make.right.left.equalTo(self).with.inset(SPACE);
    make.height.equalTo(self.qrCodeImg.mas_width);
    make.bottom.equalTo(self.detailLB.mas_top).with.inset(SPACE);
  }];
  
  [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.equalTo(self.qrCodeImg.mas_bottom).with.inset(SPACE);
    make.centerX.equalTo(self.qrCodeImg);
    make.bottom.equalTo(self.refreshContainer.mas_top).with.inset(SPACE);
  }];
  
  [self.refreshContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self).with.inset(0.75 * SPACE);
    //    make.top.equalTo(self.detailLB.mas_bottom).with.inset(SPACE);
    make.bottom.equalTo(self).with.inset(SPACE);
  }];
}

- (UIImageView *)avatarImg {
  if (!_avatarImg) {
    _avatarImg = [UIImageView new];
    _avatarImg.layer.cornerRadius = 5;
    _avatarImg.image = UIImageMake(@"pink_gradient");
    _avatarImg.contentMode = QMUIImageResizingModeScaleAspectFill;
    _avatarImg.layer.masksToBounds = YES;
  }
  return _avatarImg;
}

- (UILabel *)username {
  if (!_username) {
    _username = [UILabel new];
    _username.text = @"aaa";
    _username.textColor = UIColor.blackColor;
    _username.font = UIFontMake(16);
  }
  return _username;
}

- (UILabel *)locate {
  if (!_locate) {
    _locate = [UILabel new];
    _locate.text = @"浙江 温州";
    _locate.textColor = UIColor.qd_placeholderColor;
    _locate.font = UIFontMake(15);
  }
  return _locate;
}

- (UIImageView *)qrCodeImg {
  if (!_qrCodeImg) {
    _qrCodeImg = [UIImageView new];
    _qrCodeImg.contentMode = QMUIImageResizingModeScaleAspectFill;
    _qrCodeImg.layer.masksToBounds = YES;
    UIImageView *centerImg = [[UIImageView alloc] initWithImage:self.avatarImg.image];
    centerImg.layer.cornerRadius = 5;
    centerImg.layer.borderColor = UIColor.whiteColor.CGColor;
    centerImg.layer.borderWidth = 3;
    centerImg.layer.masksToBounds = YES;
    addView(self.qrCodeImg, centerImg);
    [centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_qrCodeImg);
      make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
  }
  return _qrCodeImg;
}

- (UILabel *)detailLB {
  if (!_detailLB) {
    _detailLB = [UILabel new];
    _detailLB.text = @"酒店通行码";
    _locate.textColor = UIColor.qd_placeholderColor;
    _locate.font = UIFontMake(20);
  }
  return _detailLB;
}

- (UILabel *)refreshLB {
  if (!_refreshLB) {
    _refreshLB = [UILabel new];
    _refreshLB.font = UIFontMake(16);
    _refreshLB.text = @"刷新通行码";
  }
  return _refreshLB;
}

- (UIView *)refreshContainer {
  if (!_refreshContainer) {
    _refreshContainer = [UIView new];
    _refreshContainer.backgroundColor = UIColor.clearColor;
    _refreshContainer.layer.borderColor = UIColor.qd_tintColor.CGColor;
    _refreshContainer.layer.cornerRadius = 5;
    _refreshContainer.layer.borderWidth = 1;
    _refreshContainer.layer.masksToBounds = YES;
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = UIImageMake(@"key");
    addView(_refreshContainer, imageview);
    addView(_refreshContainer, self.refreshLB);
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_refreshContainer).with.inset(0.5 * SPACE);
      make.right.equalTo(self.refreshLB.mas_left);
    }];
    
    [self.refreshLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_refreshContainer);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshClick)];
    [_refreshContainer addGestureRecognizer:tap];
  }
  return _refreshContainer;
}

- (void)refreshClick {
}
@end
