//
//  MineActivityBannerCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineActivityBannerCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "WefareCell.h"
#import <ZZCircleProgress.h>
#define WELFARECELL @"welfarecell"

@interface MineActivityBannerCell () <GenerateEntityDelegate, UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UICollectionView *banner;
@property (nonatomic, strong) WOPageControl *pageCon;
@end

@implementation MineActivityBannerCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.datas = @[ @"", @"", @"", @"", @"", @"" ];
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
  
  addView(superview, self.banner);
  addView(superview, self.pageCon);
  
  [self.banner mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  
  [self.pageCon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview);
    make.bottom.equalTo(superview).with.inset(10);
    make.width.mas_equalTo(DEVICE_WIDTH / 3);
    make.height.mas_equalTo(5);
  }];
}

- (UICollectionView *)banner {
  if (!_banner) {
    QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                              initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 2;
    layout.pagingThreshold = 0.55;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _banner = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _banner.backgroundColor = UIColor.clearColor;
    _banner.pagingEnabled = YES;
    _banner.showsHorizontalScrollIndicator = false;
    _banner.showsVerticalScrollIndicator = false;
    [_banner registerClass:WefareCell.class forCellWithReuseIdentifier:WELFARECELL];
    _banner.delegate = self;
    _banner.dataSource = self;
  }
  return _banner;
}

- (WOPageControl *)pageCon {
  if (!_pageCon) {
    _pageCon = [[WOPageControl alloc] initWithFrame:CGRectZero];
    _pageCon.cornerRadius = 2.5;
    _pageCon.dotHeight = 5;
    _pageCon.dotSpace = 10;
    _pageCon.currentDotWidth = 20;
    _pageCon.otherDotWidth = 10;
    _pageCon.otherDotColor = UIColor.qd_tintColor;
    _pageCon.currentDotColor = UIColor.qmui_randomColor;
    _pageCon.numberOfPages = self.datas.count;
    _pageCon.currentPage = 0;
  }
  return _pageCon;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  WefareCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:WELFARECELL forIndexPath:indexPath];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake((collectionView.frame.size.width), collectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"mine activity view", @"collection cell:%li", indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat width = self.banner.frame.size.width;
  NSInteger page = scrollView.contentOffset.x / width + 0.44;
  self.pageCon.currentPage = page;
  QMUILogInfo(@"mine activity view", @"scroll-x:%f,page:%li", scrollView.contentOffset.x, page);
}
@end
