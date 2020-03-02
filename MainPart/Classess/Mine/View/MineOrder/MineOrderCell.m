//
//  MineOrderCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineOrderCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
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
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.inset(0.5 * SPACE);
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
    make.left.trailing.equalTo(self.itemName);
    make.top.equalTo(self.itemName.mas_bottom).with.inset(0.25 * SPACE);
  }];
  
  [self.perPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.itemImage);
    make.trailing.equalTo(self.container).with.inset(0.5 * SPACE);
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

- (NSAttributedString *)generatePerPrice {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(@"¥").font(UIFontMake(13));
    make.append([NSString stringWithFormat:@"%.2f\nx%d", 3636.13, 1]).font(UIFontMake(15));
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

- (NSAttributedString *)generatebuyInfo {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append([NSString stringWithFormat:@"共%d件商品 合计:¥", 1]).font(UIFontMake(12));
    make.append([NSString stringWithFormat:@"%.2lf", 490.101]).font(UIFontBoldMake(15));
  }];
  return str;
}

- (QMUIGhostButton *)payBtn {
  if (!_payBtn) {
    _payBtn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
    [_payBtn setTitle:@"待付款" forState:UIControlStateNormal];
    _payBtn.titleLabel.font = UIFontMake(16);
    _payBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
  }
  return _payBtn;
}

- (QMUIGhostButton *)deleteBtn {
  if (!_deleteBtn) {
    _deleteBtn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
    [_deleteBtn setTitle:@"待付款" forState:UIControlStateNormal];
    _deleteBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
    _deleteBtn.titleLabel.font = UIFontMake(16);
  }
  return _deleteBtn;
}

- (void)loadData {
  self.hotelName.attributedText = [self generateHotelName];
  self.itemName.text = @"xxa";
  self.itemImage.image = UIImageMake(@"pink_gradient");
  self.itemCombo.attributedText = [self generateItemCombo];
  self.perPrice.attributedText = [self generatePerPrice];
  self.buyInfo.attributedText = [self generatebuyInfo];
}
@end
