//
//  SceneSegSectionView.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneSegSectionView.h"
#import "MarkUtils.h"
#define SEGHEIGHT DEVICE_HEIGHT / 20

@interface SceneSegSectionView () <GenerateEntityDelegate>

@end

@implementation SceneSegSectionView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    self.qmui_borderColor = UIColor.qd_separatorColor;
    self.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.segCon);
  [self.segCon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self);
    make.height.mas_equalTo(SEGHEIGHT);
  }];
}

- (HMSegmentedControl *)segCon {
  if (!_segCon) {
    _segCon = [[HMSegmentedControl alloc] initWithSectionTitles:@[ @"景点", @"攻略", @"点评" ]];
    _segCon.selectedSegmentIndex = 0;
    _segCon.backgroundColor = UIColor.qd_backgroundColor;
    _segCon.titleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_titleTextColor,
      NSFontAttributeName : UIFontMake(18)
    };
    _segCon.selectedTitleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_tintColor,
      NSFontAttributeName : UIFontBoldMake(18)
    };
    _segCon.selectionIndicatorColor = UIColor.qd_tintColor;
    _segCon.selectionIndicatorHeight = 2;
    _segCon.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segCon.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
  }
  return _segCon;
}
@end
