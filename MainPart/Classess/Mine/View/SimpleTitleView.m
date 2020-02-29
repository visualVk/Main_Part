//
//  SimpleTitleView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SimpleTitleView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface SimpleTitleView () <GenerateEntityDelegate>

@end

@implementation SimpleTitleView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.title);
  addView(self, self.accessoryTitle);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(self);
    make.bottom.equalTo(self).with.inset(5);
  }];
  
  CGSize size = [self.accessoryTitle sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
  [self.accessoryTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self);
    make.bottom.equalTo(self.title);
    make.height.mas_equalTo(size.height);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(18);
    _title.text = @"我的工具";
  }
  return _title;
}

- (UILabel *)accessoryTitle {
  if (!_accessoryTitle) {
    _accessoryTitle = [UILabel new];
    _accessoryTitle.attributedText = [SimpleTitleView generateAccessoryTitle:@"我的工具"];
  }
  return _accessoryTitle;
}

+ (NSAttributedString *)generateAccessoryTitle:(NSString *)accessorytitle {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.font(UIFontMake(13)).textColor(UIColor.qd_placeholderColor);
    if (accessorytitle != nil || ![accessorytitle isEqualToString:@""]) {
      make.append(accessorytitle);
    }
    make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
      make.image = UIImageMake(@"right_arrow_small");
      make.alignment = SJUTVerticalAlignmentCenter;
    });
  }];
  return str;
}
@end
