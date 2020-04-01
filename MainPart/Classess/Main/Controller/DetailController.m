//
//  DetailController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailController.h"
#import "BannerZoomView.h"
#import "CheckInController.h"
#import "DetailHeaderPartCell.h"
#import "DetailInfoPartCell.h"
#import "DetailPresentNavBar.h"
#import "DetailPresentToolBarView.h"
#import "FacilityCell.h"
#import "HotelAppreaiseModel.h"
#import "HotelAppreaiseModelList.h"
#import "HotelOrderDatePickerView.h"
#import "HotelRoomModelList.h"
#import "ItemBasicInfoCell.h"
#import "MapController.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
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
#define COLLECTIONHEIGHT DEVICE_HEIGHT * 4 / 6

@interface DetailController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, SDCycleScrollViewDelegate,
BannerZoomDelegate, UICollectionViewDelegate,
UICollectionViewDataSource, JQCollectionViewAlignLayoutDelegate> {
  BOOL _didScolled;
}
@property (nonatomic, strong) HotelOrderDatePickerView *orderDatePickerView;
@property (nonatomic, strong) HMSegmentedControl *segControl;
@property (nonatomic, strong) UIView *presentView;
@property (nonatomic, strong) DetailPresentToolBarView *presentToolBar;
@property (nonatomic, strong) DetailPresentNavBar *presentNavBar;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) NSMutableDictionary *openDic;
@property (nonatomic, strong) BannerZoomView *banner;
@property (nonatomic, strong) NSMutableArray *cellHs;
@property (nonatomic, strong) UIBarButtonItem *favor;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) QMUIModalPresentationViewController *modalViewController;
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) NSArray<HotelRoomModel *> *hotelRoomList;
@property (nonatomic, strong) NSMutableDictionary *hotelRoomDict;
@property (nonatomic, strong) NSMutableArray *hotelRoomTypeList;
@property (nonatomic, strong) NSArray<HotelAppreaiseModel *> *hotelAppreaiseModelList;
@end

@implementation DetailController
@synthesize modalViewController = _modalViewController;
- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.imageList = @[
    @"pink_gradient", @"navigationbar_background", @"pink_gradient", @"navigationbar_background",
    @"pink_gradient", @"navigationbar_background"
  ];
  self.openDic = [NSMutableDictionary dictionaryWithCapacity:self.hotelRoomList.count];
  for (HotelRoomModel *hotelRoom in self.hotelRoomList) {
    self.openDic[hotelRoom.roomType] = [NSNumber numberWithBool:false];
  }
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
  [self showEmptyView];
  [self generateRootView];
  [self.segControl setAlpha:0];
  [self.orderDatePickerView setAlpha:0];
  [self findHotelById];
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
  self.title = @"酒店详情";
}

