//
//  HistoryController.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HistoryController.h"
#import "MarkUtils.h"
#import "MineHistoryCell.h"
#define HISTORYCELL @"historycell"
#define HISOTRYHEGITH DEVICE_HEIGHT / 8
@interface HistoryController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyList;
@end

@implementation HistoryController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.historyList = [NSMutableArray arrayWithCapacity:3];
  self.historyList[0] = [NSMutableArray arrayWithArray:@[ @"", @"", @"" ]];
  self.historyList[1] = [NSMutableArray arrayWithArray:@[ @"", @"", @"" ]];
  self.historyList[2] = [NSMutableArray arrayWithArray:@[ @"", @"", @"" ]];
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
  self.title = @"浏览历史";
}

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
    [_tableView registerClass:MineHistoryCell.class forCellReuseIdentifier:HISTORYCELL];
    //    [_tableView setEditing:YES animated:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.historyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSMutableArray *cur = self.historyList[section];
  return cur.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return HISOTRYHEGITH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  NSMutableArray *cur = self.historyList[section];
  if (!cur.count) return 0;
  return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineHistoryCell *mhCell =
  [tableView dequeueReusableCellWithIdentifier:HISTORYCELL forIndexPath:indexPath];
  if (indexPath.section == 0) { [mhCell remark]; }
  return mhCell;
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

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
  UIContextualAction *deleteRowAction = [UIContextualAction
                                         contextualActionWithStyle:UIContextualActionStyleDestructive
                                         title:@"删除"
                                         handler:^(UIContextualAction *_Nonnull action,
                                                   __kindof UIView *_Nonnull sourceView,
                                                   void (^_Nonnull completionHandler)(BOOL)) {
    NSMutableArray *cur = self.historyList[indexPath.section];
    [cur removeObjectAtIndex:indexPath.row];
    completionHandler(YES);
    [self.tableView reloadData];
  }];
  deleteRowAction.backgroundColor = [UIColor redColor];
  
  UISwipeActionsConfiguration *config =
  [UISwipeActionsConfiguration configurationWithActions:@[ deleteRowAction ]];
  return config;
}
@end
