//
//  MineOrderRoomInfoView.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderRoomInfoView.h"
#import "MarkUtils.h"
#import <LBXScanNative.h>

@interface MineOrderRoomInfoView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *backContainer;
@property (nonatomic, strong) UIImageView *backSwitchImage;
@end

@implementation MineOrderRoomInfoView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.qrCodeImage.image =
  [LBXScanNative createQRWithString:@"测试仪" QRSize:self.qrCodeImage.bounds.size];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  [superview insertSubview:self.backContainer belowSubview:self.container];
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0, 0.5 * SPACE, 0, 0);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.center.equalTo(superview);
    //    make.right.equalTo(superview);
    //    make.left.equalTo(superview).with.inset(0.5 * SPACE);
    //    make.size.lessThanOrEqualTo(superview);
    make.edges.equalTo(superview);
  }];
  
  [self.backContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(superview);
    make.edges.equalTo(superview);
  }];
}

- (void)prepareForReuse {
  [super prepareForReuse];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    addView(_container, self.roomName);
    addView(_container, self.room);
    addView(_container, self.roomStatus);
    addView(_container, self.liveDuration);
    addView(_container, self.price);
    addView(_container, self.switchPage);
    
    [@[ self.roomName, self.room, self.liveDuration ]
     mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container).with.inset(0.5 * SPACE);
    }];
    
    [@[ self.roomName, self.room, self.liveDuration ]
     mas_distributeViewsAlongAxis:MASAxisTypeVertical
     withFixedSpacing:0.25 * SPACE
     leadSpacing:0
     tailSpacing:0];
    
    [self.switchPage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.trailing.equalTo(_container);
      make.size.lessThanOrEqualTo(_container);
    }];
    
    [self.roomStatus mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_container).with.inset(0.5 * SPACE);
      make.top.equalTo(self.switchPage.mas_bottom).with.inset(0.25 * SPACE);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(self.roomStatus);
      make.centerY.equalTo(self.liveDuration);
    }];
    
    [@[ self.price, self.roomStatus ] mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.lessThanOrEqualTo(_container);
    }];
  }
  return _container;
}

- (UILabel *)roomName {
  if (!_roomName) {
    _roomName = [UILabel new];
    _roomName.text = @"豪华大床";
    _roomName.font = UIFontBoldMake(22);
    _roomName.textColor = UIColor.qd_mainTextColor;
  }
  return _roomName;
}

- (UILabel *)room {
  if (!_room) {
    _room = [UILabel new];
    _room.text = @"404";
    _room.font = UIFontMake(18);
    _room.textColor = UIColor.qd_mainTextColor;
  }
  return _room;
}

- (UILabel *)liveDuration {
  if (!_liveDuration) {
    _liveDuration = [UILabel new];
    _liveDuration.text = @"2018-02-02 至 2018-02-04";
    _liveDuration.textColor = UIColor.qd_placeholderColor;
    _liveDuration.font = UIFontMake(18);
  }
  return _liveDuration;
}

- (UILabel *)roomStatus {
  if (!_roomStatus) {
    _roomStatus = [UILabel new];
    _roomStatus.text = @"未入住";
    _roomStatus.textColor = UIColor.qmui_randomColor;
    _roomStatus.font = UIFontMake(18);
  }
  return _roomStatus;
}

- (UILabel *)price {
  if (!_price) {
    _price = [UILabel new];
    _price.textColor = UIColor.orangeColor;
    _price.font = UIFontMake(18);
    _price.text = @"¥199";
  }
  return _price;
}

- (UIImageView *)switchPage {
  if (!_switchPage) {
    _switchPage = [UIImageView new];
    _switchPage.userInteractionEnabled = YES;
    _switchPage.image = UIImageMake(@"switch_page");
    _switchPage.layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    _switchPage.layer.opacity = 0.45;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotationClick)];
    [_switchPage addGestureRecognizer:tap];
  }
  return _switchPage;
}

- (void)rotationClick {
  [MineOrderRoomInfoView transitformShowView:self.backContainer hiddenView:self.container];
}

#pragma mark - 背面
- (UIView *)backContainer {
  if (!_backContainer) {
    _backContainer = [UIView new];
    _backContainer.backgroundColor = UIColor.qd_backgroundColor;
    UILabel *label = [UILabel new];
    label.textColor = UIColor.qd_placeholderColor;
    label.font = UIFontMake(18);
    label.text = @"入住二维码证明，30分钟刷新一次";
    label.textAlignment = NSTextAlignmentCenter;
    addView(_backContainer, self.qrCodeImage);
    addView(_backContainer, label);
    addView(_backContainer, self.backSwitchImage);
    
    [self.qrCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_backContainer);
      make.bottom.equalTo(label.mas_top).with.inset(0.25 * SPACE);
      make.width.equalTo(self.qrCodeImage.mas_height);
      make.centerX.equalTo(label);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      //      make.top.equalTo(self.qrCodeImage.mas_bottom).with.inset(0.25 * SPACE);
      make.right.left.bottom.equalTo(_backContainer);
      make.height.lessThanOrEqualTo(_backContainer);
    }];
    
    [self.backSwitchImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.top.equalTo(_backContainer);
      make.size.lessThanOrEqualTo(_backContainer);
    }];
  }
  return _backContainer;
}

- (UIImageView *)qrCodeImage {
  if (!_qrCodeImage) {
    _qrCodeImage = [UIImageView new];
    _qrCodeImage.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _qrCodeImage;
}

- (UIImageView *)backSwitchImage {
  if (!_backSwitchImage) {
    _backSwitchImage = [UIImageView new];
    _backSwitchImage.userInteractionEnabled = YES;
    _backSwitchImage.image = UIImageMake(@"switch_page");
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToFront)];
    [_backSwitchImage addGestureRecognizer:tap];
  }
  return _backSwitchImage;
}

- (void)backToFront {
  [MineOrderRoomInfoView transitformShowView:self.container hiddenView:self.backContainer];
}

#pragma mark - 翻转动画
+ (void)transitformShowView:(UIView *)view hiddenView:(UIView *)toView {
  view.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 1, 0);
  toView.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 0);
  
  [UIView animateWithDuration:0.6
                        delay:0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{ toView.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 1, 0); }
                   completion:^(BOOL finished) {
    
    [view.superview bringSubviewToFront:view];
    
    [UIView
     animateWithDuration:0.6
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{ view.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0); }
     completion:nil];
    
  }];
}

- (void)resetStatus {
  self.container.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
  self.backContainer.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
  [self.container.superview bringSubviewToFront:self.container];
  
  POPSpringAnimation *transformSize =
  [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleY];
  transformSize.fromValue = @(0);
  transformSize.toValue = @(1);
  [self.contentView.layer pop_addAnimation:transformSize forKey:@"tran"];
}
@end
