//
//  MineFoodOrderController.m
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodOrderController.h"
#import "FoodList.h"
#import "LinkageListModel.h"
#import "LinkageMenuView.h"
#import "MarkUtils.h"
#import "MineFoodCell.h"
#import "MineFoodToolBar.h"
#import "NSDictionary+LoadJson.h"
#import <SDCycleScrollView.h>
#define MINEFOODCELL @"minefoodcell"

@interface MineFoodOrderController () <GenerateEntityDelegate, LinkageMenuProtocol,
UIScrollViewDelegate> {
  CGPoint _contentOffset;
}
@property (nonatomic, strong) LinkageMenuView *linkageMenu;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MineFoodToolBar *mineFoodToolBar;
@property (nonatomic, strong) NSMutableDictionary *foodDict;
@property (nonatomic, strong) NSMutableArray<LinkageModel *> *foodTypeList;
@property (nonatomic, strong) NSMutableArray<Food *> *foodList;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSString *address;
@end

@implementation MineFoodOrderController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  NSDictionary *dict = [NSDictionary readLocalFileWithName:@"MineFoodModelListJSON"];
  FoodList *foodList = [[FoodList alloc] initWithDictionary:dict];
  self.foodList = [foodList.food mutableCopy];
  self.foodDict = [NSMutableDictionary new];
  self.foodTypeList = [NSMutableArray new];
  for (Food *food in foodList.food) {
    if (!self.foodDict[food.typeName]) {
      self.foodDict[food.typeName] = [NSMutableArray new];
      LinkageModel *linkageModel = [LinkageModel new];
      linkageModel.title = food.typeName;
      [self.foodTypeList addObject:linkageModel];
    }
    NSMutableArray *tmp = self.foodDict[food.typeName];
    [tmp addObject:food];
  }
#endif
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  self.view.backgroundColor = UIColor.qd_customBackgroundColor;
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
  self.title = @"订餐";
}

#pragma mark - Lazy Init
- (LinkageMenuView *)linkageMenu {
  if (!_linkageMenu) {
    _linkageMenu = [[LinkageMenuView alloc] initWithDataSource:self.foodTypeList];
    _linkageMenu.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_linkageMenu.collectionView registerClass:MineFoodCell.class
                    forCellWithReuseIdentifier:MINEFOODCELL];
    _linkageMenu.link_delegate = self;
    _linkageMenu.tableView.scrollEnabled = false;
    _linkageMenu.collectionView.scrollEnabled = false;
  }
  return _linkageMenu;
}

- (UIView *)headerView {
  if (!_headerView) {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 10)];
    //    _headerView.frame = CGRectMake(0, NavigationContentTop, DEVICE_WIDTH, DEVICE_HEIGHT / 10);
    _headerView.backgroundColor = UIColor.qmui_randomColor;
  }
  return _headerView;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.clearColor;
    addView(_container, self.linkageMenu);
    addView(_container, self.bannerView);
    
    [self.linkageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.bannerView.mas_bottom);
      make.left.equalTo(_container);
      make.width.mas_equalTo(DEVICE_WIDTH);
      make.height.mas_equalTo(DEVICE_HEIGHT - NavigationContentTop);
    }];
  }
  return _container;
}

- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = UIColor.clearColor;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.bounces = false;
    _scrollView.delegate = self;
    addView(_scrollView, self.container);
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(_scrollView);
      make.width.equalTo(_scrollView);
    }];
    
    [self.container
     mas_makeConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(self.linkageMenu); }];
  }
  return _scrollView;
}

- (MineFoodToolBar *)mineFoodToolBar {
  if (!_mineFoodToolBar) {
    _mineFoodToolBar = [MineFoodToolBar new];
    _mineFoodToolBar.modelList = self.foodList;
    __weak __typeof(self) weakSelf = self;
    _mineFoodToolBar.foodNumChangeBlock = ^{
      [weakSelf.linkageMenu.collectionView reloadData];
      weakSelf.mineFoodToolBar.modelList = weakSelf.foodList;
      [weakSelf.linkageMenu.collectionView setContentOffset:_contentOffset];
    };
  }
  return _mineFoodToolBar;
}

