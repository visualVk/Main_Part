//
//  MineSportDeviceCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineSportDeviceCell.h"
#import "MarkUtils.h"
#define AVAILABLECOLOR [UIColorMakeWithHex(@"#27C82A") colorWithAlphaComponent:0.8]
#define UNAVAILABLECOLOR [UIColorMakeWithHex(@"#E03F3D") colorWithAlphaComponent:0.8]
#define AVAILABLETEXTCOLOR [UIColorMakeWithHex(@"#007602") colorWithAlphaComponent:0.8]
#define UNAVAILABLETEXTCOLOR [UIColorMakeWithHex(@"#B5250D") colorWithAlphaComponent:0.8]
@interface MineSportDeviceCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *circleContainer;
@property (nonatomic, strong) UIImageView *deviceImg;
@property (nonatomic, strong) UILabel *deviceName;
@property (nonatomic, strong) UILabel *deviceNum;
@end

@implementation MineSportDeviceCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.clearColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.container setNeedsLayout];
  [self.container layoutIfNeeded];
  
  self.container.layer.cornerRadius = self.container.frame.size.height / 2;
  self.container.layer.masksToBounds = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(superview);
    make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH / 3 - 40, DEVICE_WIDTH / 3 - 40));
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = AVAILABLECOLOR;
    addView(_container, self.deviceImg);
    addView(_container, self.deviceName);
    addView(_container, self.deviceNum);
    
    [self.deviceImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_container);
      make.centerX.equalTo(_container);
    }];
    
    [self.deviceName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.deviceImg.mas_bottom);
      make.centerX.equalTo(_container);
    }];
    
    [self.deviceNum mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.deviceName.mas_bottom);
      make.centerX.equalTo(_container);
    }];
    
    //
    //    [self.deviceImg mas_makeConstraints:^(MASConstraintMaker *make){make}];
    //    addView(_container, self.circleContainer);
    
    //    [self.circleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    //      //      make.center.equalTo(_container);
    //      make.top.equalTo(_container);}];
  }
  return _container;
}

- (UIView *)circleContainer {
  if (!_circleContainer) {
    _circleContainer = [UIView new];
    _circleContainer.backgroundColor = UIColor.clearColor;
    addView(_circleContainer, self.deviceImg);
    addView(_circleContainer, self.deviceName);
    addView(_circleContainer, self.deviceNum);
    [self.deviceImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(_circleContainer);
    }];
    [self.deviceName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.deviceImg.mas_bottom);
      make.centerX.equalTo(self.deviceImg);
    }];
    
    [self.deviceNum mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.deviceNum.mas_bottom);
      make.bottom.equalTo(_circleContainer);
    }];
  }
  return _circleContainer;
}

- (UIImageView *)deviceImg {
  if (!_deviceImg) {
    _deviceImg = [UIImageView new];
    _deviceImg.image = UIImageMake(@"sport_device");
  }
  return _deviceImg;
}

- (UILabel *)deviceName {
  if (!_deviceName) {
    _deviceName = [UILabel new];
    _deviceName.text = @"跑步机";
    _deviceName.textColor = UIColor.qd_backgroundColor;
    _deviceName.font = UIFontMake(18);
  }
  return _deviceName;
}

- (UILabel *)deviceNum {
  if (!_deviceNum) {
    _deviceNum = [UILabel new];
    _deviceNum.text = @"11 / 30";
    _deviceNum.textColor = AVAILABLETEXTCOLOR;
    _deviceNum.font = UIFontMake(20);
  }
  return _deviceNum;
}

- (void)setDevice:(Device *)device {
  _device = device;
  self.deviceName.text = device.deviceName;
  if (device.deviceUsedNum < device.deviceNum) {
    self.deviceNum.textColor = AVAILABLETEXTCOLOR;
    self.container.backgroundColor = AVAILABLECOLOR;
  } else {
    self.deviceNum.textColor = UNAVAILABLETEXTCOLOR;
    self.container.backgroundColor = UNAVAILABLECOLOR;
  }
  self.deviceNum.text =
  [NSString stringWithFormat:@"%li / %li", device.deviceUsedNum, device.deviceNum];
}
@end
