//
//  MineOrderCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderCell.h"
#import "MarkUtils.h"
#import "OrderReviewController.h"
#import "PayMethodController.h"
#import <SJAttributesFactory.h>

@interface MineOrderCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation MineOrderCell

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
  addView(superview, self.shadowView);
  addView(superview, self.container);
  addView(self.container, self.hotelName);
  addView(self.container, self.state);
  addView(self.container, self.itemImage);
  addView(self.container, self.itemName);
  addView(self.container, self.itemCombo);
  addView(self.container, self.perPrice);
  addView(self.container, self.buyInfo);
  addView(self.container, self.deleteBtn);
  addView(self.container, self.payBtn);
  self.payBtn.hidden = YES;
  
  [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.container).with.inset(3);
    make.left.right.equalTo(self.container);
    make.bottom.equalTo(self.container);
  }];
  UIEdgeInsets padding = UIEdgeInsetsMake(0.25 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
  
  [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.trailing.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.container).with.inset(0.5 * SPACE);
    make.top.equalTo(self.hotelName.mas_bottom).with.inset(0.25 * SPACE);
    make.width.equalTo(self.container).multipliedBy(0.25);
    make.height.equalTo(self.itemImage.mas_width);
  }];
  
  [self.itemName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.itemImage.mas_right).with.inset(0.5 * SPACE);
    //    make.trailing.equalTo(self.perPrice.mas_leading);
    make.top.equalTo(self.hotelName.mas_bottom).with.inset(0.25 * SPACE);
    //    make.width.equalTo(self.container).multipliedBy(3.0 / 5);
  }];
  
  [self.itemCombo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.itemName);
    make.top.equalTo(self.itemName.mas_bottom).with.inset(0.25 * SPACE);
    make.right.equalTo(self.perPrice.mas_left);
  }];
  
  [self.perPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.itemImage);
    make.trailing.equalTo(self.container).with.inset(0.5 * SPACE);
    make.width.equalTo(self.container).multipliedBy(1.0 / 8);
  }];
  
  [self.buyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.perPrice);
    make.bottom.equalTo(self.deleteBtn.mas_top).with.inset(0.5 * SPACE);
  }];
  
  [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.buyInfo);
    make.bottom.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.buyInfo);
    //    make.top.equalTo(self.buyInfo.mas_bottom).with.inset(0.5 * SPACE);
    make.bottom.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)shadowView {
  if (!_shadowView) {
    _shadowView = [UIView new];
    _shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0, 3);
    _shadowView.layer.shadowOpacity = 0.1;
    _shadowView.backgroundColor = UIColor.qd_backgroundColor;
    _shadowView.layer.cornerRadius = 10;
    _shadowView.layer.shadowRadius = 10;
  }
  return _shadowView;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.layer.cornerRadius = 10;
    _container.layer.masksToBounds = YES;
    _container.backgroundColor = UIColor.qd_backgroundColor;
  }
  return _container;
}

- (UILabel *)hotelName {
  if (!_hotelName) {
    _hotelName = [UILabel new];
    //        _hotelName.numberOfLines = 0;
    _hotelName.text = @"unknowned";
    _hotelName.textColor = UIColor.qd_mainTextColor;
    _hotelName.font = UIFontBoldMake(18);
  }
  return _hotelName;
}

- (NSAttributedString *)generateHotelName {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
    make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
      make.image = UIImageMake(@"check_selected");
    })
    .baseLineOffset(-3);
    make.append(@"\ttitle\t");
    make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
      make.image = UIImageMake(@"right_arrow_small");
    })
    .baseLineOffset(-3);
  }];
  return str;
}

- (UILabel *)state {
  if (!_state) {
    _state = [UILabel new];
    _state.text = @"已购买";
  }
  return _state;
}

- (UIImageView *)itemImage {
  if (!_itemImage) {
    _itemImage = [UIImageView new];
    _itemImage.image = UIImageMake(@"pink_gradient");
    _itemImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _itemImage.layer.cornerRadius = 5;
    _itemImage.layer.masksToBounds = YES;
  }
  return _itemImage;
}

- (UILabel *)itemName {
  if (!_itemName) {
    _itemName = [UILabel new];
    _itemName.text = @"xxxx";
    _itemName.numberOfLines = 0;
    _itemName.textColor = UIColor.qd_mainTextColor;
    _itemName.font = UIFontBoldMake(18);
  }
  return _itemName;
}

- (UILabel *)perPrice {
  if (!_perPrice) {
    _perPrice = [UILabel new];
    _perPrice.numberOfLines = 0;
  }
  return _perPrice;
}

