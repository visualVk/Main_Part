//
//  ItemBasicInfoCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/20.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ItemBasicInfoCell.h"
#import "MapController.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"

@interface ItemBasicInfoCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *itemNameLB;
@property (nonatomic, strong) QMUIFloatLayoutView *tagFlow;
@property (nonatomic, strong) UILabel *foundTimeLB;
@property (nonatomic, strong) UILabel *scoreAndRemarkLB;
@property (nonatomic, strong) QMUIButton *itemNameBtn;
@property (nonatomic, strong) QMUIButton *remarkBtn;
@property (nonatomic, strong) UILabel *addressLB;
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UILabel *locateLB;
@property (nonatomic, strong) UIView *itemNameView;
@property (nonatomic, strong) UIView *scoreView;
@property (nonatomic, strong) UIView *addressView;
@end

@implementation ItemBasicInfoCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  UIView *container = [UIView new];
  container.layer.cornerRadius = 10.0f;
  container.layer.masksToBounds = YES;
  container.backgroundColor = UIColor.qd_customBackgroundColor;
  addView(superview, container);
  [container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview);
    make.width.equalTo(@(DEVICE_WIDTH - SPACE));
    make.top.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(superview).offset(-0.5 * SPACE);
  }];
  
  [self generateItemView:container];
  [self generateScoreView:container];
  [self generateAddressView:container];
}

- (void)generateItemView:(UIView *)superview {
  addView(superview, self.itemNameView);
  addView(self.itemNameView, self.itemNameLB);
  addView(self.itemNameView, self.foundTimeLB);
  addView(self.itemNameView, self.itemNameBtn);
  
  [self.itemNameView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.top.right.left.equalTo(superview); }];
  
  [self.itemNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.itemNameView).offset(0.5 * SPACE);
  }];
  
  [self.foundTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.itemNameLB);
    make.centerY.equalTo(self.itemNameBtn);
  }];
  
  [self.itemNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.greaterThanOrEqualTo(self.itemNameLB.mas_bottom);
    make.right.equalTo(self.itemNameView).offset(-0.5 * SPACE);
    make.bottom.equalTo(self.itemNameView.mas_bottom).offset(-0.5 * SPACE);
  }];
}

- (void)generateScoreView:(UIView *)superview {
  self.scoreView.qmui_borderColor = UIColor.qd_separatorColor;
  self.scoreView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
  addView(superview, self.scoreView);
  addView(self.scoreView, self.scoreAndRemarkLB);
  addView(self.scoreView, self.remarkBtn);
  
  [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.itemNameView.mas_bottom);
    make.left.right.equalTo(self.itemNameView);
  }];
  
  [self.scoreAndRemarkLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.scoreView).offset(0.5 * SPACE);
    make.bottom.equalTo(self.scoreView).offset(-0.5 * SPACE);
    make.right.lessThanOrEqualTo(self.remarkBtn.mas_left);
  }];
  
  [self.remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.scoreView);
    make.right.equalTo(self.scoreView).offset(-0.5 * SPACE);
    
  }];
}

- (void)generateAddressView:(UIView *)superview {
  addView(superview, self.addressView);
  addView(self.addressView, self.addressLB);
  addView(self.addressView, self.addressImg);
  addView(self.addressView, self.locateLB);
  
  [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.scoreView);
    make.top.equalTo(self.scoreView.mas_bottom);
    make.bottom.equalTo(superview);
  }];
  
  [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.addressView).offset(0.5 * SPACE);
    make.width.equalTo(self.addressView).multipliedBy(4.0 / 5);
    make.top.equalTo(self.addressImg);
  }];
  
  [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.addressView).offset(0.5 * SPACE);
    make.centerX.equalTo(self.locateLB);
  }];
  
  [self.locateLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.addressView).offset(-0.5 * SPACE);
    make.top.equalTo(self.addressImg.mas_bottom);
    make.bottom.equalTo(self.addressView).offset(-0.5 * SPACE);
  }];
}

#pragma mark - Lazy Init
- (UILabel *)itemNameLB {
  if (!_itemNameLB) {
    _itemNameLB = [ItemBasicInfoCell generateCommonLabel];
    _itemNameLB.text = @"温州荣欣楼大酒店";
  }
  return _itemNameLB;
}

