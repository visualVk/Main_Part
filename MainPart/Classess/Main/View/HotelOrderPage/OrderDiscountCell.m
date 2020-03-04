
//
//  OrderDiscountCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderDiscountCell.h"
#import "MarkUtils.h"

@interface OrderDiscountCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *titleContainer;
@property (nonatomic, strong) UIView *discountContainer;
@property (nonatomic, strong) UIView *creditContainer;
@end

@implementation OrderDiscountCell

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
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  //  addView(superview, self.container);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
  
  [self.titleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(self.container);
  }];
  
  [self.discountContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.container);
    make.top.equalTo(self.titleContainer.mas_bottom);
  }];
  
  [self.creditContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.container);
    make.top.equalTo(self.discountContainer.mas_bottom);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.layer.cornerRadius = 8;
    _container.layer.masksToBounds = YES;
    addView(self.contentView, _container);
    addView(_container, self.titleContainer);
    addView(_container, self.discountContainer);
    addView(_container, self.creditContainer);
    self.maxTag.hidden = YES;
    
    UIView *shadowView = [UIView new];
    shadowView.layer.shadowRadius = 8;
    shadowView.backgroundColor = UIColor.qd_backgroundColor;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowOpacity = 0.25;
    shadowView.layer.borderColor = UIColor.clearColor.CGColor;
    [self.contentView insertSubview:shadowView belowSubview:_container];
    [shadowView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
  }
  return _container;
}

- (UIView *)titleContainer {
  if (!_titleContainer) {
    _titleContainer = [self generateCommonContainer];
    addView(_titleContainer, self.title);
    addView(_titleContainer, self.ticketBrief);
    addView(_titleContainer, self.ticketCheckBox);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.top.bottom.equalTo(_titleContainer).with.inset(0.5 * SPACE);
      make.width.equalTo(_titleContainer).multipliedBy(0.25);
    }];
    
    [self.ticketBrief mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(self.title.mas_trailing);
      make.centerY.equalTo(self.title);
      make.trailing.equalTo(self.ticketCheckBox.mas_leading);
    }];
    
    [self.ticketCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_titleContainer);
      make.width.height.equalTo(self.title.mas_height);
      make.trailing.equalTo(_titleContainer).with.inset(0.5 * SPACE);
      ;
    }];
  }
  return _titleContainer;
}

- (UIView *)discountContainer {
  if (!_discountContainer) {
    _discountContainer = [self generateCommonContainer];
    addView(_discountContainer, self.discountTitle);
    addView(_discountContainer, self.discount);
    addView(_discountContainer, self.detailImage);
    
    [self.discountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_discountContainer).with.inset(0.5 * SPACE);
      make.width.equalTo(_discountContainer).multipliedBy(.25);
    }];
    
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(self.discountTitle.mas_trailing);
      make.centerY.equalTo(self.discountTitle);
      make.trailing.equalTo(self.detailImage.mas_leading);
    }];
    
    [self.detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_discountContainer).with.inset(0.5 * SPACE);
      make.centerY.equalTo(self.discountTitle);
    }];
  }
  return _discountContainer;
}

- (UIView *)creditContainer {
  if (!_creditContainer) {
    _creditContainer = [self generateCommonContainer];
    _creditContainer.qmui_borderColor = UIColor.clearColor;
    addView(_creditContainer, self.creditTitle);
    addView(_creditContainer, self.credit);
    
    [self.creditTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_creditContainer).with.inset(0.5 * SPACE);
      make.width.equalTo(_creditContainer).multipliedBy(.25);
    }];
    
    [self.credit mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(_creditTitle.mas_trailing);
      make.centerY.equalTo(_creditTitle);
      make.trailing.equalTo(_creditContainer).with.inset(0.5 * SPACE);
    }];
  }
  return _creditContainer;
}

- (UIView *)generateCommonContainer {
  UIView *view = [UIView new];
  view.backgroundColor = UIColor.clearColor;
  view.qmui_borderColor = UIColor.qd_separatorColor;
  view.qmui_borderPosition = QMUIViewBorderPositionBottom;
  return view;
}
- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"电子发票";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontMake(16);
  }
  return _title;
}

- (UILabel *)discountTitle {
  if (!_discountTitle) {
    _discountTitle = [UILabel new];
    _discountTitle.text = @"优惠";
    _discountTitle.textColor = UIColor.qd_mainTextColor;
    _discountTitle.font = UIFontMake(16);
  }
  return _discountTitle;
}

- (UILabel *)discount {
  if (!_discount) {
    _discount = [UILabel new];
    _discount.textColor = UIColor.orangeColor;
    _discount.text = @"不使用";
    _discount.font = UIFontBoldMake(16);
  }
  return _discount;
}

- (QMUILabel *)maxTag {
  if (!_maxTag) {
    _maxTag = [QMUILabel new];
    _maxTag.highlightedTextColor = nil;
    _maxTag.highlightedBackgroundColor = nil;
    _maxTag.text = @"最大优惠";
    _maxTag.font = UIFontMake(14);
    _maxTag.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    _maxTag.layer.borderColor = UIColor.orangeColor.CGColor;
  }
  return _maxTag;
}
- (UIImageView *)detailImage {
  if (!_detailImage) {
    _detailImage = [UIImageView new];
    _detailImage.image = UIImageMake(@"detail_right_arrow");
    //_detailImage.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _detailImage;
}

- (UILabel *)creditTitle {
  if (!_creditTitle) {
    _creditTitle = [UILabel new];
    _creditTitle.textColor = UIColor.qd_mainTextColor;
    _creditTitle.font = UIFontMake(16);
    _creditTitle.text = @"积分";
  }
  return _creditTitle;
}

- (UILabel *)credit {
  if (!_credit) {
    _credit = [UILabel new];
    _credit.textColor = UIColor.orangeColor;
    _credit.text = @"可获得62积分";
    _credit.font = UIFontMake(16);
  }
  return _credit;
}

- (UILabel *)ticketBrief {
  if (!_ticketBrief) {
    _ticketBrief = [UILabel new];
    _ticketBrief.numberOfLines = 0;
    _ticketBrief.text = @"离店后订单上显示";
    _ticketBrief.textColor = UIColor.qd_mainTextColor;
    _ticketBrief.font = UIFontBoldMake(16);
  }
  return _ticketBrief;
}

- (BEMCheckBox *)ticketCheckBox {
  if (!_ticketCheckBox) {
    _ticketCheckBox = [[BEMCheckBox alloc] init];
    _ticketCheckBox.onAnimationType = BEMAnimationTypeBounce;
    _ticketCheckBox.offAnimationType = BEMAnimationTypeBounce;
  }
  return _ticketCheckBox;
}
@end
