//
//  MineInfoEditController.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineInfoEditController.h"
#import "EditInfoCell.h"
#import "EditPickerCell.h"
#import "MarkUtils.h"
#import "MineInfoButtonCell.h"
#define MINEINFORBUTTONCELL @"mineinforbuttoncell"
#define EDITINFOCELL @"editinfocell"
#define EDITPICKERCELL @"editpickercell"

@interface MineInfoEditController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@end

@implementation MineInfoEditController

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
  self.title = @"编辑常用旅客信息";
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

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:MineInfoButtonCell.class forCellReuseIdentifier:MINEINFORBUTTONCELL];
    [_tableView registerClass:EditInfoCell.class forCellReuseIdentifier:EDITINFOCELL];
    [_tableView registerClass:EditPickerCell.class forCellReuseIdentifier:EDITPICKERCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) return 1;
  if (section == 1) return 4;
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 0) {
    MineInfoButtonCell *bibCell =
    [tableView dequeueReusableCellWithIdentifier:MINEINFORBUTTONCELL forIndexPath:indexPath];
    [bibCell.addInfo setTitle:@"识别证件" forState:UIControlStateNormal];
    return bibCell;
  }
  if (section == 1) {
    if (row == 0) {
      EditInfoCell *eiCell =
      [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
      eiCell.title.text = @"姓名";
      return eiCell;
    }
    if (row == 1) {
      //性别 之后要改成checkbox
      EditInfoCell *eiCell =
      [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
      eiCell.title.text = @"性别";
      return eiCell;
    }
    if (row == 2) {
      EditInfoCell *eiCell =
      [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
      eiCell.title.text = @"手机号";
      return eiCell;
    }
    if (row == 3) {
      EditPickerCell *epCell =
      [tableView dequeueReusableCellWithIdentifier:EDITPICKERCELL forIndexPath:indexPath];
      epCell.title.text = @"生日";
      return epCell;
    }
  }
  if (section == 2) {
    EditInfoCell *eiCell =
    [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
    eiCell.title.text = @"证件号";
    return eiCell;
  }
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 1) return @"基础信息";
  if (section == 2) return @"证件";
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