#pragma mark - QMUITableViewDelegate,QMUITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (self.hotelAppreaiseModelList != nil && self.hotelAppreaiseModelList.count) {
    return 1 + self.hotelRoomTypeList.count + 2;
  }
  return 1 + self.hotelRoomTypeList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) { return 2; }
  if (section > 0 && section <= self.hotelRoomTypeList.count) {
    NSString *key = self.hotelRoomTypeList[section - 1];
    NSArray *tmp = self.hotelRoomDict[key];
    return tmp.count;
  }
  if (section == self.hotelRoomTypeList.count + 1) { return 2; }
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section > 0 && section < self.hotelRoomTypeList.count + 1) {
    NSString *key = self.hotelRoomTypeList[section - 1];
    BOOL flg = [self.openDic[key] boolValue];
    if (flg) {
      return ITEMCELLHEIGHT;
    } else {
      return 0;
    }
  }
  if (section == self.hotelRoomTypeList.count + 1) {
    return [self.cellHs[indexPath.row] doubleValue];
  }
  if (section == self.hotelRoomTypeList.count + 2) { return REMARKSCOREHEIGHT; }
  return -1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 0) { return nil; }
  if (section > 0 && section < self.hotelRoomTypeList.count + 1) {
    //    SectionFoldView *fold = [tableView
    //    dequeueReusableHeaderFooterViewWithIdentifier:ITEMHEADER];
    SectionFoldView *fold = nil;
    if (!fold) {
      fold = [[SectionFoldView alloc] init];
      fold.parentTableView = tableView;
      NSArray *tmp = self.hotelRoomDict[self.hotelRoomTypeList[section - 1]];
      fold.model = tmp[0];
      fold.type = QMUITableViewHeaderFooterViewTypeHeader;
      fold.qmui_borderColor = UIColor.qd_separatorColor;
      fold.qmui_borderPosition = QMUIViewBorderPositionTop;
      __weak __typeof(self) weakSelf = self;
      fold.didSelectBlock = ^(BOOL isOpen) {
        NSInteger rows = tmp.count;
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:rows];
        for (int i = 0; i < rows; ++i) {
          [arr addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        NSString *key = self.hotelRoomTypeList[section - 1];
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
      ibiCell.model = self.hotelModel;
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
  if (section > 0 && section < self.hotelRoomTypeList.count + 1) {
    RoomCell *rcell =
    [tableView dequeueReusableCellWithIdentifier:ROOMTCELL forIndexPath:indexPath];
    NSString *key = self.hotelRoomTypeList[section - 1];
    HotelRoomModel *model = self.hotelRoomDict[key][indexPath.row];
    rcell.model = model;
    return rcell;
  }
  if (section == self.hotelRoomTypeList.count + 1) {
    FacilityCell *cell = nil;
    if (row == 1) {
      cell = [FacilityCell testCellWithTableView:tableView facilityType:SINGLEINLINE];
    } else {
      cell = [FacilityCell testCellWithTableView:tableView facilityType:MULTINLINE];
    }
    return cell;
  }
  if (section == self.hotelRoomTypeList.count + 2) {
    if (row == 0) {
      RemarkScoreCell *rsCell =
      [tableView dequeueReusableCellWithIdentifier:REMARKSCORECELL forIndexPath:indexPath];
      rsCell.model = self.hotelRoomList[0];
      return rsCell;
    }
    RemarkCell *rcell =
    [tableView dequeueReusableCellWithIdentifier:REMARKCELL forIndexPath:indexPath];
    rcell.model = self.hotelAppreaiseModelList[indexPath.row - 1];
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
  if (section == 2 + self.hotelRoomTypeList.count) { self.segControl.selectedSegmentIndex = 1; }
  if (section == 3 + self.hotelRoomTypeList.count) { self.segControl.selectedSegmentIndex = 2; }
  if (section == self.hotelRoomTypeList.count + 1) {
    FacilityCell *cellT = (FacilityCell *)cell;
    cellT.animateTimeAry = @[ @0.5, @0.3 ];
    if (row == 0)
      cellT.type = SINGLEINLINE;
    else
      cellT.type = MULTINLINE;
    cellT.number = indexPath.row;
    [cellT setBGColor];
    if ([FacilityCell cellOpenH] - [_cellHs[indexPath.row] floatValue] < 0.1) {
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
#pragma mark - QMUITableView DidSelectRowIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == self.hotelRoomTypeList.count + 1) {
    FacilityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (row == 0)
      cell.type = SINGLEINLINE;
    else
      cell.type = MULTINLINE;
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
  if (section > 0 && section <= self.hotelRoomTypeList.count) {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.modalViewController = [[QMUIModalPresentationViewController alloc] init];
    self.modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    //    modalViewController.contentView = self.collectionview;
    self.modalViewController.contentView = self.presentView;
    self.modalViewController.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    __weak __typeof(self) weakSelf = self;
    self.modalViewController.layoutBlock =
    ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
      weakSelf.presentView.qmui_frameApplyTransform = CGRectSetXY(
                                                                  weakSelf.presentView.frame,
                                                                  CGFloatGetCenter(CGRectGetWidth(containerBounds),
                                                                                   CGRectGetWidth(weakSelf.presentView.frame)),
                                                                  CGRectGetHeight(containerBounds) - CGRectGetHeight(weakSelf.presentView.bounds));
    };
    [self.modalViewController showWithAnimated:YES completion:^(BOOL finished){}];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) return 0;
  if (section > 0 && section < self.hotelRoomTypeList.count + 1) return ITEMCELLHEIGHT + 10;
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
  addView(self.view, self.tableView);
  addView(self.view, self.segControl);
  addView(self.view, self.orderDatePickerView);
  
  [self navBarAlp];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self.view);
    //    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
  
  [self.segControl mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.height.equalTo(@(SEGHEIGHT));
  }];
  
  [self.orderDatePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.segControl);
    make.top.equalTo(self.segControl.mas_bottom);
    make.height.mas_equalTo(@(SEGHEIGHT));
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
  if (scrollView != self.tableView) {
    if (scrollView == self.collectionview) {
      [self.presentNavBar didScrollView:scrollView.contentOffset];
    }
  };
  CGPoint point = scrollView.contentOffset;
  //  [self.navigationController.navigationBar.qmui_backgroundView
  //   setAlpha:point.y / NavigationContentTop];
  //  [UIView performWithoutAnimation:^{
  [self.segControl setAlpha:point.y / NavigationContentTop];
  [self.orderDatePickerView setAlpha:point.y / NavigationContentTop];
  if (point.y > NavigationContentTop) {
    if (!_didScolled) {
      scrollView.contentInset =
      UIEdgeInsetsMake(NavigationContentTop + CGRectGetHeight(self.segControl.frame) +
                       CGRectGetHeight(self.orderDatePickerView.frame),
                       0, 0, 0);
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
- (HotelOrderDatePickerView *)orderDatePickerView {
  if (!_orderDatePickerView) {
    _orderDatePickerView = [HotelOrderDatePickerView new];
    _orderDatePickerView.layer.shadowOffset = CGSizeMake(0, 2);
    _orderDatePickerView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    _orderDatePickerView.layer.shadowOpacity = 0.25;
    [_orderDatePickerView loadData:@{
      @"stDate" : [NSDate dateWithTimeIntervalSinceNow:0],
      @"edDate" : [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60 * 4],
      @"room" : @"1",
      @"people" : @"2"
    }];
  }
  return _orderDatePickerView;
}

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
      if (index == 1) { section = 2; }
      if (index == 2) { section = 2 + self.hotelRoomTypeList.count; }
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
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 0);
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

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColor.qd_customBackgroundColor;
    _tableView.contentMode = UIViewContentModeScaleAspectFill;
    _tableView.clipsToBounds = YES;
    _tableView.estimatedRowHeight = ITEMCELLHEIGHT;
    _tableView.estimatedSectionHeaderHeight = ITEMCELLHEIGHT;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [_tableView registerClass:ItemBasicInfoCell.class forCellReuseIdentifier:ITEMBASICINFOCELL];
    [_tableView registerClass:RemarkCell.class forCellReuseIdentifier:REMARKCELL];
    [_tableView registerClass:RemarkScoreCell.class forCellReuseIdentifier:REMARKSCORECELL];
    [_tableView registerClass:RoomCell.class forCellReuseIdentifier:ROOMTCELL];
    _tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
    _banner = [[BannerZoomView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, BannerHeight)];
    _banner.datas = self.imageList;
    _banner.self_delegate = self;
    _banner.clipsToBounds = YES;
    [self.banner loadData];
    _tableView.tableHeaderView = self.banner;
  }
  return _tableView;
}

- (UIView *)presentView {
  if (!_presentView) {
    _presentView = [UIView new];
    addView(_presentView, self.collectionview);
    if (!self.presentToolBar) {
      self.presentToolBar = [DetailPresentToolBarView new];
      __weak __typeof(self) weakSelf = self;
      self.presentToolBar.clickBlock = ^{
        [weakSelf.modalViewController hideWithAnimated:YES completion:nil];
        CheckInController *ciCon = [CheckInController new];
        ciCon.title = self.hotelModel.hotelName;
        [weakSelf.navigationController pushViewController:ciCon animated:YES];
      };
    }
    if (!self.presentNavBar) {
      self.presentNavBar = [[DetailPresentNavBar alloc]
                            initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, NavigationBarHeight)];
    }
    addView(_presentView, self.presentNavBar);
    addView(_presentView, self.presentToolBar);
    [self.presentToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.collectionview.mas_bottom);
      make.right.left.equalTo(self.collectionview);
      make.height.mas_equalTo(DEVICE_HEIGHT / 10);
    }];
    
    [_presentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.top.equalTo(self.collectionview);
      make.bottom.equalTo(self.presentToolBar);
    }];
  }
  return _presentView;
}

