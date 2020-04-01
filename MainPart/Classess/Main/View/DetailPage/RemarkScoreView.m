//
//  RemarkScoreView.m
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkScoreView.h"
#import "HWProgressView.h"
#import "MarkUtils.h"

@interface RemarkScoreView () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) HWProgressView *progressView;
@property (nonatomic, strong) UILabel *score;
@end

@implementation RemarkScoreView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (instancetype)initWithTitle:(NSString *)title {
  if (self = [super init]) {
    [self generateRootView];
    self.title.text = title;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.title);
  addView(self, self.progressView);
  addView(self, self.score);
  
  [self.title
   mas_makeConstraints:^(MASConstraintMaker *make) { make.left.top.bottom.equalTo(self); }];
  
  [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title.mas_right);
    make.top.bottom.equalTo(self);
  }];
  
  [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.progressView.mas_right);
    make.right.equalTo(self);
    make.top.bottom.equalTo(self);
  }];
  [self.progressView setNeedsLayout];
  [self.progressView layoutIfNeeded];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"xxx";
    _title.font = UIFontMake(15);
    _title.textColor = UIColor.lightGrayColor;
  }
  return _title;
}

- (HWProgressView *)progressView {
  if (!_progressView) { _progressView = [[HWProgressView alloc] initWithFrame:CGRectZero]; }
  return _progressView;
}

- (UILabel *)score {
  if (!_score) {
    _score = [UILabel new];
    _score.text = @"5.1";
    _score.textColor = UIColor.lightGrayColor;
    _score.font = UIFontMake(15);
  }
  return _score;
}

- (void)setScoreGrade:(NSString *)scoreGrade {
  _scoreGrade = scoreGrade;
  self.score.text = scoreGrade;
  self.progressView.progress = [scoreGrade floatValue]/5;
}
@end
