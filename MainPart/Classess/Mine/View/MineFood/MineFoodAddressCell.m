//
//  MineFoodAddressCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodAddressCell.h"
#import "MarkUtils.h"
#import "MineRoomChooseController.h"
const NSInteger LBIndex = 10000;
@interface MineFoodAddressCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *addressContainer;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIView *labelContainer;
@property (nonatomic, strong) NSString *curLableStr;
@end

@implementation MineFoodAddressCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.backgroundColor = UIColor.clearColor;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  //  self.labelContainer.layer.cornerRadius = self.sendLB.layer.cornerRadius =
  //  self.takeLB.layer.cornerRadius = self.labelContainer.frame.size.height / 2;
  //
  //  self.labelContainer.layer.cornerRadius = self.sendLB.layer.cornerRadius =
  //  self.takeLB.layer.cornerRadius = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(superview);
    make.left.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    addView(_container, self.labelContainer);
    addView(_container, self.addressContainer);
    
    [self.labelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(_container).with.inset(0.5 * SPACE);
      make.width.mas_equalTo(DEVICE_WIDTH * 3 / 7);
      make.height.mas_equalTo(DEVICE_HEIGHT / 25);
    }];
    
    [self.addressContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.labelContainer.mas_bottom).with.inset(0.5 * SPACE);
      make.left.right.equalTo(_container).with.inset(0.5 * SPACE);
      make.bottom.equalTo(_container).with.inset(0.5 * SPACE);
    }];
    
    [self.labelContainer setNeedsLayout];
    [self.labelContainer layoutIfNeeded];
  }
  return _container;
}

- (UIView *)addressContainer {
  if (!_addressContainer) {
    _addressContainer = [UIView new];
    _addressContainer.backgroundColor = UIColor.clearColor;
    addView(_addressContainer, self.addressLB);
    addView(_addressContainer, self.arrowImg);
    
    [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(_addressContainer);
      make.right.lessThanOrEqualTo(self.arrowImg.mas_left).with.inset(0.25 * SPACE);
    }];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_addressContainer);
      make.centerY.equalTo(_addressContainer);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick)];
    [_addressContainer addGestureRecognizer:tap];
  }
  return _addressContainer;
}

- (UIView *)labelContainer {
  if (!_labelContainer) {
    _labelContainer = [[UIView alloc] init];
    _labelContainer.backgroundColor = UIColor.qd_backgroundColor;
    addView(_labelContainer, self.sendLB);
    addView(_labelContainer, self.takeLB);
    
    [@[ self.sendLB, self.takeLB ] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                               withFixedSpacing:0
                                                    leadSpacing:0
                                                    tailSpacing:0];
    [self.sendLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_labelContainer);
    }];
    
    [self.takeLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.top.bottom.equalTo(_labelContainer);
    }];
    
    self.labelContainer.layer.cornerRadius = DEVICE_HEIGHT / 50;
    self.labelContainer.layer.masksToBounds = YES;
    self.labelContainer.clipsToBounds = YES;
  }
  return _labelContainer;
}

- (QMUILabel *)sendLB {
  if (!_sendLB) {
    _sendLB = [self generateNoHightedLabel];
    _sendLB.text = @"配送";
    _sendLB.textColor = UIColor.whiteColor;
    _sendLB.font = UIFontMake(18);
    _sendLB.backgroundColor = UIColor.qd_tintColor;
    _sendLB.textAlignment = NSTextAlignmentCenter;
    _sendLB.userInteractionEnabled = YES;
    _sendLB.tag = LBIndex;
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lBClick:)];
    [_sendLB addGestureRecognizer:tap];
  }
  return _sendLB;
}

- (QMUILabel *)takeLB {
  if (!_takeLB) {
    _takeLB = [self generateNoHightedLabel];
    _takeLB.text = @"自拿";
    _takeLB.textColor = UIColor.qd_tintColor;
    _takeLB.font = UIFontMake(18);
    _takeLB.backgroundColor = UIColor.clearColor;
    _takeLB.textAlignment = NSTextAlignmentCenter;
    _takeLB.userInteractionEnabled = YES;
    _takeLB.tag = LBIndex + 1;
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lBClick:)];
    [_takeLB addGestureRecognizer:tap];
  }
  return _takeLB;
}

- (QMUILabel *)addressLB {
  if (!_addressLB) {
    _addressLB = [self generateNoHightedLabel];
    _addressLB.text = @"xasdfasdadasdasdadasdadsda";
    _addressLB.numberOfLines = 0;
    _addressLB.textColor = UIColor.blackColor;
    _addressLB.font = UIFontBoldMake(22);
    _addressLB.userInteractionEnabled = self.isAddressEnable;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick)];
    [_addressLB addGestureRecognizer:tap];
  }
  return _addressLB;
}

- (UIImageView *)arrowImg {
  if (!_arrowImg) {
    _arrowImg = [UIImageView new];
    _arrowImg.image = UIImageMake(@"right-arrow-fill");
  }
  return _arrowImg;
}

- (QMUILabel *)generateNoHightedLabel {
  QMUILabel *label = [QMUILabel new];
  label.highlightedTextColor = nil;
  label.highlightedBackgroundColor = nil;
  return label;
}

#pragma mark - Click Listener
- (void)lBClick:(UITapGestureRecognizer *)tap {
  QMUILabel *view = tap.qmui_targetView;
  view.backgroundColor = UIColor.qd_tintColor;
  view.textColor = UIColor.whiteColor;
  QMUILabel *toView = nil;
  if (view.tag == LBIndex) {
    self.takeLB.backgroundColor = UIColor.clearColor;
    self.takeLB.textColor = UIColor.qd_tintColor;
    CheckInfo *checkinfo = self.model.checkInfo[0];
    self.addressLB.text = [NSString stringWithFormat:@"至 %@", self.curLableStr];
    self.addressContainer.userInteractionEnabled = self.isAddressEnable;
  } else if (view.tag == LBIndex + 1) {
    self.sendLB.backgroundColor = UIColor.clearColor;
    self.sendLB.textColor = UIColor.qd_tintColor;
    self.addressLB.text = [NSString stringWithFormat:@"到 %@", self.model.dinnerAddress];
    self.addressContainer.userInteractionEnabled = false;
  }
  //  toView.backgroundColor = UIColor.clearColor;
  //  toView.textColor = UIColor.qd_tintColor;
}

- (void)addressClick {
  QMUILogInfo(@"mine food address cell", @"address click");
  MineRoomChooseController *mrcCon = [MineRoomChooseController new];
  __weak __typeof(self) weakSelf = self;
  mrcCon.roomChooseBlock = ^(NSString *roomAddress) {
    weakSelf.curLableStr = roomAddress;
    weakSelf.addressLB.text = [NSString stringWithFormat:@"至 %@", roomAddress];
  };
  [[self qmui_viewController].navigationController pushViewController:mrcCon animated:YES];
}

- (void)setModel:(OrderCheckInfo *)model {
  _model = model;
  CheckInfo *checkinfo = model.checkInfo[0];
  self.curLableStr = checkinfo.roomAddress;
  self.addressLB.text = [NSString stringWithFormat:@"至 %@", checkinfo.roomAddress];
}

- (void)setIsAddressEnable:(BOOL)isAddressEnable {
  _isAddressEnable = isAddressEnable;
  self.addressContainer.userInteractionEnabled = isAddressEnable;
}
@end
