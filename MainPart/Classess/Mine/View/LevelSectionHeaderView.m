//
//  LevelSectionHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LevelSectionHeaderView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface LevelSectionHeaderView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *levelContainer;
@property (nonatomic, strong) UILabel *levelLabel;
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
}

- (void)generateRootView {
  addView(self, self.levelContainer);
  addView(self.levelContainer, self.waveView);
  addView(self.levelContainer, self.levelLabel);
  
  [self.levelContainer
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
  
  [self.waveView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self.levelContainer).with.inset(SPACE);
    make.centerX.equalTo(self.levelContainer);
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
@end
