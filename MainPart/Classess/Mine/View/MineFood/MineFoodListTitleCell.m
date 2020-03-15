//
//  MineFoodListTitleCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodListTitleCell.h"
#import "MarkUtils.h"

@interface MineFoodListTitleCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *foodTitle;
@property (nonatomic, strong) UIView *container;
@end

@implementation MineFoodListTitleCell

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
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(superview);
    make.left.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    _container.qmui_borderColor = UIColor.qd_separatorColor;
    _container.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _container.qmui_borderWidth = 0.5;
    addView(_container, self.foodTitle);
    
    [self.foodTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(_container).with.inset(0.5 * SPACE);
    }];
  }
  return _container;
}

- (QMUILabel *)foodTitle {
  if (!_foodTitle) {
    _foodTitle = [QMUILabel new];
    _foodTitle.highlightedTextColor = nil;
    _foodTitle.highlightedBackgroundColor = nil;
    _foodTitle.textColor = UIColorBlack;
    _foodTitle.font = UIFontLightMake(18);
    _foodTitle.text = @"订餐清单";
  }
  return _foodTitle;
}
@end
