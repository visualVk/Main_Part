//
//  MineInfoCheckBoxCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineInfoCheckBoxCell.h"
#import "MarkUtils.h"
@interface MineInfoCheckBoxCell () <GenerateEntityDelegate, BEMCheckBoxDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *maleLB;
@property (nonatomic, strong) UILabel *femaleLB;

@property (nonatomic, strong) UIView *maleContainer;
@property (nonatomic, strong) UIView *femaleContainer;
@end

@implementation MineInfoCheckBoxCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self checkGroup];
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
  addView(self.contentView, self.container);
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.contentView); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.qmui_borderColor = UIColor.qd_separatorColor;
    _container.qmui_borderWidth = 0.5;
    _container.qmui_borderPosition = QMUIViewBorderPositionBottom;
    addView(_container, self.title);
    addView(_container, self.maleContainer);
    addView(_container, self.femaleContainer);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.bottom.top.equalTo(_container).with.inset(0.5 * SPACE);
      make.width.equalTo(_container).multipliedBy(0.25);
    }];
    
    [self.maleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.title.mas_right);
      //      make.top.bottom.equalTo(_container).with.inset(0.5 * SPACE);
      make.centerY.equalTo(_container);
      make.width.equalTo(self.femaleContainer);
    }];
    
    [self.femaleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.maleContainer.mas_right);
      //      make.top.bottom.equalTo(_container).with.inset(0.5 * SPACE);
      make.centerY.equalTo(_container);
      make.width.equalTo(self.maleContainer);
      make.right.equalTo(_container).with.inset(0.5 * SPACE);
    }];
  }
  return _container;
}

#pragma mark - male container
- (UIView *)maleContainer {
  if (!_maleContainer) {
    _maleContainer = [UIView new];
    addView(_maleContainer, self.maleCheck);
    addView(_maleContainer, self.maleLB);
    
    [self.maleCheck mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_maleContainer);
      make.top.bottom.equalTo(self.maleLB);
      make.width.equalTo(self.maleCheck.mas_height);
    }];
    
    [self.maleLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_maleContainer);
      make.right.equalTo(_maleContainer);
      make.left.equalTo(self.maleCheck.mas_right).with.inset(5);
    }];
  }
  return _maleContainer;
}

- (UIView *)femaleContainer {
  if (!_femaleContainer) {
    _femaleContainer = [UIView new];
    addView(_femaleContainer, self.femaleLB);
    addView(_femaleContainer, self.femaleCheck);
    
    [self.femaleCheck mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_femaleContainer);
      make.top.bottom.equalTo(self.femaleLB);
      make.width.equalTo(self.femaleCheck.mas_height);
    }];
    
    [self.femaleLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_femaleContainer);
      make.right.equalTo(_femaleContainer);
      make.left.equalTo(self.femaleCheck.mas_right).with.inset(5);
    }];
  }
  return _femaleContainer;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"名字";
    _title.textColor = UIColor.qd_placeholderColor;
    _title.font = UIFontMake(18);
  }
  return _title;
}

- (UILabel *)maleLB {
  if (!_maleLB) {
    _maleLB = [UILabel new];
    _maleLB.text = @"男";
    _maleLB.textColor = UIColorBlack;
    _maleLB.font = UIFontMake(18);
  }
  return _maleLB;
}

- (UILabel *)femaleLB {
  if (!_femaleLB) {
    _femaleLB = [UILabel new];
    _femaleLB.text = @"女";
    _femaleLB.textColor = UIColorBlack;
    _femaleLB.font = UIFontMake(18);
  }
  return _femaleLB;
}

- (BEMCheckBoxGroup *)checkGroup {
  if (!_checkGroup) {
    _checkGroup = [BEMCheckBoxGroup groupWithCheckBoxes:@[ self.maleCheck, self.femaleCheck ]];
    _checkGroup.selectedCheckBox = self.maleCheck;
    _checkGroup.mustHaveSelection = YES;
  }
  return _checkGroup;
}

- (BEMCheckBox *)maleCheck {
  if (!_maleCheck) {
    _maleCheck = [[BEMCheckBox alloc] init];
    _maleCheck.delegate = self;
  }
  return _maleCheck;
}

- (BEMCheckBox *)femaleCheck {
  if (!_femaleCheck) {
    _femaleCheck = [[BEMCheckBox alloc] init];
    _femaleCheck.delegate = self;
  }
  return _femaleCheck;
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
  NSString *result = @"0";
  if (checkBox == self.femaleCheck) { result = @"1"; }
  if ([self.delegate respondsToSelector:@selector(contentValueChange:content:)]) {
    [self.delegate contentValueChange:self.title.text content:result];
  }
}
@end
