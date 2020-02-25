//
//  PopController.m
//  MainPart
//
//  Created by blacksky on 2020/2/24.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PopController.h"
#import "DetailHeaderPartCell.h"
#import "MarkUtils.h"
#import <JQCollectionViewAlignLayout.h>
#define DETAILHEADERCELL @"detailheadercell"

@interface PopController () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, GenerateEntityDelegate>
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSArray *imageList;
@end

@implementation PopController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.imageList = @[ @"pink_gradient" ];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  self.view.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"";
}

- (void)generateRootView {
  addView(self.view, self.collectionview);
  
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.right.left.bottom.equalTo(self.view);
    //      make.height.mas_equalTo(600);
  }];
  //  self.collectionview.frame = CGRectMake(0, 0, DEVICE_WIDTH, 600);
}

#pragma mark - Lazy load
- (UICollectionView *)collectionview {
  if (!_collectionview) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    _collectionview.scrollEnabled = YES;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [_collectionview registerClass:DetailHeaderPartCell.class
        forCellWithReuseIdentifier:DETAILHEADERCELL];
  }
  return _collectionview;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:DETAILHEADERCELL
                                            forIndexPath:indexPath];
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  switch (section) {
    case 0:
      return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 3);
    case 1:
      return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 3);
  }
  return CGSizeMake(0, 0);
}
@end
