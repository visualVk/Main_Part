//
//  MineFoodPayController.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodPayController.h"
#import "MarkUtils.h"
#import "MineFoodAddressCell.h"
#import "MineFoodDiscountCell.h"
#import "MineFoodItemCell.h"
#import "MineFoodListTitleCell.h"
#import "MineFoodPayToolBar.h"
#define MINEFOODDISCOUNTCELL @"minefooddiscountcell"
#define MINEFOODITEMCELL @"minefooditemcell"
#define MINEFOODLISTTITLECELL @"minefoodlisttitlecell"
#define MINEFOODADDRESSCELL @"minefoodaddresscell"
@interface MineFoodPayController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) MineFoodPayToolBar *payToolBar;
@end

@implementation MineFoodPayController

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
//  self.title = @"确认订单";
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    _tableView.backgroundColor = UIColor.clearColor;
    [_tableView registerClass:MineFoodAddressCell.class forCellReuseIdentifier:MINEFOODADDRESSCELL];
    [_tableView registerClass:MineFoodListTitleCell.class
       forCellReuseIdentifier:MINEFOODLISTTITLECELL];
    [_tableView registerClass:MineFoodItemCell.class forCellReuseIdentifier:MINEFOODITEMCELL];
    [_tableView registerClass:MineFoodDiscountCell.class
       forCellReuseIdentifier:MINEFOODDISCOUNTCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (MineFoodPayToolBar *)payToolBar {
  if (!_payToolBar) {
    _payToolBar = [MineFoodPayToolBar new];
    _payToolBar.payPrice.text = [NSString stringWithFormat:@"¥%g", self.foodTotPrice];
  }
  return _payToolBar;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  addView(self.view, self.payToolBar);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.payToolBar.mas_top);
  }];
  
  [self.payToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
  }];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 2) return self.foodList.count;
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 2) return 0;
  return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *view = [UIView new];
  view.backgroundColor = UIColor.clearColor;
  return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    MineFoodAddressCell *mfaCell =
    [tableView dequeueReusableCellWithIdentifier:MINEFOODADDRESSCELL forIndexPath:indexPath];
    //    mfaCell.addressLB.text =
    //    [NSString stringWithFormat:@"至 %@", @"浙"
    //     @"江省绍兴市柯桥区柯华路958号"];
    mfaCell.isAddressEnable = (self.foodPayType == OrderPayType);
    mfaCell.model = self.model;
    return mfaCell;
  }
  if (indexPath.section == 1) {
    MineFoodListTitleCell *mfltCell =
    [tableView dequeueReusableCellWithIdentifier:MINEFOODLISTTITLECELL forIndexPath:indexPath];
    return mfltCell;
  }
  if (indexPath.section == 2) {
    MineFoodItemCell *mfiCell =
    [tableView dequeueReusableCellWithIdentifier:MINEFOODITEMCELL forIndexPath:indexPath];
    mfiCell.model = self.foodList[indexPath.row];
    return mfiCell;
  }
  if (indexPath.section == 3) {
    MineFoodDiscountCell *mfdCell =
    [tableView dequeueReusableCellWithIdentifier:MINEFOODDISCOUNTCELL forIndexPath:indexPath];
    return mfdCell;
  }
  static NSString *identifier = @"cell";
  QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView withReuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
