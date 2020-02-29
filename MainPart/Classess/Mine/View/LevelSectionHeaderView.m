//
//  LevelSectionHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LevelSectionHeaderView.h"
#import "MarkUtils.h"

@interface LevelSectionHeaderView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *levelContainer;
@end

@implementation LevelSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.levelContainer);
  addView(self.levelContainer, self.levelView);
  
  [self.levelContainer
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
  
  [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
    make.height.equalTo(self.levelContainer).offset(-SPACE);
    make.width.equalTo(self.levelView.mas_height);
  }];
}

- (ZZCircleProgress *)levelView {
  if (!_levelView) {
    _levelView = [[ZZCircleProgress alloc] initWithFrame:CGRectZero
                                           pathBackColor:UIColor.qd_placeholderColor
                                           pathFillColor:UIColor.qmui_randomColor
                                              startAngle:130
                                             strokeWidth:20];
    _levelView.progress = (arc4random() % 1600) * 1. / 1600;
    _levelView.reduceAngle = 80;
    _levelView.pointImage.image = UIImageMake(@"check_selected");
    _levelView.showProgressText = false;
    _levelView.increaseFromLast = YES;
    _levelView.progressLabel.text = @"目前登记16";
    _levelView.progressLabel.textColor = UIColor.qd_backgroundColor;
  }
  return _levelView;
}

- (UIView *)levelContainer {
  if (!_levelContainer) {
    _levelContainer = [UIView new];
    _levelContainer.backgroundColor = UIColor.qmui_randomColor;
  }
  return _levelContainer;
}
@end
