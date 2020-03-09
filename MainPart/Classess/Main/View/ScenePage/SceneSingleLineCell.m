//
//  SceneSingleLineCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneSingleLineCell.h"
#import "MarkUtils.h"

@interface SceneSingleLineCell () <GenerateEntityDelegate>
@end

@implementation SceneSingleLineCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.clipsToBounds = YES;
  }
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
    _container.layer.cornerRadius = 5;
    _container.layer.borderColor = UIColor.clearColor.CGColor;
    _container.layer.masksToBounds = YES;
    addView(_container, self.imageview);
    addView(_container, self.content);
    addView(_container, self.arrowImg);
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(_container).with.inset(0.25 * SPACE);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.imageview.mas_right);
      make.centerY.equalTo(_container);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_container);
      make.centerY.equalTo(_container);
    }];
  }
  return _container;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"gold");
    //    _imageview.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _imageview;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.text = @"asdasdasdasdasdasda";
    _content.textColor = UIColor.qd_mainTextColor;
    _content.font = UIFontBoldMake(16);
  }
  return _content;
}

- (UIImageView *)arrowImg {
  if (!_arrowImg) {
    _arrowImg = [UIImageView new];
    _arrowImg.image = UIImageMake(@"right_arrow_small");
  }
  return _arrowImg;
}
@end
