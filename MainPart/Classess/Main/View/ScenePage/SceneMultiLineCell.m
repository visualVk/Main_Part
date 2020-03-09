//
//  SceneMultiLineCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneMultiLineCell.h"
#import "MarkUtils.h"

@interface SceneMultiLineCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation SceneMultiLineCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.25 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.imageview);
    addView(_container, self.title);
    addView(_container, self.content);
    addView(_container, self.more);
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container).with.inset(0.25 * SPACE);
      make.centerY.equalTo(_container);
    }];
    
    [@[ self.title, self.content ] mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(self.imageview.mas_trailing);
      //      make.trailing.equalTo(self.more);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.more.mas_top);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.title.mas_bottom).with.inset(0.25 * SPACE);
    }];
    
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_container).with.inset(0.25 * SPACE);
      make.centerY.equalTo(_container);
    }];
  }
  return _container;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"gold");
  }
  return _imageview;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"暂停营业";
    _title.font = UIFontBoldMake(16);
    _title.textColor = UIColor.qd_mainTextColor;
  }
  return _title;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.text = @"游玩约需1天";
    _content.font = UIFontMake(13);
    _content.textColor = UIColor.qd_placeholderColor;
  }
  return _content;
}

- (UILabel *)more {
  if (!_more) {
    _more = [UILabel new];
    _more.text = @"更多详情";
    _more.textColor = UIColor.qd_tintColor;
    _more.font = UIFontMake(15);
  }
  return _more;
}
@end
