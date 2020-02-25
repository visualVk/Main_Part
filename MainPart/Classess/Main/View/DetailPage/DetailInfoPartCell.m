//
//  DetailInfoPartCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/24.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailInfoPartCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface DetailInfoPartCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *view;
@end

@implementation DetailInfoPartCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self.contentView, self.view);
  [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(self.contentView);
    make.bottom.equalTo(self.contentView);
  }];
}

- (UIView *)view {
  if (!_view) {
    _view = [UIView new];
    [DetailInfoPartCell generateInfo:@{
      @"费用政策" : @"加早:中式早餐免费",
      @"便利设施" : @"多种规格电源插座，110V，客房WIFI免费",
      @"媒体设施" : @"小心心",
      @"视屏饮品" : @"24小时热水"
    }
                           superview:_view];
  }
  return _view;
}

+ (void)generateInfo:(NSDictionary *)infoList superview:(UIView *)superview {
  UILabel *leftLB = nil;
  UILabel *rightLB = nil;
  NSAttributedString *leftAttr = nil;
  NSAttributedString *rightAttr = nil;
  UIStackView *leftStack = [[UIStackView alloc] init];
  UIStackView *rightStack = [[UIStackView alloc] init];
  leftStack.axis = UILayoutConstraintAxisVertical;
  leftStack.distribution = UIStackViewDistributionFillEqually;
  leftStack.alignment = UIStackViewAlignmentLeading;
  rightStack.axis = UILayoutConstraintAxisVertical;
  rightStack.alignment = UIStackViewAlignmentLeading;
  rightStack.distribution = UIStackViewDistributionFillEqually;
  for (NSString *key in infoList.allKeys) {
    leftLB = [UILabel new];
    rightLB = [UILabel new];
    ;
    leftAttr = [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.font(UIFontMake(16)).textColor(UIColor.qd_mainTextColor);
      make.append(key);
    }];
    rightAttr = [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.font(UIFontBoldMake(16)).textColor(UIColor.qd_mainTextColor);
      make.append(infoList[key]);
      make.regex(@"免费").update(^(id<SJUTAttributesProtocol> _Nonnull make) {
        make.textColor(UIColor.qmui_randomColor);
      });
    }];
    leftLB.attributedText = leftAttr;
    rightLB.attributedText = rightAttr;
    leftLB.numberOfLines = 0;
    rightLB.numberOfLines = 0;
    [leftStack addArrangedSubview:leftLB];
    [rightStack addArrangedSubview:rightLB];
  }
  addView(superview, leftStack);
  addView(superview, rightStack);
  [leftStack mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.bottom.equalTo(superview);
    make.width.equalTo(superview).multipliedBy(1.0 / 5);
  }];
  
  [rightStack mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.left.equalTo(leftStack.mas_right).offset(0.5 * SPACE);
    make.bottom.equalTo(superview);
  }];
}
@end
