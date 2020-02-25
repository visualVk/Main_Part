//
//  DetailController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailController.h"
#import "BannerZoomView.h"
#import "DetailHeaderPartCell.h"
#import "DetailInfoPartCell.h"
#import "FacilityCell.h"
#import "ItemBasicInfoCell.h"
#import "MapController.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "Pop2Controller.h"
#import "PopController.h"
#import "RemarkCell.h"
#import "RemarkScoreCell.h"
#import "RoomCell.h"
#import "SectionFoldView.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <JQCollectionViewAlignLayout.h>
#define ITEMBASICINFOCELL @"itembasicinfocell"
#define ITEMHEADER @"itemheader"
#define REMARKCELL @"remarkcell"
#define ROOMTCELL @"roomcell"
#define DETAILINFOPARTCELL @"detailinfopartcell"
#define REMARKSCORECELL @"remarkscorecell"
#define DETAILHEADERCELL @"detailheadercell"
#define SEGHEIGHT DEVICE_HEIGHT / 20
#define ITEMCELLHEIGHT DEVICE_HEIGHT / 8 + 10
#define BannerHeight DEVICE_HEIGHT / 3
#define REMARKSCOREHEIGHT DEVICE_HEIGHT / 6
#define COLLECTIONHEIGHT DEVICE_HEIGHT * 5 / 6

@interface DetailController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, SDCycleScrollViewDelegate,
BannerZoomDelegate, UICollectionViewDelegate,
UICollectionViewDataSource, JQCollectionViewAlignLayoutDelegate> {
  BOOL _didScolled;
}
@property (nonatomic, strong) HMSegmentedControl *segControl;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) NSArray *roomList;
@property (nonatomic, strong) NSMutableDictionary *openDic;
@property (nonatomic, strong) BannerZoomView *banner;
@property (nonatomic, strong) NSMutableArray *cellHs;
@property (nonatomic, strong) UIBarButtonItem *favor;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) QMUIModalPresentationViewController *detailInfoCon;
@end

@implementation DetailController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.imageList = @[
    @"pink_gradient", @"navigationbar_background", @"pink_gradient", @"navigationbar_background",
    @"pink_gradient", @"navigationbar_background"
  ];
  self.roomList = @[ @"豪华标间", @"行政标间", @"钟点房" ];
  self.openDic = [NSMutableDictionary dictionaryWithDictionary:@{
    @"豪华标间" : [NSNumber numberWithBool:false],
    @"行政标间" : [NSNumber numberWithBool:false],
    @"钟点房" : [NSNumber numberWithBool:false]
  }];
  self.cellHs = [NSMutableArray array];
  for (int i = 0; i < 2; i++) {
    [self.cellHs addObject:[NSNumber numberWithDouble:[FacilityCell cellCloseH]]];
  }
  self.favor = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"favor_background")
                                            target:self
                                            action:[self selectorBlock:^(id _Nonnull args) {
    QMUILogInfo(@"favor", @"favor bar button clicked!");
  }]];
  self.navigationItem.rightBarButtonItem = self.favor;
  self.favor.qmui_badgeBackgroundColor = UIColor.qd_mainTextColor;
  //  self.favor.qmui_view.backgroundColor = UIColor.qd_mainTextColor;
  //  self.favor.qmui_view.layer.backgroundColor = UIColor.qd_mainTextColor.CGColor;
  //  self.favor.qmui_view.layer.cornerRadius = 5;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  [self.navigationController.navigationBar setAlpha:0];
  [self.segControl setAlpha:0];
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

