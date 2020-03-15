//
//  MineSportDeviceHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineSportDeviceHeaderView.h"
#import "MarkUtils.h"

@interface MineSportDeviceHeaderView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) UILabel *openTime;
@property (nonatomic, strong) UILabel *hotelDescription;
@end

@implementation MineSportDeviceHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.container);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.sportImg);
    addView(_container, self.hotelName);
    addView(_container, self.openTime);
    //    addView(_container, self.hotelDescription);
    
    //    [self.sportImg
    //     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
    
    [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_container).with.inset(0.5 * SPACE);
      make.bottom.equalTo(self.openTime.mas_top).with.inset(0.25 * SPACE);
    }];
    
    [self.openTime mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_container).with.inset(SPACE);
      make.bottom.equalTo(_container).with.inset(0.5 * SPACE);
    }];
    
    //    [self.hotelDescription mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.right.equalTo(_container).with.inset(SPACE);
    //      make.width.equalTo(_container).multipliedBy(0.75);
    //      make.top.equalTo(self.openTime.mas_bottom);
    //      make.bottom.lessThanOrEqualTo(_container);
    //    }];
  }
  return _container;
}

- (UIImageView *)sportImg {
  if (!_sportImg) {
    _sportImg = [[UIImageView alloc]
                 initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 220.0 / 414 * DEVICE_WIDTH)];
    _sportImg.image = UIImageMake(@"sport_background");
    _sportImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _sportImg;
}
- (UILabel *)hotelName {
  if (!_hotelName) {
    _hotelName = [UILabel new];
    _hotelName.text = @"xfada";
    _hotelName.textColor = UIColor.whiteColor;
    _hotelName.font = UIFontMake(30);
  }
  return _hotelName;
}

- (UILabel *)openTime {
  if (!_openTime) {
    _openTime = [UILabel new];
    _openTime.text = @"adsasdsaasd";
    _openTime.textColor = [UIColorMakeWithHex(@"9EDD0B") colorWithAlphaComponent:0.8];
    _openTime.font = UIFontMake(21);
  }
  return _openTime;
}

- (UILabel *)hotelDescription {
  if (!_hotelDescription) {
    _hotelDescription = [UILabel new];
    _hotelDescription.numberOfLines = 0;
    _hotelDescription.textColor = [UIColorMakeWithHex(@"F4ECEC") colorWithAlphaComponent:0.8];
    _hotelDescription.font = UIFontMake(21);
  }
  return _hotelDescription;
}

- (void)setModel:(HotelDevice *)model {
  _model = model;
  self.hotelName.text = model.hotelName;
  self.openTime.text = [NSString stringWithFormat:@"开放时间:%@-%@", model.stDate, model.edDate];
  //  self.hotelDescription.text = model.deviceDescription;
}

- (void)zoomImage {
  if ([self.delegate respondsToSelector:@selector(zoomView:)]) {
    [self.delegate zoomView:self.sportImg];
  }
}
@end
