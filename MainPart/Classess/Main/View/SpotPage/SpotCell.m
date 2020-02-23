//
//  SpotCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SpotCell.h"
#import "MarkUtils.h"
#define SMALLFONT 13
@interface SpotCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *startImage;
@property (nonatomic, strong) UIImageView *spotImage;
@property (nonatomic, strong) QMUILabel *spotNameLB;
@property (nonatomic, strong) QMUILabel *spotTagLB;
@property (nonatomic, strong) QMUILabel *remarkLB;
@property (nonatomic, strong) QMUILabel *scoreLB;
@property (nonatomic, strong) QMUILabel *locLB;
@property (nonatomic, strong) QMUILabel *priceLB;
@end

@implementation SpotCell

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
  addView(superview, self.startImage);
  addView(superview, self.spotImage);
  addView(superview, self.spotNameLB);
  addView(superview, self.spotTagLB);
  addView(superview, self.remarkLB);
  addView(superview, self.scoreLB);
  addView(superview, self.locLB);
  addView(superview, self.priceLB);
  
  [self.spotImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(superview).offset(-0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(0.25);
    make.height.equalTo(self.spotImage.mas_width);
  }];
  
  [self.spotNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotImage);
    make.left.equalTo(self.spotImage.mas_right).offset(0.5 * SPACE);
  }];
  
  [self.startImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.spotNameLB.mas_right).offset(0.5 * SPACE);
    make.centerY.equalTo(self.spotNameLB.mas_centerY);
    make.height.width.equalTo(@20);
  }];
  
  [self.spotTagLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotNameLB.mas_bottom).offset(0.5 * SPACE);
    make.left.equalTo(self.spotNameLB);
  }];
  
  [self.remarkLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotTagLB.mas_bottom).offset(0.25 * SPACE);
    make.left.equalTo(self.spotTagLB);
    make.bottom.lessThanOrEqualTo(self.locLB.mas_top);
  }];
  
  [self.locLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.remarkLB);
    make.bottom.equalTo(self.scoreLB);
  }];
  
  [self.scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.priceLB);
    make.top.equalTo(self.spotImage);
  }];
  
  [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.bottom.equalTo(superview).offset(-0.5 * SPACE);
  }];
}

- (UIImageView *)startImage {
  if (!_startImage) {
    _startImage = [UIImageView new];
    _startImage.image = UIImageMake(@"pink_gradient");
    _startImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _startImage.layer.cornerRadius = 2.5f;
    _startImage.layer.masksToBounds = YES;
    _startImage.clipsToBounds = YES;
  }
  return _startImage;
}

- (UIImageView *)spotImage {
  if (!_spotImage) {
    _spotImage = [UIImageView new];
    _spotImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _spotImage.image = UIImageMake(@"navigationbar_background");
    _spotImage.layer.cornerRadius = 5;
    _spotImage.layer.borderColor = UIColor.clearColor.CGColor;
    _spotImage.layer.masksToBounds = YES;
    _spotImage.clipsToBounds = YES;
  }
  return _spotImage;
}

- (QMUILabel *)spotNameLB {
  if (!_spotNameLB) {
    _spotNameLB = [QMUILabel new];
    _spotNameLB.text = @"五马街";
    _spotNameLB.textColor = UIColor.qd_mainTextColor;
    _spotNameLB.font = UIFontBoldMake(18);
  }
  return _spotNameLB;
}

- (QMUILabel *)spotTagLB {
  if (!_spotTagLB) {
    _spotTagLB = [QMUILabel new];
    _spotTagLB.text = @"小吃众多";
    _spotTagLB.textColor = UIColor.qmui_randomColor;
    _spotTagLB.font = UIFontBoldMake(14);
  }
  return _spotTagLB;
}

- (QMUILabel *)remarkLB {
  if (!_remarkLB) {
    _remarkLB = [QMUILabel new];
    _remarkLB.text = @"100条评论";
    _remarkLB.textColor = UIColor.qd_placeholderColor;
    _remarkLB.font = UIFontBoldMake(SMALLFONT);
  }
  return _remarkLB;
}

- (QMUILabel *)scoreLB {
  if (!_scoreLB) {
    _scoreLB = [QMUILabel new];
    _scoreLB.text = @"5.2分";
    _scoreLB.textColor = UIColor.qmui_randomColor;
    _scoreLB.font = UIFontBoldMake(25);
  }
  return _scoreLB;
}

- (QMUILabel *)locLB {
  if (!_locLB) {
    _locLB = [QMUILabel new];
    _locLB.text = @"xxxxxxxxxxxxxxx";
    _locLB.textColor = UIColor.qd_placeholderColor;
    _locLB.font = UIFontBoldMake(SMALLFONT);
  }
  return _locLB;
}

- (QMUILabel *)priceLB {
  if (!_priceLB) {
    _priceLB = [QMUILabel new];
    _priceLB.font = UIFontBoldMake(21);
    _priceLB.text = @"价格：999";
    _priceLB.textColor = UIColor.qmui_randomColor;
  }
  return _priceLB;
}
@end
