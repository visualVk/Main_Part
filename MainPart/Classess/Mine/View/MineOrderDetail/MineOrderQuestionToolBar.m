//
//  MineOrderQuestionToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderQuestionToolBar.h"
#import "MarkUtils.h"

@interface MineOrderQuestionToolBar () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation MineOrderQuestionToolBar

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
    addView(_container, self.askImg);
    addView(_container, self.askLabel);
    
    [self.askImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container).with.inset(0.5 * SPACE);
      make.centerY.equalTo(_container);
      //      make.top.bottom.equalTo(_container).with.inset(0.5 * SPACE);
      //      make.width.equalTo(self.askImg.mas_height);
    }];
    
    [self.askLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(self.askImg.mas_right).with.inset(0.25 * SPACE);
      make.bottom.top.equalTo(_container).with.inset(0.25 * SPACE);
    }];
  }
  return _container;
}

- (UIImageView *)askImg {
  if (!_askImg) {
    _askImg = [UIImageView new];
    _askImg.image = UIImageMake(@"client");
    //    _askImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _askImg;
}

- (QMUILabel *)askLabel {
  if (!_askLabel) {
    _askLabel = [QMUILabel new];
    _askLabel.highlightedTextColor = nil;
    _askLabel.highlightedBackgroundColor = nil;
    _askLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _askLabel.text = @"客服服务";
    _askLabel.font = UIFontMake(20);
    _askLabel.textColor = UIColor.qd_placeholderColor;
    _askLabel.qmui_borderColor = UIColor.qd_separatorColor;
    _askLabel.qmui_borderWidth = 0.5;
    _askLabel.qmui_borderPosition = QMUIViewBorderPositionLeft;
  }
  return _askLabel;
}
@end
