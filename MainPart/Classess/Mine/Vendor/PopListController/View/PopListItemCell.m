//
//  PopListItemCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PopListItemCell.h"
#import "MarkUtils.h"
const NSInteger ItemIndex = 10000;
@interface PopListItemCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *popItemSubImg;
@property (nonatomic, strong) UIImageView *popItemAddImg;

@property (nonatomic, strong) UIView *popItemNumContainer;
@end

@implementation PopListItemCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.backgroundColor = UIColor.qd_backgroundColor;
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
  addView(superview, self.popItemName);
  addView(superview, self.popItemPrice);
  addView(superview, self.popItemNumContainer);
  
  [self.popItemName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.popItemPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.bottom.equalTo(superview);
    make.right.equalTo(self.popItemNumContainer.mas_left).with.inset(5);
  }];
  
  [self.popItemNumContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [@[ self.popItemName, self.popItemPrice, self.popItemNumContainer ]
   mas_makeConstraints:^(MASConstraintMaker *make) { make.centerY.equalTo(superview); }];
}

- (UIView *)popItemNumContainer {
  if (!_popItemNumContainer) {
    _popItemNumContainer = [UIView new];
    addView(_popItemNumContainer, self.popItemSubImg);
    addView(_popItemNumContainer, self.popItemNum);
    addView(_popItemNumContainer, self.popItemAddImg);
    
    [self.popItemSubImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(_popItemNumContainer);
    }];
    
    [self.popItemNum mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.popItemSubImg.mas_right);
      make.top.bottom.equalTo(self.popItemSubImg);
      make.width.equalTo(self.popItemSubImg);
    }];
    
    [self.popItemAddImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.right.bottom.equalTo(_popItemNumContainer);
      make.left.equalTo(self.popItemNum.mas_right);
    }];
  }
  return _popItemNumContainer;
}

- (UIImageView *)popItemAddImg {
  if (!_popItemAddImg) {
    _popItemAddImg = [UIImageView new];
    _popItemAddImg.image = UIImageMake(@"increase_eleme");
    _popItemAddImg.tag = ItemIndex + 1;
    _popItemAddImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemNumClick:)];
    [_popItemAddImg addGestureRecognizer:tap];
  }
  return _popItemAddImg;
}

- (UIImageView *)popItemSubImg {
  if (!_popItemSubImg) {
    _popItemSubImg = [UIImageView new];
    _popItemSubImg.image = UIImageMake(@"decrease_eleme");
    _popItemSubImg.tag = ItemIndex;
    _popItemSubImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemNumClick:)];
    [_popItemSubImg addGestureRecognizer:tap];
  }
  return _popItemSubImg;
}

- (UILabel *)popItemNum {
  if (!_popItemNum) {
    _popItemNum = [UILabel new];
    _popItemNum.text = @"0";
    _popItemNum.textAlignment = NSTextAlignmentCenter;
    //    _popItemNum.hidden = YES;
  }
  return _popItemNum;
}

- (UILabel *)popItemName {
  if (!_popItemName) {
    _popItemName = [UILabel new];
    _popItemName.text = @"xxx";
    _popItemName.textColor = UIColorBlack;
    _popItemName.font = UIFontMake(15);
  }
  return _popItemName;
}

- (UILabel *)popItemPrice {
  if (!_popItemPrice) {
    _popItemPrice = [UILabel new];
    _popItemPrice.text = @"¥333";
    _popItemPrice.font = UIFontMake(15);
    _popItemPrice.textColor = UIColor.orangeColor;
  }
  return _popItemPrice;
}

- (void)itemNumClick:(UITapGestureRecognizer *)tap {
  UIView *view = tap.qmui_targetView;
  if (view.tag - ItemIndex == 0) {
    self.model.foodNum - 1 < 0 ? 0 : (--self.model.foodNum);
  } else {
    self.model.foodNum++;
  }
  self.popItemPrice.text =
  [NSString stringWithFormat:@"¥%g", [self.model.foodPrice doubleValue] * self.model.foodNum];
  self.popItemNum.text = [NSString stringWithFormat:@"%li", self.model.foodNum];
  if (self.popItemClickBlock) { self.popItemClickBlock(self.model.foodNum); }
}

- (void)setModel:(Food *)model {
  _model = model;
  self.popItemPrice.text =
  [NSString stringWithFormat:@"¥%g", [model.foodPrice doubleValue] * model.foodNum];
  self.popItemNum.text = [NSString stringWithFormat:@"%li", model.foodNum];
  self.popItemName.text = model.foodName;
}
@end
