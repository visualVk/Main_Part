//
//  SceneHeaderCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneDetailHeaderCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface SceneDetailHeaderCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *leftContainer;
@property (nonatomic, strong) UIView *rightContainer;
@end

@implementation SceneDetailHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.leftContainer);
  addView(superview, self.rightContainer);
  
  [self.leftContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.leading.equalTo(superview);
    make.trailing.equalTo(self.rightContainer.mas_leading);
  }];
  
  [self.rightContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.height.equalTo(self.leftContainer);
    make.width.mas_equalTo((DEVICE_WIDTH - SPACE) * 2 / 7);
    make.trailing.equalTo(superview);
  }];
}

- (UIView *)leftContainer {
  if (!_leftContainer) {
    _leftContainer = [UIView new];
    addView(_leftContainer, self.sceneName);
    addView(_leftContainer, self.phrase);
    
    [self.sceneName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(_leftContainer).with.inset(0.5 * SPACE);
      make.top.equalTo(_leftContainer).with.inset(0.25 * SPACE);
      make.trailing.equalTo(_leftContainer);
    }];
    [self.phrase mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.trailing.equalTo(self.sceneName);
      make.top.equalTo(self.sceneName).with.inset(0.25 * SPACE);
      make.bottom.equalTo(_leftContainer).with.inset(0.25 * SPACE);
    }];
  }
  return _leftContainer;
}

- (UIView *)rightContainer {
  if (!_rightContainer) {
    _rightContainer = [UIView new];
    _rightContainer.qmui_borderColor = UIColor.qd_separatorColor;
    _rightContainer.qmui_borderPosition = QMUIViewBorderPositionLeft;
    addView(_rightContainer, self.score);
    addView(_rightContainer, self.remark);
    
    [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_rightContainer).with.inset(0.5 * SPACE);
      make.centerX.equalTo(_rightContainer);
    }];
    [self.remark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.score.mas_bottom).with.inset(0.25 * SPACE);
      make.bottom.equalTo(_rightContainer).with.inset(0.5 * SPACE);
      make.centerX.equalTo(self.score);
    }];
  }
  return _rightContainer;
}

- (UILabel *)sceneName {
  if (!_sceneName) {
    _sceneName = [UILabel new];
    _sceneName.textColor = UIColor.qd_mainTextColor;
    _sceneName.text = @"九寨沟风景区";
    _sceneName.font = UIFontBoldMake(22);
  }
  return _sceneName;
}

- (UILabel *)phrase {
  if (!_phrase) {
    _phrase = [UILabel new];
    _phrase.text = @"”九寨沟归来不看水“";
    _phrase.textColor = UIColor.qd_tintColor;
    _phrase.font = UIFontMake(13);
  }
  return _phrase;
}

- (UILabel *)score {
  if (!_score) {
    _score = [UILabel new];
    _score.attributedText = [self generateScore:@{ @"score" : @"4.5", @"fullScore" : @"5" }];
  }
  return _score;
}

- (UILabel *)remark {
  if (!_remark) {
    _remark = [UILabel new];
    //    _remark.text = @"11554条点评";
    //    _remark.textColor = UIColor.qd_placeholderColor;
    //    _remark.font = UIFontMake(16);
    _remark.attributedText = [self generateRemark:@{ @"remark" : @"12345" }];
  }
  return _remark;
}

- (NSAttributedString *)generateRemark:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.font(UIFontMake(13)).textColor(UIColor.qd_placeholderColor);
    make.alignment(NSTextAlignmentCenter);
    make.append([NSString stringWithFormat:@"%@条点评", infoDict[@"remark"]]);
    make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
      make.image = UIImageMake(@"right_arrow_small");
      make.alignment = SJUTVerticalAlignmentCenter;
    })
    .baseLineOffset(3);
  }];
  return str;
}

- (NSAttributedString *)generateScore:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(infoDict[@"score"]).textColor(UIColor.qd_tintColor).font(UIFontBoldMake(25));
    make.append([NSString stringWithFormat:@"/%@分", infoDict[@"fullScore"]])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(13));
  }];
  return str;
}
@end
