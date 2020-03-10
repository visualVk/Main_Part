//
//  OrderDetailController.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderDetailController.h"
#import "MarkUtils.h"
#import "MineOrderCheckPersonInfoView.h"
#import "MineOrderHotelView.h"
#import "MineOrderInfoCell.h"
#import "MineOrderQuestionToolBar.h"
#import "MineOrderRoomInfoView.h"
#import <JQCollectionViewAlignLayout.h>
#define MINEORDERROOMINFOCELL @"mineorderroominfoview"
#define MINEORDERCHECKPERSONINFOVIEW @"mineordercheckpersoninfoview"
#define MINEORDERHOTELVIEW @"mineorderhotelview"
#define MINEORDERINFOCELL @"mineorderinfocell"

@interface OrderDetailController () <GenerateEntityDelegate, UICollectionViewDelegate,
UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, MineOrderCollaspeDelegate>
@property (nonatomic, strong) MineOrderQuestionToolBar *queToolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collaspeList;
@end

@implementation OrderDetailController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.collaspeList = [NSMutableArray arrayWithArray:@[ @"0", @"0", @"0" ]];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
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
  self.title = @"订单详情";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.collectionView);
  addView(self.view, self.queToolBar);
  
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    //    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.bottom.equalTo(self.queToolBar.mas_top);
  }];
  
  [self.queToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.left.right.equalTo(self.view);
    make.height.mas_equalTo(DEVICE_HEIGHT / 15);
  }];
}

#pragma mark - Lazy Init
- (UICollectionView *)collectionView {
  if (!_collectionView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0.5 * SPACE, 0);
    _collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.qd_customBackgroundColor;
    [_collectionView registerClass:MineOrderRoomInfoView.class
        forCellWithReuseIdentifier:MINEORDERROOMINFOCELL];
    [_collectionView registerClass:MineOrderCheckPersonInfoView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:MINEORDERCHECKPERSONINFOVIEW];
    [_collectionView registerClass:MineOrderHotelView.class
        forCellWithReuseIdentifier:MINEORDERHOTELVIEW];
    [_collectionView registerClass:UICollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"default"];
    [_collectionView registerClass:MineOrderInfoCell.class
        forCellWithReuseIdentifier:MINEORDERINFOCELL];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (MineOrderQuestionToolBar *)queToolBar {
  if (!_queToolBar) { _queToolBar = [MineOrderQuestionToolBar new]; }
  return _queToolBar;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 10);
  if (section > 0 && section < 4) {
    if ([@"0" isEqualToString:self.collaspeList[section - 1]]) {
      return CGSizeMake(DEVICE_WIDTH, 0);
    }
    return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 4);
  }
  if (section == 4) return CGSizeMake(DEVICE_WIDTH, 1.25 * SPACE + 85);
  return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0 || section == 4) {
    UICollectionReusableView *defaultHeader =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:@"default"
                                              forIndexPath:indexPath];
    return defaultHeader;
  }
  MineOrderCheckPersonInfoView *header =
  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                     withReuseIdentifier:MINEORDERCHECKPERSONINFOVIEW
                                            forIndexPath:indexPath];
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    header.tag = indexPath.section;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(collapseSectionHeader:)];
    [header addGestureRecognizer:tap];
  }
  return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
  return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  if (section == 0 || section == 4) return CGSizeMake(DEVICE_WIDTH, 0);
  return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    MineOrderHotelView *morhCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERHOTELVIEW
                                              forIndexPath:indexPath];
    return morhCell;
  }
  if (section == 4) {
    MineOrderInfoCell *moiCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERINFOCELL
                                              forIndexPath:indexPath];
    return moiCell;
  }
  MineOrderRoomInfoView *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERROOMINFOCELL
                                            forIndexPath:indexPath];
  [cell resetStatus];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
  //  MineOrderRoomInfoView *roriCell = (MineOrderRoomInfoView *)cell;
  //  [roriCell resetStatus];
}

- (void)collapseSectionHeader:(UITapGestureRecognizer *)tap {
  NSInteger section = tap.qmui_targetView.tag;
  if ([@"0" isEqualToString:self.collaspeList[section - 1]]) {
    self.collaspeList[section - 1] = @"1";
  } else {
    self.collaspeList[section - 1] = @"0";
  }
  [UIView performWithoutAnimation:^{
    [self.collectionView
     reloadItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:0 inSection:section] ]];
  }];
}

#pragma mark - MineOrderCollaspeDelegate
- (void)collaspView:(UIView *)clickView {
}
@end
