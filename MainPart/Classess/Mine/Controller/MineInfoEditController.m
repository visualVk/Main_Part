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
#import "IDAuthViewController.h"
#import "MarkUtils.h"
#import "MineInfoButtonCell.h"
#import "MineInfoCheckBoxCell.h"
#define MINEINFORBUTTONCELL @"mineinforbuttoncell"
#define EDITINFOCELL @"editinfocell"
#define EDITPICKERCELL @"editpickercell"
#define MINEINFOCHECKBOXCELL @"mineinfocheckboxcell"

@interface MineInfoEditController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, EditInfoCellDelegate>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) Info *cpInfo;
@property (nonatomic, strong) IDInfo *idInfo;
@end

@implementation MineInfoEditController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.cpInfo = [Info new];
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
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(saveInfo)];
}

- (void)saveInfo {
  self.info.name = self.cpInfo.name;
  self.info.idCard = self.cpInfo.idCard;
  self.info.phoneNum = self.cpInfo.phoneNum;
  self.info.gender = self.cpInfo.gender;
  self.info.birthday = self.cpInfo.birthday;
  [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:MineInfoButtonCell.class forCellReuseIdentifier:MINEINFORBUTTONCELL];
    [_tableView registerClass:EditInfoCell.class forCellReuseIdentifier:EDITINFOCELL];
    [_tableView registerClass:EditPickerCell.class forCellReuseIdentifier:EDITPICKERCELL];
    [_tableView registerClass:MineInfoCheckBoxCell.class
       forCellReuseIdentifier:MINEINFOCHECKBOXCELL];
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
  if (indexPath.section == 0) return UITableViewAutomaticDimension;
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
      eiCell.content.text = self.cpInfo.name;
      eiCell.editDelegate = self;
      return eiCell;
    }
    if (row == 1) {
      //性别 之后要改成checkbox
      MineInfoCheckBoxCell *micbCell =
      [tableView dequeueReusableCellWithIdentifier:MINEINFOCHECKBOXCELL forIndexPath:indexPath];
      micbCell.title.text = @"性别";
      if (!self.cpInfo.gender) {
        micbCell.checkGroup.selectedCheckBox = micbCell.maleCheck;
      } else {
        micbCell.checkGroup.selectedCheckBox = micbCell.femaleCheck;
      }
      micbCell.delegate = self;
      return micbCell;
    }
    if (row == 2) {
      EditInfoCell *eiCell =
      [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
      eiCell.title.text = @"手机号";
      eiCell.content.text = self.cpInfo.phoneNum ? self.cpInfo.phoneNum : @"";
      eiCell.editDelegate = self;
      return eiCell;
    }
    if (row == 3) {
      EditPickerCell *epCell =
      [tableView dequeueReusableCellWithIdentifier:EDITPICKERCELL forIndexPath:indexPath];
      epCell.title.text = @"生日";
      epCell.content.text = self.cpInfo.birthday ? self.cpInfo.birthday : @"";
      epCell.delegate = self;
      return epCell;
    }
  }
  if (section == 2) {
    EditInfoCell *eiCell =
    [tableView dequeueReusableCellWithIdentifier:EDITINFOCELL forIndexPath:indexPath];
    eiCell.title.text = @"证件号";
    eiCell.content.text = self.cpInfo.idCard;
    eiCell.editDelegate = self;
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
  if (indexPath.section == 0) {
    __weak __typeof(self) weakSelf = self;
    IDAuthViewController *idaCon = [IDAuthViewController new];
    idaCon.IDCardBlock = ^(IDInfo *idInfo) {
      weakSelf.idInfo = idInfo;
      weakSelf.cpInfo.name = idInfo.name;
      weakSelf.cpInfo.gender = ![idInfo.gender isEqualToString:@"男"];
      weakSelf.cpInfo.idCard = idInfo.num;
      [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:idaCon animated:YES];
  }
}

- (void)setInfo:(Info *)info {
  _info = info;
  self.cpInfo = [info copy];
}

- (void)contentValueChange:(NSString *)titleText content:(NSString *)content {
  QMUILogInfo(@"mine info edit controller", @"%@--%@", titleText, content);
  if ([@"姓名" isEqualToString:titleText]) {
    self.cpInfo.name = content;
  } else if ([@"手机号" isEqualToString:titleText]) {
    self.cpInfo.phoneNum = content;
  } else if ([@"证件号" isEqualToString:titleText]) {
    self.cpInfo.idCard = content;
  } else if ([@"生日" isEqualToString:titleText]) {
    self.cpInfo.birthday = content;
  } else if ([@"性别" isEqualToString:titleText]) {
    self.cpInfo.gender = [content boolValue];
  }
}
@end
