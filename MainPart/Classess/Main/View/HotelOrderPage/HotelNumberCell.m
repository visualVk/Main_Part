//
//  NumberCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelNumberCell.h"
#import "MarkUtils.h"

@interface HotelNumberCell () <GenerateEntityDelegate>

@end

@implementation HotelNumberCell

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
  addView(superview, self.title);
  addView(superview, self.stepBtn);
  
  //  [@[ self.title, self.stepBtn ]
  //   mas_makeConstraints:^(MASConstraintMaker *make) { make.centerY.equalTo(superview); }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.left.equalTo(superview).with.inset(SPACE);
  }];
  
  [self.stepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(SPACE);
    make.width.mas_equalTo(DEVICE_WIDTH / 4);
    make.height.equalTo(self.title);
    make.centerY.equalTo(superview);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"间数";
    _title.font = UIFontMake(18);
  }
  return _title;
}

- (PPNumberButton *)stepBtn {
  if (!_stepBtn) {
    _stepBtn = [[PPNumberButton alloc] init];
    _stepBtn.shakeAnimation = YES;
    _stepBtn.currentNumber = 1;
    _stepBtn.minValue = 1;
    _stepBtn.maxValue = 20;
    _stepBtn.inputFieldFont = 18;
    //    _stepBtn.increaseTitle = @"+";
    //    _stepBtn.decreaseTitle = @"-";
    _stepBtn.increaseImage = UIImageMake(@"increase_taobao");
    _stepBtn.decreaseImage = UIImageMake(@"decrease_taobao");
    _stepBtn.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
      QMUILogInfo(@"hotel number cell", @"%lf", number);
    };
  }
  return _stepBtn;
}
@end