#pragma mark - navigation bar alpha
- (void)navBarAlp {
  self.navigationAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
  self.navigationAnimator.scrollView = self.tableView;
  self.navigationAnimator.offsetYToStartAnimation = 0;
  self.navigationAnimator.distanceToStopAnimation = 88;
  
  self.navigationAnimator.backgroundImageBlock =
  ^UIImage *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    return [NavBarBackgroundImage qmui_imageWithAlpha:progress];
  };
  self.navigationAnimator.shadowImageBlock =
  ^UIImage *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    return [NavBarShadowImage qmui_imageWithAlpha:progress];
  };
  /**
   当背景非蓝色时启用
   */
  self.navigationAnimator.tintColorBlock =
  ^UIColor *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    return [UIColor qmui_colorFromColor:UIColor.qd_backgroundColor
                                toColor:NavBarTintColor
                               progress:progress];
  };
  self.navigationAnimator.titleViewTintColorBlock = self.navigationAnimator.tintColorBlock;
  self.navigationAnimator.statusbarStyleBlock =
  ^UIStatusBarStyle(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    //    return progress < .25 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    return UIStatusBarStyleLightContent;
  };
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  if (self.navigationAnimator) {
    return self.navigationAnimator.statusbarStyleBlock(self.navigationAnimator,
                                                       self.navigationAnimator.progress);
  }
  return [super preferredStatusBarStyle];
}

