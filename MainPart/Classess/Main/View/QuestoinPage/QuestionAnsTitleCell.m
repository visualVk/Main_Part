//
//  QuestionAnsTitleCell.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QuestionAnsTitleCell.h"
#import "MarkUtils.h"

@interface QuestionAnsTitleCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *ansMark;
@property (nonatomic, strong) UILabel *ans;
@end

@implementation QuestionAnsTitleCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  addView(self, self.ansMark);
  addView(self, self.ans);
  
  [self.ansMark mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.bottom.equalTo(self).with.inset(10);
  }];
  
  [self.ans mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.ansMark.mas_right).with.inset(7);
    make.top.equalTo(self.ansMark);
  }];
}

- (QMUILabel *)ansMark {
  if (!_ansMark) {
    _ansMark = [QMUILabel new];
    _ansMark.text = @"答";
    _ansMark.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _ansMark.highlightedBackgroundColor = nil;
    _ansMark.highlightedTextColor = nil;
    _ansMark.textColor = UIColorWhite;
    _ansMark.backgroundColor = UIColor.systemOrangeColor;
    _ansMark.font = UIFontMake(16);
    _ansMark.layer.cornerRadius = 2;
    _ansMark.layer.masksToBounds = YES;
  }
  return _ansMark;
}

- (UILabel *)ans {
  if (!_ans) {
    _ans = [UILabel new];
    _ans.text = @"全部回答";
    _ans.font = UIFontMake(16);
  }
  return _ans;
}
@end
