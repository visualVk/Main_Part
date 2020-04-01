//
//  OrderDetailController.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderDetailController.h"
#import "DetailController.h"
#import "MarkUtils.h"
#import "MineOrderCheckPersonInfoView.h"
#import "MineOrderDetailDeleteToolBar.h"
#import "MineOrderHotelView.h"
#import "MineOrderInfoCell.h"
#import "MineOrderQuestionToolBar.h"
#import "MineOrderRoomInfoView.h"
#import "MineOrderServiceCell.h"
#import "QDAlertHelper.h"
#import <JQCollectionViewAlignLayout.h>
#define MINEORDERROOMINFOCELL @"mineorderroominfoview"
#define MINEORDERCHECKPERSONINFOVIEW @"mineordercheckpersoninfoview"
#define MINEORDERHOTELVIEW @"mineorderhotelview"
#define MINEORDERINFOCELL @"mineorderinfocell"
#define MINEORDERSERVICECELL @"mineorderservicecell"

@interface OrderDetailController () <
GenerateEntityDelegate, UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, MineOrderCollaspeDelegate> {
  BOOL _isEdit;
}
@property (nonatomic, strong) MineOrderQuestionToolBar *queToolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collaspeList;
@property (nonatomic, strong) NSMutableArray<CheckInfo *> *checkList;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *deleteList;
@property (nonatomic, strong) MineOrderDetailDeleteToolBar *deleteToolBar;
@end

@implementation OrderDetailController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.collaspeList = [NSMutableArray new];
  //  self.datas = @[ @"", @"", @"" ];
  self.deleteList = [NSMutableArray new];
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
  self.checkList = self.orderCheckInfo.checkInfo;
  for (CheckInfo *checkInfo in self.checkList) {
    [self.collaspeList addObject:@"0"];
    [self.deleteList addObject:[NSNumber numberWithBool:false]];
  }
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
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(orderEditClick:)];
}

- (void)orderEditClick:(UIBarButtonItem *)item {
  if (!_isEdit) {
    _isEdit = true;
    [item setTitle:@"完成"];
    [self showDeleteToolBar];
  } else {
    _isEdit = false;
    [item setTitle:@"编辑"];
    [self hideDeleteToolBar];
  }
  [UIView performWithoutAnimation:^{ [self.collectionView reloadData]; }];
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
    [_collectionView registerClass:MineOrderServiceCell.class
        forCellWithReuseIdentifier:MINEORDERSERVICECELL];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (MineOrderQuestionToolBar *)queToolBar {
  if (!_queToolBar) { _queToolBar = [MineOrderQuestionToolBar new]; }
  return _queToolBar;
}

- (MineOrderDetailDeleteToolBar *)deleteToolBar {
  if (!_deleteToolBar) {
    _deleteToolBar = [MineOrderDetailDeleteToolBar new];
    __weak __typeof(self) weakSelf = self;
    _deleteToolBar.allSelectBlock = ^(BOOL on) {
      for (int i = 0; i < self.checkList.count; i++) {
        if (on) {
          weakSelf.deleteList[i] = [NSNumber numberWithBool:true];
        } else {
          weakSelf.deleteList[i] = [NSNumber numberWithBool:false];
        }
      }
      [UIView performWithoutAnimation:^{ [weakSelf.collectionView reloadData]; }];
    };
    _deleteToolBar.deleteBlock = ^{
      [QDAlertHelper showChooseAlertWithTitle:@""
                                      message:@"确定将选中房间退房吗？"
                               preferredStyle:QMUIAlertControllerStyleAlert
                                   chooseList:@[ @"是", @"否" ]
                                  chooseBlock:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
          NSMutableIndexSet *indexSet =
          [[NSMutableIndexSet alloc] init];
          for (int i = 0; i < weakSelf.checkList.count; i++) {
            if ([weakSelf.deleteList[i] boolValue])
              [indexSet addIndex:i];
          }
          [weakSelf.checkList removeObjectsAtIndexes:indexSet];
        }
      }];
    };
  }
  return _deleteToolBar;
}

- (void)showDeleteToolBar {
  addView(self.view, self.deleteToolBar);
  [self.deleteToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.height.mas_equalTo(DEVICE_HEIGHT / 15);
    make.bottom.equalTo(self.queToolBar.mas_top);
  }];
}

- (void)hideDeleteToolBar {
  [self.deleteToolBar removeFromSuperview];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 3 + self.checkList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0 || section == 1) return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 10);
  if (self.checkList && self.checkList.count && section > 1 && section < self.checkList.count + 2) {
    if ([@"0" isEqualToString:self.collaspeList[section - 2]]) {
      return CGSizeMake(DEVICE_WIDTH, 0);
    }
    return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 4);
  }
  if (section == 2 + self.checkList.count) return CGSizeMake(DEVICE_WIDTH, 1.25 * SPACE + 85);
  return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0 || section == 2 + self.checkList.count || section == 1) {
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
    header.isEdit = _isEdit;
    header.collapseImage.tag = indexPath.section;
    [header checkSet:[self.deleteList[indexPath.section - 2] boolValue]];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(collapseSectionHeader:)];
    [header.collapseImage addGestureRecognizer:tap];
    
    header.tag = indexPath.section;
    UITapGestureRecognizer *editTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editClick:)];
    [header addGestureRecognizer:editTap];
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
  if (section == 0 || section == 2 + self.checkList.count || section == 1)
    return CGSizeMake(DEVICE_WIDTH, 0);
  return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) { //酒店名
    MineOrderHotelView *morhCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERHOTELVIEW
                                              forIndexPath:indexPath];
    morhCell.hotelName.text = self.orderCheckInfo.hotelName;
    morhCell.hotelAddress.text = self.orderCheckInfo.hotelAddress;
    return morhCell;
  }
  if (section == 1) { //订餐 健身
    MineOrderServiceCell *mosCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERSERVICECELL
                                              forIndexPath:indexPath];
    mosCell.model = self.orderCheckInfo;
    mosCell.parentController = self;
    return mosCell;
  }
  if (section == self.checkList.count + 2) { //支付后的订单cell
    MineOrderInfoCell *moiCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERINFOCELL
                                              forIndexPath:indexPath];
    moiCell.model = self.orderCheckInfo;
    return moiCell;
  }
  //登记人信息和其房间信息
  MineOrderRoomInfoView *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:MINEORDERROOMINFOCELL
                                            forIndexPath:indexPath];
  cell.modelIndex = indexPath.section - 2;
  cell.model = self.orderCheckInfo;
  [cell resetStatus];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    DetailController *dCon = [DetailController new];
    [self.navigationController pushViewController:dCon animated:YES];
  }
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
  if ([@"0" isEqualToString:self.collaspeList[section - 2]]) {
    self.collaspeList[section - 2] = @"1";
  } else {
    self.collaspeList[section - 2] = @"0";
  }
  [UIView performWithoutAnimation:^{
    [self.collectionView
     reloadItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:0 inSection:section] ]];
  }];
}

#pragma mark - MineOrderCollaspeDelegate
- (void)collaspView:(UIView *)clickView {
}

- (void)editClick:(UITapGestureRecognizer *)tap {
  if (_isEdit) {
    MineOrderCheckPersonInfoView *header = (MineOrderCheckPersonInfoView *)(tap.qmui_targetView);
    self.deleteList[tap.qmui_targetView.tag - 2] =
    [NSNumber numberWithBool:![header getCheckSelected]];
    [header checkSet:![header getCheckSelected]];
  }
}
@end