#pragma mark - QMUITableViewDelegate,QMUITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1 + self.roomList.count + 1 + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) { return 2; }
  if (section > 0 && section <= self.roomList.count) { return 4; }
  if (section == self.roomList.count + 1) { return 2; }
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section > 0 && section < self.roomList.count + 1) {
    NSString *key = self.roomList[section - 1];
    BOOL flg = [self.openDic[key] boolValue];
    if (flg) {
      return ITEMCELLHEIGHT;
    } else {
      return 0;
    }
  }
  if (section == self.roomList.count + 1) { return [self.cellHs[indexPath.row] doubleValue]; }
  if (section == self.roomList.count + 2) { return REMARKSCOREHEIGHT; }
  return -1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 0) { return nil; }
  if (section > 0 && section < self.roomList.count + 1) {
    SectionFoldView *fold = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ITEMHEADER];
    if (!fold) {
      fold = [[SectionFoldView alloc] init];
      fold.parentTableView = tableView;
      fold.type = QMUITableViewHeaderFooterViewTypeHeader;
      fold.qmui_borderColor = UIColor.qd_separatorColor;
      fold.qmui_borderPosition = QMUIViewBorderPositionTop;
      __weak __typeof(self) weakSelf = self;
      fold.didSelectBlock = ^(BOOL isOpen) {
        NSInteger rows = 4;
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:rows];
        for (int i = 0; i < 4; ++i) {
          [arr addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        NSString *key = self.roomList[section - 1];
        BOOL flg = [weakSelf.openDic[key] boolValue];
        if (!flg) {
          weakSelf.openDic[key] = [NSNumber numberWithBool:YES];
          //          [weakSelf.tableView performBatchUpdates:^{
          //            [weakSelf.tableView reloadRowsAtIndexPaths:arr
          //                                      withRowAnimation:UITableViewRowAnimationNone];
          //          }
          //                                       completion:nil];
          [UIView performWithoutAnimation:^{
            [weakSelf.tableView reloadRowsAtIndexPaths:arr
                                      withRowAnimation:UITableViewRowAnimationNone];
          }];
        } else {
          weakSelf.openDic[key] = [NSNumber numberWithBool:false];
          [weakSelf.tableView performBatchUpdates:^{
            [weakSelf.tableView reloadRowsAtIndexPaths:arr
                                      withRowAnimation:UITableViewRowAnimationNone];
          }
                                       completion:nil];
        }
        return flg;
      };
    }
    return fold;
  }
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 0) {
    if (row == 0) {
      ItemBasicInfoCell *ibiCell =
      [tableView dequeueReusableCellWithIdentifier:ITEMBASICINFOCELL forIndexPath:indexPath];
      __weak __typeof(self) weakSelf = self;
      ibiCell.go2MapCon = ^{
        MapController *map = [MapController new];
        [weakSelf.navigationController pushViewController:map animated:YES];
      };
      return ibiCell;
    }
    if (row == 1) {
      QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellsectionheader"];
      if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                                 withStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"cellsectionheader"];
      }
      cell.textLabel.text = @"酒店预订";
      cell.textLabel.textColor = UIColor.qd_mainTextColor;
      cell.textLabel.font = UIFontBoldMake(18);
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      return cell;
    }
  }
  if (section > 0 && section < self.roomList.count + 1) {
    RoomCell *rcell =
    [tableView dequeueReusableCellWithIdentifier:ROOMTCELL forIndexPath:indexPath];
    return rcell;
  }
  if (section == self.roomList.count + 1) {
    FacilityCell *cell = [FacilityCell testCellWithTableView:tableView];
    if (row == 1) { [cell loadData]; }
    return cell;
  }
  if (section == self.roomList.count + 2) {
    if (row == 0) {
      RemarkScoreCell *rsCell =
      [tableView dequeueReusableCellWithIdentifier:REMARKSCORECELL forIndexPath:indexPath];
      return rsCell;
    }
    RemarkCell *rcell =
    [tableView dequeueReusableCellWithIdentifier:REMARKCELL forIndexPath:indexPath];
    return rcell;
  }
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
  //  return nil;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 1) { self.segControl.selectedSegmentIndex = 0; }
  if (section == 4) { self.segControl.selectedSegmentIndex = 1; }
  if (section == 5) { self.segControl.selectedSegmentIndex = 2; }
  if (section == self.roomList.count + 1) {
    FacilityCell *cellT = (FacilityCell *)cell;
    cellT.animateTimeAry = @[ @0.5, @0.3 ];
    if (row == 0)
      cellT.type = SINGLEINLINE;
    else
      cellT.type = MULTINLINE;
    cellT.number = indexPath.row;
    [cellT setBGColor];
    if ([_cellHs[indexPath.row] floatValue] == [FacilityCell cellOpenH]) {
      [cellT startFoldAnimated:NO foldType:FoldTypeOpen];
    } else {
      [cellT startFoldAnimated:NO foldType:FoldTypeClose];
    }
  }
}

- (void)tableView:(UITableView *)tableView
didEndDisplayingCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == self.roomList.count + 1) {
    FacilityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isAnimating]) { return; }
    NSTimeInterval reloadTime;
    if ([self.cellHs[indexPath.row] doubleValue] == [FacilityCell cellCloseH]) {
      self.cellHs[indexPath.row] = [NSNumber numberWithDouble:[FacilityCell cellOpenH]];
      [cell startFoldAnimated:YES foldType:FoldTypeOpen];
      reloadTime = 0.6;
    } else {
      self.cellHs[indexPath.row] = [NSNumber numberWithDouble:[FacilityCell cellCloseH]];
      [cell startFoldAnimated:YES foldType:FoldTypeClose];
      reloadTime = 1.4;
    }
    [UIView animateWithDuration:reloadTime
                     animations:^{
      [tableView beginUpdates];
      [tableView endUpdates];
    }];
  }
  if (section > 0 && section < self.roomList.count) {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QMUIModalPresentationViewController *modalViewController =
    [[QMUIModalPresentationViewController alloc] init];
    modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    modalViewController.contentView = self.collectionview;
    modalViewController.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    __weak __typeof(self) weakSelf = self;
    modalViewController.layoutBlock =
    ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
      weakSelf.collectionview.qmui_frameApplyTransform = CGRectSetXY(
                                                                     weakSelf.collectionview.frame,
                                                                     CGFloatGetCenter(CGRectGetWidth(containerBounds),
                                                                                      CGRectGetWidth(weakSelf.collectionview.frame)),
                                                                     CGRectGetHeight(containerBounds) - CGRectGetHeight(weakSelf.collectionview.frame));
    };
    [modalViewController showWithAnimated:YES completion:^(BOOL finished){}];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) return 0;
  if (section > 0 && section < self.roomList.count + 1) return ITEMCELLHEIGHT + 10;
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 0;
  }
  return 0;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  self.tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.contentMode = UIViewContentModeScaleAspectFill;
  self.tableView.clipsToBounds = YES;
  self.tableView.estimatedRowHeight = ITEMCELLHEIGHT;
  self.tableView.estimatedSectionHeaderHeight = ITEMCELLHEIGHT;
  self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  [self.tableView registerClass:ItemBasicInfoCell.class forCellReuseIdentifier:ITEMBASICINFOCELL];
  [self.tableView registerClass:RemarkCell.class forCellReuseIdentifier:REMARKCELL];
  [self.tableView registerClass:RemarkScoreCell.class forCellReuseIdentifier:REMARKSCORECELL];
  [self.tableView registerClass:RoomCell.class forCellReuseIdentifier:ROOMTCELL];
  self.tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
  self.banner = [[BannerZoomView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, BannerHeight)];
  self.banner.datas = self.imageList;
  self.banner.self_delegate = self;
  self.banner.clipsToBounds = YES;
  [self.banner loadData];
  self.tableView.tableHeaderView = self.banner;
  
  addView(self.view, self.tableView);
  addView(self.view, self.segControl);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
  
  [self.segControl mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.height.equalTo(@(SEGHEIGHT));
  }];
}

