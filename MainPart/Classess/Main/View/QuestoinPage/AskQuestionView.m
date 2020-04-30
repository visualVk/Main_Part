//
//  AskQuestionView.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AskQuestionView.h"
#import "MarkUtils.h"

@interface AskQuestionView () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUITextView *textview;
@property (nonatomic, strong) QMUIButton *submitBtn;
@property (nonatomic, strong) UIView *container;
@end

@implementation AskQuestionView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.container);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.whiteColor;
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = true;
    addView(_container, self.textview);
    addView(_container, self.submitBtn);
    
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.top.equalTo(_container).with.inset(20);
      make.height.mas_equalTo(250);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(_container).with.inset(20);
      make.centerX.equalTo(_container);
      make.width.mas_equalTo(150);
    }];
  }
  return _container;
}

- (QMUITextView *)textview {
  if (!_textview) {
    _textview = [[QMUITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    _textview.layer.borderColor = UIColor.lightGrayColor.CGColor;
    _textview.font = UIFontMake(18);
    _textview.layer.borderWidth = 1;
    _textview.layer.cornerRadius = 5;
    _textview.layer.masksToBounds = YES;
  }
  return _textview;
}

- (QMUIButton *)submitBtn {
  if (!_submitBtn) {
    _submitBtn = [QDUIHelper generateDarkFilledButton];
    _submitBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [_submitBtn setTitle:@"发布问题" forState:UIControlStateNormal];
  }
  return _submitBtn;
}
@end
