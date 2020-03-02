//
//  MileageController.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MileageController.h"
#import "ChartCell.h"
#import "MarkUtils.h"
#import "MineMeliedgeCell.h"
#import "MineOutCell.h"
#define MILEAGECELL @"mileagecell"
#define MINEOUTCELL @"mineoutcell"
#define CHARTCELL @"chartcell"

@interface MileageController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@end

@implementation MileageController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  [self generateRootView];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
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
  self.title = @"旅行记录";
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:MineMeliedgeCell.class forCellReuseIdentifier:MILEAGECELL];
    [_tableView registerClass:MineOutCell.class forCellReuseIdentifier:MINEOUTCELL];
    [_tableView registerClass:ChartCell.class forCellReuseIdentifier:CHARTCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
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

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) return CIRCLEHEIGHT;
  if (section == 1) return DEVICE_HEIGHT / 8;
  if (section == 2) return DEVICE_HEIGHT / 3;
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    MineMeliedgeCell *mmCell =
    [tableView dequeueReusableCellWithIdentifier:MILEAGECELL forIndexPath:indexPath];
    return mmCell;
  }
  if (section == 1) {
    MineOutCell *moCell =
    [tableView dequeueReusableCellWithIdentifier:MINEOUTCELL forIndexPath:indexPath];
    return moCell;
  }
  if (section == 2) {
    ChartCell *cCell =
    [tableView dequeueReusableCellWithIdentifier:CHARTCELL forIndexPath:indexPath];
    return cCell;
  }
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end