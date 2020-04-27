//
//  MainTicketController.m
//  MainPart
//
//  Created by blacksky on 2020/4/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainTicketController.h"
#import "MarkUtils.h"
#import "MineDiscountCell.h"
#define MINEDISCOUNTCELL @"MineDiscountCell"
#define DISCOUNTHEIGHT (DEVICE_HEIGHT / 8 + SPACE)

@interface MainTicketController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) NSArray *ticketList;
@end

@implementation MainTicketController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  [self generateList];
#endif
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
  self.title = @"优惠券";
}

- (void)generateRootView {
  self.tableview = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.tableview registerClass:MineDiscountCell.class forCellReuseIdentifier:MINEDISCOUNTCELL];
  self.tableview.delegate = self;
  self.tableview.dataSource = self;
  
  addView(self.view, self.tableview);
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.bottom.equalTo(self.view);
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.ticketList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DISCOUNTHEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:MINEDISCOUNTCELL];
  [cell reloadData:self.ticketList[indexPath.row]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)generateList {
  self.ticketList = @[
    @{
      @"title" : @"玛莎",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"5.0"
    },
    @{
      @"title" : @"tian",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"9.0"
    },
    @{
      @"title" : @"pizza",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"6.6"
    },
    @{
      @"title" : @"雷克萨",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"5.5"
    },
    @{
      @"title" : @"豪客来",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"9.0"
    },
    @{
      @"title" : @"必胜客",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"8.0"
    },
    @{
      @"title" : @"鱼丸",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"6.7"
    },
    @{
      @"title" : @"三亚舟山",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"6.5"
    },
    @{
      @"title" : @"盛典",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"5.0"
    },
    @{
      @"title" : @"开怀乐",
      @"content" : @"实体店使用优惠券",
      @"st" : @"2019-02-23",
      @"ed" : @"2020-09-12",
      @"discount" : @"7.0"
    }
  ];
}
@end