#pragma mark - BannerZoomViewDelegate
- (void)presentZoomView:(UIViewController *)subViewController {
  [self presentViewController:subViewController animated:YES completion:nil];
}

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView
                             location:(CGPoint)location {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView != self.tableView) return;
  CGPoint point = scrollView.contentOffset;
  [self.navigationController.navigationBar.qmui_backgroundView
   setAlpha:point.y / NavigationContentTop];
  //  [UIView performWithoutAnimation:^{
  [self.segControl setAlpha:point.y / NavigationContentTop];
  if (point.y > NavigationContentTop) {
    if (!_didScolled) {
      scrollView.contentInset =
      UIEdgeInsetsMake(NavigationContentTop + CGRectGetHeight(self.segControl.frame), 0, 0, 0);
      _didScolled = true;
      __weak __typeof(self) weakSelf = self;
      [UIView transitionWithView:self.favor.qmui_view
                        duration:0.5
                         options:UIViewAnimationOptionTransitionCrossDissolve
                      animations:^{ [weakSelf.favor setImage:UIImageMake(@"favor")]; }
                      completion:nil];
    }
  } else {
    if (_didScolled) {
      scrollView.contentInset = UIEdgeInsetsZero;
      _didScolled = false;
      __weak __typeof(self) weakSelf = self;
      [UIView transitionWithView:self.favor.qmui_view
                        duration:0.5
                         options:UIViewAnimationOptionTransitionCrossDissolve
                      animations:^{ [weakSelf.favor setImage:UIImageMake(@"favor_background")]; }
                      completion:nil];
    }
  }
  //  }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:DETAILHEADERCELL
                                              forIndexPath:indexPath];
    
    return cell;
  }
  if (section == 1) {
    DetailInfoPartCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:DETAILINFOPARTCELL
                                              forIndexPath:indexPath];
    
    return cell;
  }
  return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  switch (section) {
    case 0:
      return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 2);
    case 1:
      return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 3);
  }
  return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"Detail controller", @"click(%li,%li)", indexPath.section, indexPath.row);
}

#pragma mark - Lazy init
- (HMSegmentedControl *)segControl {
  if (!_segControl) {
    _segControl = [HMSegmentedControl new];
    _segControl.sectionTitles = @[ @"酒店预定", @"订房必读", @"用户评价" ];
    _segControl.selectedSegmentIndex = 0;
    _segControl.backgroundColor = UIColor.qd_backgroundColor;
    _segControl.titleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_titleTextColor,
      NSFontAttributeName : UIFontMake(14)
    };
    _segControl.selectedTitleTextAttributes =
    @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]};
    _segControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    _segControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segControl.selectionIndicatorHeight = 3.0f;
    __weak __typeof(self) weakSelf = self;
    _segControl.indexChangeBlock = ^(NSInteger index) {
      NSInteger section = 0;
      if (index == 0) { section = 1; }
      if (index == 1) { section = 4; }
      if (index == 2) { section = 5; }
      [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]
                                atScrollPosition:UITableViewScrollPositionMiddle
                                        animated:YES];
    };
    _segControl.tag = 1;
  }
  return _segControl;
}

- (UICollectionView *)collectionview {
  if (!_collectionview) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, COLLECTIONHEIGHT)
                       collectionViewLayout:layout];
    _collectionview.backgroundColor = UIColor.qd_customBackgroundColor;
    _collectionview.scrollEnabled = YES;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [_collectionview registerClass:DetailHeaderPartCell.class
        forCellWithReuseIdentifier:DETAILHEADERCELL];
    [_collectionview registerClass:DetailInfoPartCell.class
        forCellWithReuseIdentifier:DETAILINFOPARTCELL];
  }
  return _collectionview;
}
@end
