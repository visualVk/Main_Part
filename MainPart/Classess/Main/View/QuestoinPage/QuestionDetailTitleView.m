
//
//  QuestionDetailTitleView.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QuestionDetailTitleView.h"
#import "MarkUtils.h"

@interface QuestionDetailTitleView () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *questionMark;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) UILabel *questionDate;
@property (nonatomic, strong) UILabel *hotelName;
@end

@implementation QuestionDetailTitleView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.hotelName);
  addView(self, self.questionMark);
  addView(self, self.question);
  addView(self, self.questionDate);
  
  [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self).with.inset(15);
  }];
  
  [self.questionMark mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(15);
    make.top.equalTo(self.hotelName.mas_bottom).with.inset(10);
  }];
  
  [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.questionMark.mas_right).with.inset(10);
    make.centerY.equalTo(self.questionMark);
  }];
  
  [self.questionDate mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.question.mas_bottom).with.inset(10);
    make.left.equalTo(self.question);
    make.bottom.equalTo(self).with.inset(15);
  }];
}

- (QMUILabel *)questionMark {
  if (!_questionMark) {
    _questionMark = [QMUILabel new];
    _questionMark.highlightedBackgroundColor = nil;
    _questionMark.highlightedTextColor = nil;
    _questionMark.text = @"问";
    _questionMark.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _questionMark.font = UIFontMake(16);
    _questionMark.backgroundColor = UIColor.systemBlueColor;
    _questionMark.textColor = UIColorWhite;
    _questionMark.layer.cornerRadius = 2;
    _questionMark.layer.masksToBounds = YES;
  }
  return _questionMark;
}

- (UILabel *)question {
  if (!_question) {
    _question = [UILabel new];
    _question.text = @"临时问题";
    _question.font = UIFontBoldMake(16);
    _question.numberOfLines = 0;
  }
  return _question;
}

- (UILabel *)questionDate {
  if (!_questionDate) {
    _questionDate = [UILabel new];
    _questionDate.text = @"2015-01-05 提问";
    _questionDate.textColor = UIColor.lightGrayColor;
    _questionDate.font = UIFontMake(14);
  }
  return _questionDate;
}
- (UILabel *)hotelName {
  if (!_hotelName) {
    _hotelName = [UILabel new];
    _hotelName.text = @"xxx";
    _hotelName.font = UIFontMake(20);
  }
  return _hotelName;
}
@end
