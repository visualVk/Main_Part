//
//  ItemSectionView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/20.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ItemSectionView.h"
#import "MarkUtils.h"

@interface ItemSectionView () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *itemSectionName;
@end

@implementation ItemSectionView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.itemSectionName);
  [self.itemSectionName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(0.5 * SPACE);
    make.centerY.equalTo(self);
  }];
}

- (UILabel *)itemSectionName {
  if (_itemSectionName) {
    _itemSectionName = [UILabel new];
    _itemSectionName.text = @"入住套餐";
    _itemSectionName.textColor = UIColor.qmui_randomColor;
    _itemSectionName.font = UIFontBoldMake(18);
  }
  return _itemSectionName;
}
@end
