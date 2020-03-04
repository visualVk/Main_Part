//
//  MentionCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MentionCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MentionCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *topContainer;
@property (nonatomic, strong) UIView *bottomContainer;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@end

@implementation MentionCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
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
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.25 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.layer.cornerRadius = 8;
    _container.layer.masksToBounds = YES;
    addView(self.contentView, _container);
    addView(_container, self.topContainer);
    addView(_container, self.bottomContainer);
    
    [self.topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.trailing.leading.equalTo(_container);
    }];
    
    [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.topContainer.mas_bottom);
      make.leading.trailing.equalTo(self.topContainer);
      make.bottom.equalTo(_container);
    }];
    
    UIView *shadowView = [UIView new];
    shadowView.layer.shadowRadius = 8;
    shadowView.backgroundColor = UIColor.qd_backgroundColor;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowOpacity = 0.25;
    shadowView.layer.borderColor = UIColor.clearColor.CGColor;
    [self.contentView insertSubview:shadowView belowSubview:_container];
    [shadowView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
  }
  return _container;
}

- (UIView *)topContainer {
  if (!_topContainer) {
    _topContainer = [UIView new];
    _topContainer.backgroundColor = UIColor.qd_backgroundColor;
    _topContainer.qmui_borderColor = UIColor.qd_separatorColor;
    _topContainer.qmui_borderPosition = QMUIViewBorderPositionBottom;
    addView(_topContainer, self.title);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(_topContainer).with.inset(0.5 * SPACE);
      make.top.bottom.equalTo(_topContainer).with.inset(0.5 * SPACE);
    }];
  }
  return _topContainer;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"重要提示";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(22);
  }
  return _title;
}

- (UIView *)bottomContainer {
  if (!_bottomContainer) {
    _bottomContainer = [UIView new];
    _bottomContainer.backgroundColor = UIColor.qd_backgroundColor;
    addView(_bottomContainer, self.content);
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.trailing.equalTo(_bottomContainer).with.inset(0.5 * SPACE);
      make.top.bottom.equalTo(_bottomContainer).with.inset(SPACE);
    }];
  }
  return _bottomContainer;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.numberOfLines = 0;
    _content.attributedText = [self generateContent:@{
      @"content" : @"asdasdsa\ndasdadasd\nadsadsad\n"
    }];
  }
  return _content;
}

- (NSAttributedString *)generateContent:(NSDictionary *)infoDict {
  NSAttributedString *str = [NSAttributedString sj_UIKitText:^(
                                                               id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(@"服务提供方:\n").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(13));
    make.append(infoDict[@"content"]).textColor(UIColor.qd_placeholderColor).font(UIFontMake(13));
  }];
  return str;
}
@end