#pragma mark - <QMUINavigationControllerAppearanceDelegate>

- (UIImage *)navigationBarBackgroundImage {
  return self.navigationAnimator.backgroundImageBlock(self.navigationAnimator,
                                                      self.navigationAnimator.progress);
}

- (UIImage *)navigationBarShadowImage {
  return self.navigationAnimator.shadowImageBlock(self.navigationAnimator,
                                                  self.navigationAnimator.progress);
}

//- (UIColor *)navigationBarTintColor {
//  return self.navigationAnimator.tintColorBlock(self.navigationAnimator,
//                                                self.navigationAnimator.progress);
//}
//
//- (UIColor *)titleViewTintColor {
//  return [self navigationBarTintColor];
//}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
//转场效果
- (NSString *)customNavigationBarTransitionKey {
  return self.navigationAnimator.progress >= 1 ? nil : @"progress";
}

- (void)findHotelById {
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager]
   RequestGetWithUrl:[NSString stringWithFormat:@"%@/%li", FindAppreaiseByHotelId,
                      self.hotelModel.idField]
   Object:nil
   Success:^(NSDictionary *_Nullable dict) {
    weakSelf.hotelAppreaiseModelList =
    [HotelAppreaiseModelList mj_objectWithKeyValues:dict].data;
    [weakSelf.tableView reloadData];
  }
   Failure:^(NSError *_Nullable err){}];
  
  [[RequestUtils shareManager]
   RequestGetWithUrl:[NSString
                      stringWithFormat:@"%@/%li", FindRoomByHotelId, self.hotelModel.idField]
   Parameter:nil
   Success:^(NSDictionary *_Nullable dict) {
    //    QMUILogInfo(@"request utils", @"dict={%@}", [dict description]);
    weakSelf.hotelRoomList = [HotelRoomModelList mj_objectWithKeyValues:dict].data;
    
  }
   Failure:^(NSError *_Nullable err){}];
}

- (void)setHotelRoomList:(NSArray<HotelRoomModel *> *)hotelRoomList {
  _hotelRoomList = hotelRoomList;
  self.openDic = [NSMutableDictionary dictionaryWithCapacity:hotelRoomList.count];
  for (HotelRoomModel *hotelRoom in hotelRoomList) {
    self.openDic[hotelRoom.roomType] = [NSNumber numberWithBool:false];
  }
  self.hotelRoomDict = [NSMutableDictionary new];
  self.hotelRoomTypeList = [NSMutableArray new];
  for (HotelRoomModel *hotelRoom in hotelRoomList) {
    NSMutableArray *list = self.hotelRoomDict[hotelRoom.roomType];
    if (list == nil || list.count == 0) {
      list = [NSMutableArray new];
      self.hotelRoomDict[hotelRoom.roomType] = list;
      [self.hotelRoomTypeList addObject:hotelRoom.roomType];
    }
    [list addObject:hotelRoom];
  }
  
  [self.tableView reloadData];
  [self hideEmptyView];
}
@end
