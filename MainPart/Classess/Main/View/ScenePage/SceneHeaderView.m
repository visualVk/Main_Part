//
//  SceneHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneHeaderView.h"
#import <JQCollectionViewAlignLayout.h>

@interface SceneHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, GenerateEntityDelegate>

@end

@implementation SceneHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.remarkOne.layer.cornerRadius = self.remarkOne.frame.size.height / 2;
  self.remarkOne.layer.masksToBounds = YES;
  self.remarkTwo.layer.cornerRadius = self.remarkTwo.frame.size.height / 2;
  self.remarkTwo.layer.masksToBounds = YES;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
}

#pragma mark - Lazy Init
- (SDCycleScrollView *)banner {
  if (!_banner) {
    _banner = [SDCycleScrollView
               cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT * 5 / 7)
               imageNamesGroup:@[ @"pink_gradient", @"pink_gradient", @"pink_gradient" ]];
    _banner.showPageControl = false;
  }
  return _banner;
}

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment = JQCollectionViewItemsHorizontalAlignmentCenter;
    _collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.qd_backgroundColor;
    _collectionView.layer.cornerRadius = 10;
    _collectionView.layer.masksToBounds = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (QMUILabel *)remarkOne {
  if (!_remarkOne) {
    _remarkOne = [self generateCommonLabel];
    _remarkOne.textColor = UIColor.qd_backgroundColor;
    _remarkOne.font = UIFontMake(13);
    _remarkOne.text = @"瀑布之景更为神奇秀丽";
  }
  return _remarkOne;
}

- (QMUILabel *)remarkTwo {
  if (!_remarkTwo) {
    _remarkTwo = [self generateCommonLabel];
    _remarkTwo.textColor = UIColor.qd_backgroundColor;
    _remarkTwo.font = UIFontMake(13);
    _remarkTwo.text = @"瀑布之景更为神奇秀丽";
  }
  return _remarkTwo;
}

- (QMUILabel *)generateCommonLabel {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
  label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
  label.highlightedTextColor = nil;
  label.highlightedBackgroundColor = nil;
  return label;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,JQCollectionViewAlignLayoutDelegate

@end
