//
//  MoreQuestionCell.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MoreQuestionCell.h"
#import "MarkUtils.h"

@interface MoreQuestionCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *questionMark;
@property (nonatomic, strong) QMUILabel *ansMark;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) UILabel *ans;
@property (nonatomic, strong) UILabel *moreAns;
@property (nonatomic, strong) UILabel *questionDate;
@property (nonatomic, strong) UIView *container;
@end

@implementation MoreQuestionCell

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
  UIView *superview = self.contentView;
  addView(superview, self.container);
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.questionMark);
    addView(_container, self.question);
    addView(_container, self.ansMark);
    addView(_container, self.ans);
    addView(_container, self.moreAns);
    addView(_container, self.questionDate);
    
    [self.questionMark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(_container).with.inset(15);
    }];
    
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.questionMark);
      make.left.equalTo(self.questionMark.mas_right).with.inset(10);
    }];
    
    [self.ansMark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.questionMark.mas_bottom).with.inset(15);
      make.left.equalTo(self.questionMark);
    }];
    
    [self.ans mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.ansMark);
      make.left.equalTo(self.ansMark.mas_right).with.inset(10);
    }];
    
    [self.moreAns mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.ans.mas_bottom).with.inset(20);
      make.left.equalTo(self.ans);
    }];
    
    [self.questionDate mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.moreAns.mas_right).with.inset(15);
      make.top.equalTo(self.moreAns);
      make.bottom.equalTo(_container).with.inset(10);
    }];
  }
  return _container;
}

- (QMUILabel *)questionMark {
  if (!_questionMark) {
    _questionMark = [self generateMarkLabel:@"问"];
    _questionMark.backgroundColor = UIColor.systemBlueColor;
  }
  return _questionMark;
}

- (QMUILabel *)ansMark {
  if (!_ansMark) {
    _ansMark = [self generateMarkLabel:@"答"];
    _ansMark.backgroundColor = UIColor.systemOrangeColor;
  }
  return _ansMark;
}

- (UILabel *)question {
  if (!_question) {
    _question = [UILabel new];
    _question.textColor = UIColor.blackColor;
    _question.font = UIFontBoldMake(17);
    _question.numberOfLines = 0;
    _question.text = @"临时问题?";
  }
  return _question;
}

- (UILabel *)ans {
  if (!_ans) {
    _ans = [UILabel new];
    _ans.textColor = UIColor.grayColor;
    _ans.font = UIFontMake(17);
    _ans.numberOfLines = 0;
    _ans.text = @"临时答案";
  }
  return _ans;
}

- (UILabel *)moreAns {
  if (!_moreAns) {
    _moreAns = [UILabel new];
    _moreAns.text = @"全部回答";
    _moreAns.textColor = UIColor.qd_tintColor;
    _moreAns.font = UIFontMake(14);
  }
  return _moreAns;
}

- (UILabel *)questionDate {
  if (!_questionDate) {
    _questionDate = [UILabel new];
    _questionDate.text = @"2017-10-22 提问";
    _questionDate.textColor = UIColor.lightGrayColor;
    _questionDate.font = UIFontMake(14);
  }
  return _questionDate;
}

- (QMUILabel *)generateMarkLabel:(NSString *)title {
  QMUILabel *label = [QMUILabel new];
  label.textColor = UIColor.whiteColor;
  label.text = title;
  label.numberOfLines = 0;
  label.font = UIFontMake(16);
  label.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
  label.highlightedBackgroundColor = nil;
  label.highlightedTextColor = nil;
  label.layer.cornerRadius = 4;
  label.layer.masksToBounds = true;
  return label;
}
@end
