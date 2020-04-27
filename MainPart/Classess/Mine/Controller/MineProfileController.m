//
//  MineProfileController.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineProfileController.h"
#import "AppDelegate.h"
#import "LoginMainController.h"
#import "MarkUtils.h"
#import "MineAvatarPickerController.h"
#import "MineInfoSetController.h"
#import "MineNewPhoneController.h"
#import "MineProfileAvatarCell.h"
#import "MineQRCodeController.h"
#import "QDAlertHelper.h"
#import <SJAttributesFactory.h>
#define MINEPROFILEAVATARCELL @"mineprofileavatarcell"

@interface MineProfileController () <QMUITableViewDelegate, QMUITableViewDataSource,
GenerateEntityDelegate, MineAvatraPickerDelegate> {
  BOOL _isExisted;
}
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSArray *profileList;
@property (nonatomic, strong) MineAvatarPickerController *avatarPickerController;
@end

@implementation MineProfileController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.profileList = @[
    @[
      @{ @"title" : @"个人头像",
         @"detail" : UIImageMake(@"pink_gradient") },
      @{ @"title" : @"身份认证",
         @"detail" : @"已认证" },
      @{ @"title" : @"绑定手机号",
         @"detail" : @"" },
      @{ @"title" : @"账号",
         @"detail" : @"asdsadasda" },
      @{ @"title" : @"我的二维码",
         @"detail" : @"qrcode_mark" }
    ],
    @[
      @{ @"title" : @"用户昵称",
         @"detail" : @"blacksky" }
    ],
    @[
      @{ @"title" : @"修改密码",
         @"detail" : @"手机号验证" }
    ],
    @[
      @{ @"title" : @"退出登录",
         @"detail" : @"" }
    ]
  ];
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
  self.title = @"个人信息";
#ifdef Test_Hotel
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"切换"
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(changePhone)];
#endif
}
- (void)changePhone {
  self.profileList = @[
    @[
      @{ @"title" : @"个人头像",
         @"detail" : UIImageMake(@"pink_gradient") },
      @{ @"title" : @"身份认证",
         @"detail" : @"已认证" },
      @{ @"title" : @"绑定手机号",
         @"detail" : @"18367711866" },
      @{ @"title" : @"账号",
         @"detail" : @"asdsadasda" },
      @{ @"title" : @"我的二维码",
         @"detail" : @"qrcode_mark" }
    ],
    @[
      @{ @"title" : @"用户昵称",
         @"detail" : @"blacksky" }
    ],
    @[
      @{ @"title" : @"修改密码",
         @"detail" : @"手机号验证" }
    ],
    @[
      @{ @"title" : @"退出登录",
         @"detail" : @"" }
    ]
  ];
  [self.tableView reloadData];
}
#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:MineProfileAvatarCell.class
       forCellReuseIdentifier:MINEPROFILEAVATARCELL];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}