- (SDCycleScrollView *)bannerView {
  if (!_bannerView) {
    _bannerView = [SDCycleScrollView
                   cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 5)
                   imageNamesGroup:@[ @"pink_gradient", @"launch_background" ]];
    _bannerView.showPageControl = YES;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
  }
  return _bannerView;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  //  addView(self.view, self.linkageMenu);
  //
  //  [self.linkageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.left.right.equalTo(self.view);
  //    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
  //    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  //  }];
  
  addView(self.view, self.scrollView);
  addView(self.view, self.mineFoodToolBar);
  
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view);
  }];
  
  [self.mineFoodToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
  }];
  [self.mineFoodToolBar setNeedsLayout];
  [self.mineFoodToolBar layoutIfNeeded];
}

#pragma mark - LinkageMenuProtocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberInSection:(NSInteger)section {
  if (section >= self.foodTypeList.count) { return 1; }
  NSArray *arr = self.foodDict[self.foodTypeList[section].title];
  return arr.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
   sizeForFooterInSection:(NSInteger)section {
  return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
    sizeForIndexPathCell:(NSIndexPath *)indexPath {
  if (indexPath.section > self.foodTypeList.count - 1) { //大于最大title数
    return CGSizeMake(-1, DEVICE_HEIGHT / 8);
  }
  return CGSizeMake(-1, DEVICE_HEIGHT / 8);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                    drawCellForIndexPath:(NSIndexPath *)indexPath {
  MineFoodCell *mfCell =
  [collectionView dequeueReusableCellWithReuseIdentifier:MINEFOODCELL forIndexPath:indexPath];
  
  NSArray *arr = self.foodDict[self.foodTypeList[indexPath.section].title];
  Food *food = arr[indexPath.row];
  mfCell.model = food;
  [mfCell setNeedsLayout];
  [mfCell layoutIfNeeded];
  __weak __typeof(self) weakSelf = self;
  mfCell.clickBlock = ^(Food *food) { weakSelf.mineFoodToolBar.modelList = weakSelf.foodList; };
  
  return mfCell;
}

- (void)collectionView:(UICollectionView *)collectionView
didScrollWithContentOffset:(CGPoint)contentOffset {
  if (contentOffset.y < 0) {
    [self.linkageMenu.collectionView setContentOffset:CGPointMake(0, 0)];
    self.linkageMenu.collectionView.scrollEnabled = false;
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
  } else {
    _contentOffset = contentOffset;
  }
}

- (NSInteger)numberOfSection:(UICollectionView *)collectionView {
  return self.foodTypeList.count + 1;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView != self.scrollView) {}
  if (scrollView == self.scrollView) {
    CGPoint point = scrollView.contentOffset;
    if (point.y > DEVICE_HEIGHT / 5) {
      self.linkageMenu.collectionView.scrollEnabled = YES;
      [self.scrollView setContentOffset:CGPointMake(0, DEVICE_HEIGHT / 5) animated:NO];
      //      [self.linkageMenu.collectionView
      //       setContentOffset:CGPointMake(0, point.y - DEVICE_HEIGHT / 10)];
      self.scrollView.scrollEnabled = false;
    } else {
      if (scrollView == self.linkageMenu.collectionView)
        if (point.y < 0) {
          //          [self.linkageMenu.collectionView setContentOffset:CGPointMake(0, 0)];
          //          self.linkageMenu.collectionView.userInteractionEnabled = false;
          //          self.scrollView.userInteractionEnabled = YES;
        }
    }
  }
}

- (void)setOrderCheckInfo:(OrderCheckInfo *)orderCheckInfo {
  _orderCheckInfo = orderCheckInfo;
  [self.linkageMenu.tableView reloadData];
  [self.linkageMenu.collectionView reloadData];
  self.mineFoodToolBar.model = orderCheckInfo;
  self.mineFoodToolBar.addressEnable = (self.foodOrderType == RoomOrderType);
}
@end
