//
//  QuestionToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QuestionToolBar.h"
#import "MarkUtils.h"

@interface QuestionToolBar () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *supplerImg;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) QMUIButton *questionBtn;
@end

@implementation QuestionToolBar

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
    _container.qmui_borderColor = UIColor.blackColor;
    _container.qmui_borderPosition = QMUIViewBorderPositionTop;
    addView(_container, self.supplerImg);
    addView(_container, self.question);
    addView(_container, self.questionBtn);
    
    [self.supplerImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_container).with.inset(20);
      make.left.equalTo(_container).with.inset(15);
    }];
    
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.supplerImg.mas_right).with.inset(5);
      make.centerY.equalTo(self.supplerImg);
    }];
    
    [self.questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(self.supplerImg);
      make.right.equalTo(_container).with.inset(15);
    }];
  }
  return _container;
}

- (UIImageView *)supplerImg {
  if (!_supplerImg) {
    _supplerImg = [UIImageView new];
    _supplerImg.image = UIImageMake(@"client");
    _supplerImg.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _supplerImg;
}

- (UILabel *)question {
  if (!_question) {
    _question = [UILabel new];
    _question.text = @"问问大家";
    _question.font = UIFontMake(20);
    _question.textColor = UIColor.lightGrayColor;
  }
  return _question;
}

- (QMUIButton *)questionBtn {
  if (!_questionBtn) {
    _questionBtn = [QDUIHelper generateDarkFilledButton];
    _questionBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_questionBtn setTitle:@"马上提问" forState:UIControlStateNormal];
    [_questionBtn addTarget:self
                     action:@selector(presentTap)
           forControlEvents:UIControlEventTouchUpInside];
  }
  return _questionBtn;
}

- (void)presentTap {
  if (self.questionBlock) { self.questionBlock(); }
}
@end
