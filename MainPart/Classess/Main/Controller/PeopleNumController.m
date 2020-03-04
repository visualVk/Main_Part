//
//  PeopleNumController.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PeopleNumController.h"
#import "HotelNumberCell.h"
#import "MarkUtils.h"
#define HOTELNUMBERCELL @"hotelnumbercell"

@interface PeopleNumController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUIButton *confirmBtn;
@end

@implementation PeopleNumController

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
  self.title = @"入住条件";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  addView(self.view, self.confirmBtn);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.confirmBtn.mas_top);
  }];
  
  [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view).with.inset(0.5 * SPACE);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:HotelNumberCell.class forCellReuseIdentifier:HOTELNUMBERCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (QMUIButton *)confirmBtn {
  if (!_confirmBtn) {
    _confirmBtn = [QDUIHelper generateDarkFilledButton];
    _confirmBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = UIFontBoldMake(18);
  }
  return _confirmBtn;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HotelNumberCell *hnCell =
  [tableView dequeueReusableCellWithIdentifier:HOTELNUMBERCELL forIndexPath:indexPath];
  return hnCell;
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