- (NSAttributedString *)generatePerPrice:(NSString *)perPrice num:(NSInteger)num {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.alignment(NSTextAlignmentRight);
    make.append(@"¥").font(UIFontMake(13));
    make.append([NSString stringWithFormat:@"%@\nx%li", perPrice, num]).font(UIFontMake(15));
  }];
  return str;
}

- (UILabel *)itemCombo {
  if (!_itemCombo) {
    _itemCombo = [UILabel new];
    _itemCombo.numberOfLines = 0;
  }
  return _itemCombo;
}

- (NSAttributedString *)generateItemCombo {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.font(UIFontMake(15)).textColor(UIColor.qd_placeholderColor);
    make.append(@"xasdasd;asdasddsadsa");
  }];
  return str;
}

- (UILabel *)buyInfo {
  if (!_buyInfo) { _buyInfo = [UILabel new]; }
  return _buyInfo;
}

- (NSAttributedString *)generatebuyInfo:(NSInteger)num totPrice:(NSString *)price {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append([NSString stringWithFormat:@"共%li件商品 合计:¥", num]).font(UIFontMake(12));
    make.append([NSString stringWithFormat:@"%@", price]).font(UIFontBoldMake(15));
  }];
  return str;
}

- (QMUIGhostButton *)payBtn {
  if (!_payBtn) {
    _payBtn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
    [_payBtn setTitle:@"取消预定" forState:UIControlStateNormal];
    _payBtn.titleLabel.font = UIFontMake(16);
    _payBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
    [_payBtn addTarget:self
                action:@selector(labelTap:)
      forControlEvents:UIControlEventTouchUpInside];
  }
  return _payBtn;
}

- (QMUIGhostButton *)deleteBtn {
  if (!_deleteBtn) {
    _deleteBtn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
    [_deleteBtn setTitle:@"待付款" forState:UIControlStateNormal];
    _deleteBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
    _deleteBtn.titleLabel.font = UIFontMake(16);
    [_deleteBtn addTarget:self
                   action:@selector(labelTap:)
         forControlEvents:UIControlEventTouchUpInside];
  }
  return _deleteBtn;
}

- (void)labelTap:(QMUIGhostButton *)btn {
  if ([@"取消预定" isEqualToString:btn.titleLabel.text]) {
    if (self.deleteOneOrder) self.deleteOneOrder(self.model);
  } else if ([@"待付款" isEqualToString:btn.titleLabel.text]) {
    PayMethodController *pmCon = [PayMethodController new];
    [self.qmui_viewController.navigationController pushViewController:pmCon animated:YES];
  } else if ([@"待评价" isEqualToString:btn.titleLabel.text]) {
    //    [self.qmui_viewController.navigationController push]
    OrderReviewController *orCon = [OrderReviewController new];
    [self.qmui_viewController.navigationController pushViewController:orCon animated:YES];
  }
}

//- (void)loadData {
//  self.hotelName.attributedText = [self generateHotelName];
//  self.itemName.text = @"xxa";
//  self.itemImage.image = UIImageMake(@"pink_gradient");
//  self.itemCombo.attributedText = [self generateItemCombo];
//  self.perPrice.attributedText = [self generatePerPrice:@"3636" num:<#(NSInteger)#>];
//  self.buyInfo.attributedText = [self generatebuyInfo];
//}

- (void)setModel:(OrderCheckInfo *)model {
  _model = model;
  self.hotelName.text = model.hotelName;
  self.itemName.text = model.roomTypeName;
  self.itemCombo.attributedText =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.font(UIFontMake(15)).textColor(UIColor.qd_placeholderColor);
    make.append(model.roomCombo);
  }];
  self.perPrice.attributedText = [self generatePerPrice:model.roomPrice num:model.checkInfo.count];
  self.buyInfo.attributedText =
  [self generatebuyInfo:model.checkInfo.count
               totPrice:[NSString stringWithFormat:@"%g", model.roomPrice.doubleValue *
                         model.checkInfo.count]];
  
  switch (model.orderStatus) {
    case 0:
      self.state.text = @"取消预定";
      [self.payBtn setTitle:self.state.text forState:UIControlStateNormal];
      self.payBtn.hidden = false;
      self.deleteBtn.hidden = YES;
      break;
    case 1:
      self.state.text = @"未付款";
      self.payBtn.hidden = YES;
      self.deleteBtn.hidden = false;
      break;
    case 2:
      self.state.text = @"待评价";
      [self.payBtn setTitle:self.state.text forState:UIControlStateNormal];
      self.payBtn.hidden = false;
      self.deleteBtn.hidden = YES;
      break;
    default:
      break;
  }
}
@end
