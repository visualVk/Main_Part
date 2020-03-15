//
//  MineFoodItemCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodItemCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineFoodItemCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *foodImg;
@property (nonatomic, strong) UILabel *foodName;
@property (nonatomic, strong) UILabel *foodNum;
@property (nonatomic, strong) UILabel *foodPrice;
@end

@implementation MineFoodItemCell

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
  addView(superview, self.container);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0, 0.5 * SPACE, 0, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    addView(_container, self.foodImg);
    addView(_container, self.foodName);
    addView(_container, self.foodNum);
    addView(_container, self.foodPrice);
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0.25 * SPACE, 0.25 * SPACE, 0.25 * SPACE, 0.25 * SPACE);
    [self.foodImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(_container).with.inset(0.4 * SPACE);
      make.size.mas_equalTo(CGSizeMake(DEVICE_HEIGHT / 20, DEVICE_HEIGHT / 20));
    }];
    
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(self.foodImg.mas_right).with.inset(0.25 * SPACE);
    }];
    
    [self.foodNum mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.right.equalTo(self.foodPrice.mas_left);
    }];
    
    [self.foodPrice mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.right.equalTo(_container).with.inset(0.5 * SPACE);
      make.width.equalTo(_container).multipliedBy(0.2);
    }];
  }
  return _container;
}

- (UIImageView *)foodImg {
  if (!_foodImg) {
    _foodImg = [UIImageView new];
    _foodImg.image = UIImageMake(@"pink_gradient");
    _foodImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _foodImg;
}

- (UILabel *)foodName {
  if (!_foodName) {
    _foodName = [UILabel new];
    _foodName.text = @"温水煮青蛙";
    _foodName.textColor = UIColorBlack;
    _foodName.font = UIFontMake(16);
  }
  return _foodName;
}

- (UILabel *)foodNum {
  if (!_foodNum) {
    _foodNum = [UILabel new];
    _foodNum.attributedText = [self generateFoodNum:1];
  }
  return _foodNum;
}

- (UILabel *)foodPrice {
  if (!_foodPrice) {
    _foodPrice = [UILabel new];
    _foodPrice.attributedText = [self generateFoodPrice:@"25"];
  }
  return _foodPrice;
}

- (void)setModel:(Food *)model {
  _model = model;
  self.foodNum.attributedText = [self generateFoodNum:model.foodNum];
  self.foodPrice.attributedText =
  [self generateFoodPrice:[NSString stringWithFormat:@"%g", [model.foodPrice doubleValue] *
                           model.foodNum]];
  self.foodName.text = model.foodName;
}

- (NSAttributedString *)generateFoodPrice:(NSString *)price {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColorBlack).alignment(NSTextAlignmentRight);
    make.append(@"¥").font(UIFontMake(12));
    make.append(price).font(UIFontMake(16));
  }];
}

- (NSAttributedString *)generateFoodNum:(NSInteger)num {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColorBlack).alignment(NSTextAlignmentRight);
    make.append(@"x").font(UIFontMake(13));
    make.append([NSString stringWithFormat:@"%li", num]).font(UIFontMake(15));
  }];
}
@end
