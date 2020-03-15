//
//  MineFoodDiscountCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodDiscountCell.h"
#import "MarkUtils.h"
#import <BEMCheckBox.h>

@interface MineFoodDiscountCell () <GenerateEntityDelegate, BEMCheckBoxDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *isDicountContainer;
@property (nonatomic, strong) UILabel *isDicountLB;
@property (nonatomic, strong) BEMCheckBox *dicountCheck;
@property (nonatomic, strong) UIView *discountContainer;
@property (nonatomic, strong) UILabel *discountLB;
@property (nonatomic, strong) UIImageView *chooseImg;
@end

@implementation MineFoodDiscountCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  UIEdgeInsets padding = UIEdgeInsetsMake(0, 0.5 * SPACE, 0, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
}
#pragma mark - container
- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    addView(_container, self.isDicountContainer);
    addView(_container, self.discountContainer);
    
    [self.isDicountContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(_container);
    }];
    
    [self.discountContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.isDicountContainer.mas_bottom);
      make.left.right.bottom.equalTo(_container);
    }];
  }
  return _container;
}

#pragma mark - isDicountContainer
- (UIView *)isDicountContainer {
  if (!_isDicountContainer) {
    _isDicountContainer = [UIView new];
    addView(_isDicountContainer, self.isDicountLB);
    addView(_isDicountContainer, self.dicountCheck);
    
    [self.isDicountLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(_isDicountContainer).with.inset(0.5 * SPACE);
    }];
    
    [self.dicountCheck mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_isDicountContainer).with.inset(0.5 * SPACE);
      make.top.bottom.equalTo(self.isDicountLB).with.inset(2.5);
      make.width.equalTo(self.dicountCheck.mas_height);
    }];
    
    _isDicountContainer.qmui_borderColor = UIColor.qd_separatorColor;
    _isDicountContainer.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _isDicountContainer.qmui_borderWidth = 0.5;
  }
  return _isDicountContainer;
}

- (UILabel *)isDicountLB {
  if (!_isDicountLB) {
    _isDicountLB = [UILabel new];
    _isDicountLB.textColor = UIColorBlack;
    _isDicountLB.font = UIFontMake(18);
    _isDicountLB.text = @"是否使用优惠券";
  }
  return _isDicountLB;
}

- (BEMCheckBox *)dicountCheck {
  if (!_dicountCheck) {
    _dicountCheck = [[BEMCheckBox alloc] init];
    [_dicountCheck setOn:YES];
    _dicountCheck.delegate = self;
    _dicountCheck.onAnimationType = BEMAnimationTypeBounce;
    _dicountCheck.offAnimationType = BEMAnimationTypeBounce;
  }
  return _dicountCheck;
}

#pragma mark - discountContainer
- (UIView *)discountContainer {
  if (!_discountContainer) {
    _discountContainer = [UIView new];
    addView(_discountContainer, self.discountLB);
    addView(_discountContainer, self.chooseImg);
    
    [self.discountLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_discountContainer).with.inset(0.5 * SPACE);
    }];
    
    [self.chooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_discountContainer).with.inset(0.5 * SPACE);
      make.top.bottom.equalTo(self.discountLB);
      make.width.equalTo(self.chooseImg.mas_height);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClick)];
    [_discountContainer addGestureRecognizer:tap];
  }
  return _discountContainer;
}

- (UILabel *)discountLB {
  if (!_discountLB) {
    _discountLB = [UILabel new];
    _discountLB.text = @"优惠 0元";
    _discountLB.textColor = UIColor.orangeColor;
    _discountLB.font = UIFontMake(18);
    _discountLB.highlightedTextColor = UIColor.qd_placeholderColor;
    _discountLB.highlighted = false;
  }
  return _discountLB;
}

- (UIImageView *)chooseImg {
  if (!_chooseImg) {
    _chooseImg = [UIImageView new];
    _chooseImg.image = UIImageMake(@"right-arrow-fill");
  }
  return _chooseImg;
}

- (void)chooseClick {
  QMUILogInfo(@"mine food discount cell", @"choose click");
}

//- (void)discountClick {
//  QMUILogInfo(@"mine food discount cell", @"discount click");
//}

#pragma mark - Check Box Delegate
- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
  self.discountContainer.userInteractionEnabled = !self.discountContainer.userInteractionEnabled;
  self.discountLB.highlighted = !self.discountLB.highlighted;
  if (checkBox.selected) {
  } else {
  }
}
@end
