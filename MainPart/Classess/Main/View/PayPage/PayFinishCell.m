//
//  PayFinishCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PayFinishCell.h"
#import "MarkUtils.h"

@interface PayFinishCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *payContainer;
@end

@implementation PayFinishCell

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
  addView(superview, self.image);
  addView(superview, self.payContainer);
  
  [self.superview
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  
  [self.payContainer
   mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(superview); }];
}

- (UIView *)payContainer {
  if (!_payContainer) {
    _payContainer = [UIView new];
    addView(_payContainer, self.successImage);
    addView(_payContainer, self.title);
    
    [self.successImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(_payContainer);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.successImage.mas_right);
      make.centerY.equalTo(self.successImage);
      make.right.equalTo(_payContainer);
    }];
  }
  return _payContainer;
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"pink_gradient");
    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"支付成功";
    _title.font = UIFontBoldMake(30);
    _title.textColor = UIColor.qd_mainTextColor;
  }
  return _title;
}

- (UIImageView *)successImage {
  if (!_successImage) {
    _successImage = [UIImageView new];
    _successImage.image = UIImageMake(@"pay_success");
  }
  return _successImage;
}

@end