- (MineAvatarPickerController *)avatarPickerController {
  if (!_avatarPickerController) {
    _avatarPickerController = [MineAvatarPickerController new];
    _avatarPickerController.parentController = self;
    _avatarPickerController.delegate = self;
  }
  return _avatarPickerController;
}
#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.bottom.equalTo(self.view);
  }];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.profileList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *arr = self.profileList[section];
  return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 20;
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
  NSDictionary *dict = self.profileList[indexPath.section][indexPath.row];
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      MineProfileAvatarCell *mpaCell =
      [tableView dequeueReusableCellWithIdentifier:MINEPROFILEAVATARCELL
                                      forIndexPath:indexPath];
      mpaCell.avatarTitle = dict[@"title"];
      mpaCell.avatarImg.image = dict[@"detail"];
      return mpaCell;
    }
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell"];
    if (!cell) {
      cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                               withStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:@"normalcell"];
      cell.textLabel.textColor = UIColor.blackColor;
      cell.textLabel.font = UIFontMake(17);
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = dict[@"title"];
    if ([@"我的二维码" isEqualToString:dict[@"title"]]) {
      cell.detailTextLabel.attributedText =
      [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
        make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
          make.image = UIImageMake(dict[@"detail"]);
        });
      }];
    } else {
      if ([@"绑定手机号" isEqualToString:dict[@"title"]]) { //手机号中间4位隐藏
        if (dict[@"detail"] != nil && ((NSString *)dict[@"detail"]).length != 0) {
          cell.detailTextLabel.text =
          [dict[@"detail"] stringByReplacingCharactersInRange:NSMakeRange(3, 4)
                                                   withString:@"****"];
          _isExisted = YES;
        } else
          _isExisted = false;
      } else {
        cell.detailTextLabel.text = dict[@"detail"];
      }
    }
    return cell;
  }
  QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titlecell"];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                             withStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:@"titlecell"];
    cell.textLabel.font = UIFontMake(17);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = UIColor.blackColor;
  }
  if ([@"退出登录" isEqualToString:dict[@"title"]]) {
    cell.textLabel.textColor = UIColorRed;
  } else {
    cell.textLabel.textColor = UIColor.blackColor;
  }
  cell.textLabel.text = dict[@"title"];
  cell.detailTextLabel.text = dict[@"detail"];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString *detail = self.profileList[indexPath.section][indexPath.row][@"detail"];
  NSString *title = self.profileList[indexPath.section][indexPath.row][@"title"];
  UIViewController *desCon = nil;
  if ([@"我的二维码" isEqualToString:title]) {
    MineQRCodeController *mqrcCon = [MineQRCodeController new];
    mqrcCon.title = title;
    [self.navigationController pushViewController:mqrcCon animated:YES];
  } else if ([@"绑定手机号" isEqualToString:title]) {
    MineNewPhoneController *mnpCon = [MineNewPhoneController new];
    if (detail == nil || detail.length == 0) {
      mnpCon.phoneType = NewPhone;
      mnpCon.title = @"绑定手机号";
    } else {
      mnpCon.phoneType = OlderPhone;
      mnpCon.title = @"解绑手机号";
    }
    [self.navigationController pushViewController:mnpCon animated:YES];
  } else if ([@"修改密码" isEqualToString:title]) {
    if (!_isExisted) {
      __weak __typeof(self) weakSelf = self;
      [QDAlertHelper
       showChooseAlertWithTitle:@"暂时没有绑定手机号"
       message:@"是否先绑定手机号？"
       preferredStyle:QMUIAlertControllerStyleAlert
       chooseList:@[ @"是", @"否" ]
       chooseBlock:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
          MineNewPhoneController *mnpCon = [MineNewPhoneController new];
          mnpCon.phoneType = NewPhone;
          mnpCon.title = @"绑定手机号";
          [weakSelf.navigationController pushViewController:mnpCon animated:YES];
        }
      }];
    } else {
      MineNewPhoneController *mnp = [MineNewPhoneController new];
      mnp.phoneType = NewPhonePassword;
      mnp.title = @"请输入手机号";
      [self.navigationController pushViewController:mnp animated:YES];
    }
  } else if ([@"用户昵称" isEqualToString:title]) {
    MineInfoSetController *misCon = [MineInfoSetController new];
    misCon.nameTextField.text = detail;
    misCon.title = @"用户昵称";
    [self.navigationController pushViewController:misCon animated:YES];
  } else if ([@"个人头像" isEqualToString:title]) {
    [self.avatarPickerController
     authorizationPresentAlbumViewControllerWithTitle:@"选"
     @"择头像图片"];
  } else if ([@"退出登录" isEqualToString:title]) {
    BOOL islogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"];
    if (!islogin) {
      [[NSUserDefaults standardUserDefaults] setValue:@(false) forKey:@"islogin"];
      [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES
                                                                                 completion:nil];
    } else {
      [[NSUserDefaults standardUserDefaults] setValue:@(false) forKey:@"islogin"];
      [self dismissViewControllerAnimated:YES
                               completion:^{
        AppDelegate *delegate =
        (AppDelegate *)UIApplication.sharedApplication.delegate;
        delegate.window.rootViewController = [LoginMainController new];
      }];
    }
    //    [self.navigationController popoverPresentationController];
  }
}

#pragma mark - MineAvatraPickerDelegate
- (void)installAvatar:(UIImage *)avatar {
  self.profileList = @[
    @[
      @{ @"title" : @"个人头像",
         @"detail" : avatar },
      @{ @"title" : @"身份认证",
         @"detail" : @"已认证" },
      @{ @"title" : @"绑定手机号",
         @"detail" : @"" },
      @{ @"title" : @"账号",
         @"detail" : @"asdsadasda" },
      @{ @"title" : @"我的二维码",
         @"detail" : @"qrcode_mark" }
    ],
    @[
      @{ @"title" : @"用户昵称",
         @"detail" : @"blacksky" }
    ],
    @[
      @{ @"title" : @"修改密码",
         @"detail" : @"手机号验证" }
    ],
    @[
      @{ @"title" : @"退出登录",
         @"detail" : @"" }
    ]
  ];
  [self.tableView reloadData];
}
@end
