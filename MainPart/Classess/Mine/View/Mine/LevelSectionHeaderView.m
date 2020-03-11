//
//  LevelSectionHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LevelSectionHeaderView.h"
#import "CircleSpringView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface LevelSectionHeaderView () <GenerateEntityDelegate> {
  BOOL initalize;
}
@property (nonatomic, strong) UIView *levelContainer;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) QMUILabel *levelTitle;
@end

@implementation LevelSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.qmui_borderColor = UIColor.qd_separatorColor;
    self.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.qmui_borderWidth = 0.5;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!initalize) {
    [self generateCircleSpringView:self.waveView.frame center:self.center];
    initalize = true;
  }
}

- (void)generateRootView {
  addView(self, self.levelContainer);
  addView(self.levelContainer, self.waveView);
  addView(self.levelContainer, self.levelLabel);
  addView(self.levelContainer, self.levelTitle);
  
  [self.levelContainer
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
  
  [self.levelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.levelContainer).with.inset(0.5 * SPACE);
  }];
  
  [self.waveView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self.levelContainer).with.inset(SPACE);
    make.centerX.centerY.equalTo(self.levelContainer);
    make.width.equalTo(self.waveView.mas_height);
  }];
  
  [self.levelLabel
   mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(self.waveView); }];
}

- (HWWaveView *)waveView {
  if (!_waveView) {
    _waveView = [[HWWaveView alloc] initWithFrame:CGRectMake(50, 50, 80, 80)];
    _waveView.progress = (arc4random() % 1600) * 1. / 1600;
  }
  return _waveView;
}

- (UILabel *)levelLabel {
  if (!_levelLabel) {
    _levelLabel = [UILabel new];
    _levelLabel.numberOfLines = 0;
    _levelLabel.attributedText =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append([NSString stringWithFormat:@"%u", (arc4random() % 1600)])
      .textColor(UIColor.qd_mainTextColor)
      .font(UIFontBoldMake(40));
      make.append(@"\n超过98%的人").textColor(UIColor.qd_mainTextColor).font(UIFontMake(18));
    }];
  }
  return _levelLabel;
}

- (UIView *)levelContainer {
  if (!_levelContainer) {
    _levelContainer = [UIView new];
    _levelContainer.backgroundColor = UIColor.qd_backgroundColor;
  }
  return _levelContainer;
}

- (QMUILabel *)levelTitle {
  if (!_levelTitle) {
    _levelTitle = [QMUILabel new];
    _levelTitle.text = @"旅行成长值";
    _levelTitle.textColor = UIColor.qd_mainTextColor;
    _levelTitle.font = UIFontLightMake(18);
    _levelTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _levelTitle.qmui_borderColor = UIColor.orangeColor;
    _levelTitle.qmui_borderWidth = 2;
    _levelTitle.qmui_borderPosition = QMUIViewBorderPositionLeft;
  }
  return _levelTitle;
}

- (void)generateCircleSpringView:(CGRect)rect center:(CGPoint)center {
  CircleSpringView *springView = nil;
  int count = arc4random() % 5 + 2;
  for (int i = 0; i < count;) {
    int randomR = arc4random() % (int)(SPACE) + rect.size.width + 40;
    CGFloat pointY = arc4random() % randomR + 30;
    CGFloat minX =
    -sqrtf(randomR * randomR - (pointY - DEVICE_HEIGHT / 8) * (pointY - DEVICE_HEIGHT / 8)) +
    center.x;
    CGFloat maxX =
    sqrtf(randomR * randomR - (pointY - DEVICE_HEIGHT / 8) * (pointY - DEVICE_HEIGHT / 8)) +
    center.x;
    springView = [[CircleSpringView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    springView.center = CGPointMake(minX, pointY);
    [self.levelContainer insertSubview:springView belowSubview:self.levelTitle];
    springView = [[CircleSpringView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    springView.center = springView.center = CGPointMake(maxX, pointY);
    [self.levelContainer insertSubview:springView belowSubview:self.levelTitle];
    i += 2;
  }
}

@end
