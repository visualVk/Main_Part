//
//  PayMethodCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PayMethodCell.h"
#import "MarkUtils.h"
#import "SelectCircleVIew.h"

@interface PayMethodCell () <GenerateEntityDelegate>
@property (nonatomic, strong) SelectCircleVIew *checkBox;
@end

@implementation PayMethodCell

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
  addView(superview, self.payImg);
  addView(superview, self.method);
  addView(superview, self.checkBox);
  
  [self.payImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.method mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.bottom.equalTo(self.payImg);
    make.centerY.equalTo(self.payImg);
    make.left.equalTo(self.payImg.mas_right).with.inset(0.5 * SPACE);
    //    make.trailing.equalTo(self.checkBox.mas_leading);
  }];
  
  [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self.method);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(self.checkBox.mas_height);
  }];
}

- (UIImageView *)payImg {
  if (!_payImg) {
    _payImg = [UIImageView new];
    _payImg.image = UIImageMake(@"pay");
    _payImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _payImg;
}

- (UILabel *)method {
  if (!_method) {
    _method = [UILabel new];
    _method.textColor = UIColor.qd_mainTextColor;
    _method.font = UIFontBoldMake(18);
    _method.text = @"支付宝";
  }
  return _method;
}

- (SelectCircleVIew *)checkBox {
  if (!_checkBox) { _checkBox = [SelectCircleVIew new]; }
  return _checkBox;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  //  [self.checkBox setOn:selected animated:YES];
  [self.checkBox selectCheckBox:selected];
  QMUILogInfo(@"pay method cell", @"select:{%@}", [self description]);
}
@end
