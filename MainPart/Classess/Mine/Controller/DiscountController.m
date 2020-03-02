//
//  DiscountController.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DiscountController.h"
#import "MarkUtils.h"
#import "MineDiscountCell.h"
#define DISCOUNTHEIGHT (DEVICE_HEIGHT / 8 + SPACE)
#define DISCOUNTCELL @"discountcell"

@interface DiscountController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *discountList;
@end

@implementation DiscountController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.discountList = [NSMutableArray arrayWithCapacity:3];
  self.discountList[0] = [NSMutableDictionary dictionaryWithDictionary:@{
    @"isOpen" : [NSNumber numberWithBool:false]
  }];
  self.discountList[1] = [NSMutableDictionary dictionaryWithDictionary:@{
    @"isOpen" : [NSNumber numberWithBool:false]
  }];
  self.discountList[2] = [NSMutableDictionary dictionaryWithDictionary:@{
    @"isOpen" : [NSNumber numberWithBool:false]
  }];
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

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:MineDiscountCell.class forCellReuseIdentifier:DISCOUNTCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.discountList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *dict = self.discountList[indexPath.row];
  if ([[dict valueForKey:@"isOpen"] boolValue]) {
    return DISCOUNTHEIGHT * 2;
  } else {
    return DISCOUNTHEIGHT;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineDiscountCell *mdCell =
  [tableView dequeueReusableCellWithIdentifier:DISCOUNTCELL forIndexPath:indexPath];
  return mdCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MineDiscountCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  QMUILogInfo(@"discount controller", @"click:%li-%li", indexPath.section, indexPath.row);
  NSMutableDictionary *dict = self.discountList[indexPath.row];
  if ([[dict valueForKey:@"isOpen"] boolValue]) {
    cell.detailView.hidden = true;
  } else {
    cell.detailView.hidden = false;
  }
  dict[@"isOpen"] = [NSNumber numberWithBool:![[dict valueForKey:@"isOpen"] boolValue]];
  [tableView beginUpdates];
  [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