- (QMUIFloatLayoutView *)tagFlow {
  if (!_tagFlow) {
    _tagFlow = [[QMUIFloatLayoutView alloc] init];
    _tagFlow.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _tagFlow.itemMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    _tagFlow.minimumItemSize = CGSizeMake(20, 14);
    /// todo: add tag
  }
  return _tagFlow;
}

- (UILabel *)foundTimeLB {
  if (!_foundTimeLB) {
    _foundTimeLB = [ItemBasicInfoCell generateCommonLabel];
    _foundTimeLB.font = UIFontMake(13);
    _foundTimeLB.text = @"2009年开业 2010年装修";
  }
  return _foundTimeLB;
}

- (QMUIButton *)itemNameBtn {
  if (!_itemNameBtn) {
    _itemNameBtn = [ItemBasicInfoCell generateCommonBtn];
    [_itemNameBtn setTitle:@"详情·设备" forState:UIControlStateNormal];
  }
  return _itemNameBtn;
}

- (UILabel *)scoreAndRemarkLB {
  if (!_scoreAndRemarkLB) {
    _scoreAndRemarkLB = [ItemBasicInfoCell generateCommonLabel];
    _scoreAndRemarkLB.text = @"4.6分 好 交通方便";
    _scoreAndRemarkLB.textColor = UIColor.qd_tintColor;
  }
  return _scoreAndRemarkLB;
}

- (QMUIButton *)remarkBtn {
  if (!_remarkBtn) {
    _remarkBtn = [ItemBasicInfoCell generateCommonBtn];
    [_remarkBtn setTitle:@"更多点评" forState:UIControlStateNormal];
  }
  return _remarkBtn;
}

- (UILabel *)addressLB {
  if (!_addressLB) {
    _addressLB = [ItemBasicInfoCell generateCommonLabel];
    _addressLB.font = UIFontBoldMake(15);
    _addressLB.text = @"温州永强机场区域|"
    @"永强镇宁村宁城西路133号海滨安心公寓";
  }
  return _addressLB;
}

- (UIImageView *)addressImg {
  if (!_addressImg) {
    _addressImg = [UIImageView new];
    _addressImg.image = UIImageMake(@"locate");
  }
  return _addressImg;
}

- (UIView *)itemNameView {
  if (!_itemNameView) { _itemNameView = [UIView new]; }
  return _itemNameView;
}

- (UIView *)scoreView {
  if (!_scoreView) { _scoreView = [UIView new]; }
  return _scoreView;
}

- (UIView *)addressView {
  if (!_addressView) {
    _addressView = [UIView new];
    _addressView.userInteractionEnabled = YES;
    __weak __typeof(self) weakSelf = self;
    UITapGestureRecognizer *go2MapCon =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:[self selectorBlock:^(id _Nonnullsargs) {
      if (weakSelf.go2MapCon) { weakSelf.go2MapCon(); }
    }]];
    [_addressView addGestureRecognizer:go2MapCon];
  }
  return _addressView;
}

- (UILabel *)locateLB {
  if (!_locateLB) {
    _locateLB = [ItemBasicInfoCell generateCommonLabel];
    _locateLB.textColor = UIColor.qd_tintColor;
    _locateLB.text = @"去那里";
    _locateLB.textAlignment = NSTextAlignmentCenter;
    _locateLB.font = UIFontMake(14);
  }
  return _locateLB;
}

+ (UILabel *)generateCommonLabel {
  UILabel *label = [UILabel new];
  label.backgroundColor = UIColor.clearColor;
  label.highlightedTextColor = nil;
  label.textColor = UIColor.qd_mainTextColor;
  label.font = UIFontBoldMake(20);
  label.lineBreakMode = NSLineBreakByWordWrapping;
  label.numberOfLines = 0;
  return label;
}

+ (QMUIButton *)generateCommonBtn {
  QMUIButton *btn = [QMUIButton new];
  btn.titleLabel.textColor = UIColor.qd_tintColor;
  btn.titleLabel.font = UIFontMake(15);
  [btn setImage:UIImageMake(@"detail_more") forState:UIControlStateNormal];
  btn.imagePosition = QMUIButtonImagePositionRight;
  return btn;
}
@end
