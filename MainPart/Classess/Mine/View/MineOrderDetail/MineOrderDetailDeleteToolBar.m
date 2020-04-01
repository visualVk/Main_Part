
//
//  MineOrderDetailDeleteToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderDetailDeleteToolBar.h"
#import "MarkUtils.h"
#import <BEMCheckBox.h>

@interface MineOrderDetailDeleteToolBar () <GenerateEntityDelegate, BEMCheckBoxDelegate>
@property (nonatomic, strong) BEMCheckBox *checkBox;
@property (nonatomic, strong) UILabel *allSelectLB;
@property (nonatomic, strong) UILabel *deleteLB;
@end

@implementation MineOrderDetailDeleteToolBar

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.whiteColor;
    self.qmui_borderColor = UIColor.qd_separatorColor;
    self.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    self.qmui_borderWidth = 1;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.checkBox);
  addView(self, self.allSelectLB);
  addView(self, self.deleteLB);
  
  [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(0.5 * SPACE);
    make.centerY.equalTo(self);
    make.height.equalTo(self.checkBox.mas_width);
  }];
  
  [self.allSelectLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.checkBox.mas_right).with.inset(0.25 * SPACE);
    make.centerY.equalTo(self);
  }];
  
  [self.deleteLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).with.inset(0.5 * SPACE);
    make.centerY.equalTo(self);
  }];
}

- (BEMCheckBox *)checkBox {
  if (!_checkBox) {
    _checkBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _checkBox.delegate = self;
    _checkBox.onAnimationType = BEMAnimationTypeFill;
    _checkBox.offAnimationType = BEMAnimationTypeFill;
    _checkBox.onTintColor = UIColor.orangeColor;
    _checkBox.onCheckColor = UIColor.whiteColor;
    _checkBox.onFillColor = UIColor.orangeColor;
  }
  return _checkBox;
}

- (UILabel *)allSelectLB {
  if (!_allSelectLB) {
    _allSelectLB = [UILabel new];
    _allSelectLB.text = @"全选";
  }
  return _allSelectLB;
}

- (UILabel *)deleteLB {
  if (!_deleteLB) {
    _deleteLB = [UILabel new];
    _deleteLB.textColor = UIColor.redColor;
    _deleteLB.text = @"退订";
    _deleteLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSelected)];
    [_deleteLB addGestureRecognizer:tap];
  }
  return _deleteLB;
}

- (void)deleteSelected {
  if (self.deleteBlock) self.deleteBlock();
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
  if (self.allSelectLB) self.allSelectBlock(checkBox.on);
}
@end
