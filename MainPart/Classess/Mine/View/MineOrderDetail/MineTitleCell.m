//
//  MineTitleCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineTitleCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineTitleCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation MineTitleCell

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
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.titleImage);
    addView(_container, self.title);
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_container);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_container);
      make.left.equalTo(self.titleImage.mas_right);
    }];
  }
  return _container;
}

- (UIImageView *)titleImage {
  if (!_titleImage) { _titleImage = [UIImageView new]; }
  return _titleImage;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.numberOfLines = 0;
    NSAttributedString *str = [NSAttributedString sj_UIKitText:^(
                                                                 id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append(@"入住登记人信息\n").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(18));
      make.append(@"每一份信息对应一件房间，点击右边更多查看房间详情")
      .textColor(UIColor.qd_placeholderColor)
      .font(UIFontLightMake(13));
    }];
    _title.attributedText = str;
  }
  return _title;
}
@end
