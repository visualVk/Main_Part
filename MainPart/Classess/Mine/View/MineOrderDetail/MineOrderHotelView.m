//
//  MineOrderHotelView.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderHotelView.h"
#import "MarkUtils.h"

@interface MineOrderHotelView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *hotelContainer;
@end

@implementation MineOrderHotelView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.backgroundColor = UIColor.qd_backgroundColor;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.locateImage);
  addView(superview, self.hotelContainer);
  
  [self.locateImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.bottom.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(self.locateImage.mas_height);
    make.centerY.equalTo(superview);
  }];
  
  [self.hotelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.locateImage.mas_right);
    make.right.equalTo(superview);
    make.centerY.equalTo(superview);
    make.top.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)hotelContainer {
  if (!_hotelContainer) {
    _hotelContainer = [UIView new];
    addView(_hotelContainer, self.hotelName);
    addView(_hotelContainer, self.hotelAddress);
    addView(_hotelContainer, self.goHotelBtn);
    
    [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_hotelContainer).with.inset(SPACE);
      make.top.equalTo(_hotelContainer);
    }];
    
    [self.hotelAddress mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.hotelName.mas_bottom).with.inset(0.25 * SPACE);
      make.left.equalTo(self.hotelName);
      make.bottom.equalTo(_hotelContainer);
    }];
    
    [self.goHotelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      //      make.top.equalTo(self.hotelName).with.inset(0.25 * SPACE);
      make.centerY.equalTo(_hotelContainer);
      make.right.equalTo(_hotelContainer).with.inset(0.5 * SPACE);
    }];
  }
  return _hotelContainer;
}

- (UILabel *)hotelName {
  if (!_hotelName) {
    _hotelName = [UILabel new];
    _hotelName.text = @"温州荣欣楼大酒店";
    _hotelName.font = UIFontBoldMake(18);
    _hotelName.textColor = UIColor.qd_mainTextColor;
  }
  return _hotelName;
}

- (QMUIButton *)goHotelBtn {
  if (!_goHotelBtn) {
    _goHotelBtn = [QMUIButton new];
    _goHotelBtn.userInteractionEnabled = YES;
    [_goHotelBtn setTitle:@"详情" forState:UIControlStateNormal];
    _goHotelBtn.userInteractionEnabled = false;
    //    [_goHotelBtn addTarget:self
    //                    action:@selector(goHotelClick)
    //          forControlEvents:UIControlEventTouchUpInside];
  }
  return _goHotelBtn;
}

- (UILabel *)hotelAddress {
  if (!_hotelAddress) {
    _hotelAddress = [UILabel new];
    _hotelAddress.numberOfLines = 0;
    _hotelAddress.text = @"xxxxxasdadasda";
    _hotelAddress.textColor = UIColor.qd_mainTextColor;
    _hotelAddress.font = UIFontMake(15);
  }
  return _hotelAddress;
}

- (UIImageView *)locateImage {
  if (!_locateImage) {
    _locateImage = [UIImageView new];
    _locateImage.image = UIImageMake(@"pink_gradient");
    _locateImage.contentMode = QMUIImageResizingModeScaleToFill;
  }
  return _locateImage;
}

- (void)goHotelClick {
  QMUILogInfo(@"mine order hotel view", @"go hotel click");
}
@end
