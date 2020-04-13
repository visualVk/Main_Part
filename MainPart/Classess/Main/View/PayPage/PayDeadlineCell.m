//
//  PayDeadlineCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PayDeadlineCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface PayDeadlineCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation PayDeadlineCell

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
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(superview);
    make.top.left.greaterThanOrEqualTo(superview);
    make.bottom.right.lessThanOrEqualTo(superview);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.shouldPay);
    addView(_container, self.deadlineTime);
    
    [self.deadlineTime
     mas_makeConstraints:^(MASConstraintMaker *make) { make.top.equalTo(_container); }];
    
    [self.shouldPay mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.deadlineTime.mas_bottom).with.inset(0.5 * SPACE);
      make.centerX.equalTo(self.deadlineTime);
      make.bottom.equalTo(_container);
    }];
    
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.leading.equalTo(self.deadlineTime);
    }];
  }
  return _container;
}

- (UILabel *)deadlineTime {
  if (!_deadlineTime) {
    _deadlineTime = [UILabel new];
    _deadlineTime.textColor = UIColor.qd_placeholderColor;
    _deadlineTime.font = UIFontMake(18);
    _deadlineTime.text = @"支付剩余时间: 00:00:00";
  }
  return _deadlineTime;
}

- (UILabel *)shouldPay {
  if (!_shouldPay) {
    _shouldPay = [UILabel new];
    _shouldPay.attributedText = [self generateShouldPay:@"200"];
  }
  return _shouldPay;
}

- (NSAttributedString *)generateShouldPay:(NSString *)money {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_mainTextColor);
    make.append(@"¥ ").font(UIFontBoldMake(25));
    make.append(money).font(UIFontBoldMake(30));
  }];
  return str;
}

- (void)reloadShouldPay:(NSString *)price {
  self.shouldPay.attributedText = [self generateShouldPay:price];
}
@end
