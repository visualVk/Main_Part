//
//  SceneSpotCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneSpotCell.h"
#import "MarkUtils.h"

@interface SceneSpotCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation SceneSpotCell

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

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.sceneImg);
    addView(_container, self.title);
    addView(_container, self.stars);
    addView(_container, self.special);
    
    [self.sceneImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_container);
      make.width.equalTo(self.sceneImg.mas_height);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.sceneImg);
      make.left.equalTo(self.sceneImg.mas_right).with.inset(0.25 * SPACE);
    }];
    
    [self.stars mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.title.mas_bottom);
      make.left.equalTo(self.title);
    }];
    
    [self.special mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.stars.mas_bottom);
      make.left.equalTo(self.title);
    }];
  }
  return _container;
}

- (UIImageView *)sceneImg {
  if (!_sceneImg) {
    _sceneImg = [UIImageView new];
    _sceneImg.image = UIImageMake(@"pink_gradient");
    _sceneImg.layer.cornerRadius = 10;
    _sceneImg.layer.masksToBounds = YES;
    _sceneImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _sceneImg;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"四川";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(22);
  }
  return _title;
}

- (UILabel *)score {
  if (!_score) { _score = [UILabel new]; }
  return _score;
}

- (QMUILabel *)special {
  if (!_special) {
    _special = [QMUILabel new];
    _special.highlightedBackgroundColor = nil;
    _special.highlightedTextColor = nil;
    _special.textColor = UIColor.qmui_randomColor;
    _special.backgroundColor = UIColor.qd_backgroundColor;
    _special.font = UIFontMake(13);
    _special.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
    _special.text = @"水清";
    [_special sizeToFit];
  }
  return _special;
}

- (QMUILabel *)stars {
  if (!_stars) {
    _stars = [QMUILabel new];
    _stars.text = @"4A景点";
    _stars.font = UIFontMake(12);
    _stars.contentEdgeInsets = UIEdgeInsetsMake(1, 5, 1, 5);
    _stars.layer.borderColor = UIColor.qmui_randomColor.CGColor;
    _stars.layer.borderWidth = 0.5;
  }
  return _stars;
}

- (QMUILabel *)generateCommonQmuiLabel {
  QMUILabel *label = [QMUILabel new];
  label.highlightedBackgroundColor = nil;
  label.highlightedTextColor = nil;
  label.textColor = UIColor.qmui_randomColor;
  return label;
}
@end
