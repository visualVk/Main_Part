//
//  MineOrderCheckPersonInfoView.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderCheckPersonInfoView.h"
#import "MarkUtils.h"
#import <BEMCheckBox.h>

@interface MineOrderCheckPersonInfoView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *checkContainer;
@property (nonatomic, strong) BEMCheckBox *checkBox;
@end

@implementation MineOrderCheckPersonInfoView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
    self.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.qmui_borderColor = UIColor.qd_separatorColor;
    self.qmui_borderWidth = 0.5;
  }
  return self;
}

- (void)prepareForReuse {
  [self.checkBox setOn:false];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self;
  addView(superview, self.checkContainer);
  addView(superview, self.nameImage);
  addView(superview, self.collapseImage);
  addView(superview, self.checkBox);
  
  [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.left.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(20);
    make.width.mas_equalTo(0);
  }];
  
  [self.nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.checkBox.mas_right).with.inset(0.25 * SPACE);
    make.centerY.equalTo(superview);
  }];
  
  [self.checkContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.nameImage);
    make.left.equalTo(self.nameImage.mas_right).with.inset(0.25 * SPACE);
  }];
  
  [self.collapseImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(0.5 * SPACE);
    ;
    make.centerY.equalTo(superview);
  }];
}

- (UIView *)checkContainer {
  if (!_checkContainer) {
    _checkContainer = [UIView new];
    addView(_checkContainer, self.checkPersonName);
    addView(_checkContainer, self.checkPersonIdCard);
    
    [self.checkPersonName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.equalTo(_checkContainer);
    }];
    [self.checkPersonIdCard mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.bottom.equalTo(_checkContainer);
      make.top.equalTo(self.checkPersonName.mas_bottom).with.inset(0.25 * SPACE);
    }];
  }
  return _checkContainer;
}

- (QMUILabel *)checkTitle {
  if (!_checkTitle) {
    _checkTitle = [QMUILabel new];
    _checkTitle.text = @"房间登记人信息";
    _checkTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 0.5 * SPACE, 0, 0);
    _checkTitle.highlightedBackgroundColor = nil;
    _checkTitle.highlightedTextColor = nil;
    _checkTitle.textColor = UIColor.qd_mainTextColor;
    _checkTitle.font = UIFontLightMake(15);
    _checkTitle.qmui_borderColor = UIColor.orangeColor;
    _checkTitle.qmui_borderPosition = QMUIViewBorderPositionLeft;
    _checkTitle.qmui_borderWidth = 2;
  }
  return _checkTitle;
}

- (UILabel *)checkPersonName {
  if (!_checkPersonName) {
    _checkPersonName = [UILabel new];
    _checkPersonName.text = @"wwx";
    _checkPersonName.font = UIFontMake(18);
    _checkPersonName.textColor = UIColor.qd_mainTextColor;
  }
  return _checkPersonName;
}

- (UILabel *)checkPersonIdCard {
  if (!_checkPersonIdCard) {
    _checkPersonIdCard = [UILabel new];
    _checkPersonIdCard.text = [self hideIdCardPart:@"330304200001014557"];
    _checkPersonIdCard.textColor = UIColor.qd_mainTextColor;
    _checkPersonIdCard.font = UIFontMake(16);
  }
  return _checkPersonIdCard;
}

- (UIImageView *)nameImage {
  if (!_nameImage) {
    _nameImage = [UIImageView new];
    _nameImage.image = UIImageMake(@"checkin");
  }
  return _nameImage;
}

- (BEMCheckBox *)checkBox {
  if (!_checkBox) {
    _checkBox = [[BEMCheckBox alloc] init];
    //    [_checkBox setOn:false];
    _checkBox.onAnimationType = BEMAnimationTypeFill;
    _checkBox.offAnimationType = BEMAnimationTypeFill;
    _checkBox.onTintColor = UIColor.orangeColor;
    _checkBox.onCheckColor = UIColor.whiteColor;
    _checkBox.onFillColor = UIColor.orangeColor;
    _checkBox.userInteractionEnabled = false;
    //    _checkBox.clipsToBounds = YES;
  }
  return _checkBox;
}

- (UIImageView *)collapseImage {
  if (!_collapseImage) {
    _collapseImage = [UIImageView new];
    _collapseImage.userInteractionEnabled = YES;
    _collapseImage.image = UIImageMake(@"collapse");
    //    UITapGestureRecognizer *tap =
    //    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collaspClick:)];
    //    [_collapseImage addGestureRecognizer:tap];
  }
  return _collapseImage;
}

- (NSString *)hideIdCardPart:(NSString *)idCardNum {
  return [idCardNum stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
}

- (void)collaspClick:(UITapGestureRecognizer *)tap {
  UIView *view = tap.qmui_targetView;
  if ([self.delegate respondsToSelector:@selector(collaspView:)]) {
    [self.delegate collaspView:view];
  }
}

- (void)setIsEdit:(BOOL)isEdit {
  _isEdit = isEdit;
  if (isEdit) {
    [self.checkBox
     mas_updateConstraints:^(MASConstraintMaker *make) { make.width.mas_equalTo(20); }];
    self.checkBox.hidden = false;
  } else {
    [self.checkBox
     mas_updateConstraints:^(MASConstraintMaker *make) { make.width.mas_equalTo(0); }];
    self.checkBox.hidden = YES;
  }
  [self.checkBox setNeedsLayout];
  [self.checkBox layoutIfNeeded];
  [self.checkContainer setNeedsLayout];
  [self.checkContainer layoutIfNeeded];
}

- (void)checkSet:(BOOL)selected {
  [self.checkBox setOn:selected animated:YES];
}

- (BOOL)getCheckSelected {
  return self.checkBox.on;
}
@end
