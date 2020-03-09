//
//  MineOrderInfoTBCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderInfoTBCell.h"
#import "MarkUtils.h"

@interface MineOrderInfoTBCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation MineOrderInfoTBCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.clipsToBounds = YES;
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
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.titleL);
    addView(_container, self.detailL);
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.left.equalTo(_container);
      make.width.equalTo(_container).multipliedBy(0.25);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(self.titleL.mas_trailing);
      make.centerY.equalTo(_container);
    }];
  }
  return _container;
}

- (UILabel *)titleL {
  if (!_titleL) { _titleL = [self generateLabel]; }
  return _titleL;
}

- (UILabel *)detailL {
  if (!_detailL) { _detailL = [self generateLabel]; }
  return _detailL;
}

- (UILabel *)rightL {
  if (!_rightL) {
    _rightL = [self generateLabel];
    _rightL.userInteractionEnabled = YES;
    _rightL.textColor = UIColor.orangeColor;
    
    addView(self.container, _rightL);
    
    [_rightL mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.right.equalTo(self.container);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyDetailText)];
    [_rightL addGestureRecognizer:tap];
  }
  return _rightL;
}

- (void)copyDetailText {
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  pasteboard.string = self.detailL.text;
  QMUILogInfo(@"mine order info tb cell", @"copy content:%@", pasteboard.string);
  [QMUITips showWithText:@"已复制"
              detailText:@""
                  inView:UIApplication.sharedApplication.keyWindow
          hideAfterDelay:1];
}

- (UILabel *)generateLabel {
  UILabel *label = [UILabel new];
  label.text = @"订单编号:";
  label.textColor = UIColor.qd_titleTextColor;
  label.font = UIFontLightMake(13);
  return label;
}
@end
