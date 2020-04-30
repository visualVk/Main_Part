//
//  MainDetailQuestionCell.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainDetailQuestionCell.h"
#import "MainQuestionController.h"
#import "MarkUtils.h"

@interface MainDetailQuestionCell () <GenerateEntityDelegate>
@property (nonatomic, weak) UIViewController *paCon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUILabel *questionMark;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) UIView *ansGroup;
@property (nonatomic, strong) QMUIButton *travelAns;
@property (nonatomic, strong) QMUIButton *supplierAns;
@property (nonatomic, strong) UIView *container;
@end

@implementation MainDetailQuestionCell

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
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.title);
    addView(_container, self.questionMark);
    addView(_container, self.question);
    addView(_container, self.ansGroup);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.equalTo(_container).with.inset(15);
    }];
    
    [self.questionMark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.title);
      make.top.equalTo(self.title.mas_bottom).with.inset(15);
    }];
    
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.questionMark.mas_right).with.inset(15);
      make.top.equalTo(self.questionMark);
      make.right.lessThanOrEqualTo(_container).with.inset(15);
    }];
    
    [self.ansGroup mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_container);
      make.top.equalTo(self.question.mas_bottom).with.inset(10);
      make.bottom.equalTo(_container).with.inset(15);
    }];
  }
  return _container;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"疑问答疑";
    _title.font = UIFontBoldMake(22);
  }
  return _title;
}

- (QMUILabel *)questionMark {
  if (!_questionMark) {
    _questionMark = [QMUILabel new];
    _questionMark.highlightedTextColor = UIColorWhite;
    _questionMark.highlightedBackgroundColor = UIColorMakeWithHex(@"#1292DF");
    _questionMark.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _questionMark.layer.cornerRadius = 2;
    _questionMark.layer.masksToBounds = true;
    _questionMark.text = @"问大家";
    _questionMark.backgroundColor = UIColorMakeWithHex(@"#1292DF");
    _questionMark.textColor = UIColor.whiteColor;
    _questionMark.font = UIFontMake(16);
  }
  return _questionMark;
}

- (UILabel *)question {
  if (!_question) {
    _question = [UILabel new];
    _question.text = @"这家酒店房间内设施齐全吗，是否有乱收费现象?";
    _question.numberOfLines = 0;
    _question.font = UIFontMake(19);
  }
  return _question;
}
- (UIView *)ansGroup {
  if (!_ansGroup) {
    _ansGroup = [UIView new];
    addView(_ansGroup, self.travelAns);
    addView(_ansGroup, self.supplierAns);
    
    [self.travelAns mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self.supplierAns.mas_left).with.inset(5);
      make.left.top.bottom.equalTo(_ansGroup);
    }];
    
    [self.supplierAns mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.top.bottom.equalTo(_ansGroup);
    }];
    
    //    [_ansGroup mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.top.bottom.equalTo(self.travelAns);
    //      make.left.equalTo(self.travelAns);
    //      make.right.equalTo(self.supplierAns);
    //    }];
  }
  return _ansGroup;
}

- (QMUIButton *)travelAns {
  if (!_travelAns) {
    _travelAns = [QDUIHelper generateLightBorderedButton];
    _travelAns.backgroundColor = UIColor.clearColor;
    _travelAns.titleLabel.font = UIFontMake(18);
    _travelAns.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [_travelAns setTitle:@"查看用户回答" forState:UIControlStateNormal];
    /// todo:
    [_travelAns addTarget:self
                   action:@selector(moreQuestionJump)
         forControlEvents:UIControlEventTouchUpInside];
  }
  return _travelAns;
}

- (QMUIButton *)supplierAns {
  if (!_supplierAns) {
    _supplierAns = [QDUIHelper generateLightBorderedButton];
    _supplierAns.backgroundColor = UIColor.clearColor;
    _supplierAns.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _supplierAns.titleLabel.font = UIFontMake(18);
    [_supplierAns setTitle:@"咨询商家" forState:UIControlStateNormal];
    /// todo:
  }
  return _supplierAns;
}

- (void)moreQuestionJump {
  if (!self.paCon) { self.paCon = self.qmui_viewController; }
  MainQuestionController *mqCon = [MainQuestionController new];
  [self.paCon.navigationController pushViewController:mqCon animated:YES];
}
@end
