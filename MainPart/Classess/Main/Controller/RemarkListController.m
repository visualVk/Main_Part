//
//  RemarkListController.m
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkListController.h"
#import "HotelAppreaiseModelList.h"
#import "MarkUtils.h"
#import "RemarkListCell.h"
#import "RemarkStaticCell.h"
#import <MJRefresh.h>
#import <SJAttributesFactory.h>
#define REMARKSTATICCELL @"remarkstaticcell"
#define REMARKLISTCELL @"remarklistcell"

@interface RemarkListController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HotelAppreaiseModel *> *appreaiseModelList;
@end

@implementation RemarkListController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  self.emptyView.backgroundColor = UIColor.qd_backgroundColor;
  [self showEmptyView];
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
  self.title = @"所有评论";
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    __weak __typeof(self) weakSelf = self;
    _tableView = [QMUITableView new];
    _tableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{ weakSelf.hotelId = weakSelf.hotelId; }];
    _tableView.estimatedRowHeight = 300;
    [_tableView registerClass:RemarkListCell.class forCellReuseIdentifier:REMARKLISTCELL];
    [_tableView registerClass:RemarkStaticCell.class forCellReuseIdentifier:REMARKSTATICCELL];
    _tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
  }];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) return 1;
  return self.appreaiseModelList.count;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) return 100;
  return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    RemarkListCell *rlCell =
    [tableView dequeueReusableCellWithIdentifier:REMARKLISTCELL forIndexPath:indexPath];
    rlCell.model = self.appreaiseModelList[indexPath.row];
    return rlCell;
  }
  RemarkStaticCell *rsCell =
  [tableView dequeueReusableCellWithIdentifier:REMARKSTATICCELL forIndexPath:indexPath];
  rsCell.model = self.model;
  return rsCell;
  //  static NSString *identifier = @"cell";
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  //  if (!cell) {
  //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
  //                                  reuseIdentifier:identifier];
  //  }
  //  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)setHotelId:(NSInteger)hotelId {
  _hotelId = hotelId;
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager]
   RequestGetWithUrl:[NSString stringWithFormat:@"%@/%li", FindAppreaiseByHotelId, hotelId]
   Object:nil
   Success:^(NSDictionary *_Nullable dict) {
    weakSelf.appreaiseModelList =
    [[HotelAppreaiseModelList mj_objectWithKeyValues:dict].data mutableCopy];
    [weakSelf.tableView reloadData];
    [weakSelf hideEmptyView];
    [weakSelf.tableView.mj_header endRefreshing];
  }
   Failure:^(NSError *_Nullable err) { QMUILogInfo(@"remark list controller", @"failure"); }];
}
@end
