//
//  MineInfoController.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineInfoController.h"
#import "IDCardInfoCell.h"
#import "MarkUtils.h"
#import "MineInfoButtonCell.h"
#import "MineInfoEditController.h"
#import "QMUIConfigurationTemplate.h"
#import <HMSegmentedControl.h>
#define IDCARDINFOCELL @"idcardinfocell"
#define MINEINFOBUTTONCELL @"mineinfobuttoncell"
#import "CheckInPeopleInfoList.h"
#import "NSDictionary+LoadJson.h"

@interface MineInfoController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *touristTableView;
@property (nonatomic, strong) NSMutableArray<Info *> *infoList;
@end

@implementation MineInfoController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  NSDictionary *dict = [NSDictionary readLocalFileWithName:@"HotelCheckInPeopleInfoModelJSON"];
  CheckInPeopleInfoList *list = [[CheckInPeopleInfoList alloc] initWithDictionary:dict];
  self.infoList = [list.info mutableCopy];
#endif
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
  for (UIView *subview in self.touristTableView.subviews) {
    if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
      //修改背景颜色
      subview.backgroundColor = [UIColor clearColor];
      //修改按钮-颜色
      UIButton *swipeActionStandardBtn = subview.subviews[0];
      if ([swipeActionStandardBtn
           isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
        //        CGFloat swipeActionStandardBtnOX = swipeActionStandardBtn.frame.origin.x;
        //        CGFloat swipeActionStandardBtnW = swipeActionStandardBtn.frame.size.width;
        //        swipeActionStandardBtn.frame = CGRectMake(swipeActionStandardBtnOX, 0,
        //                                                  swipeActionStandardBtnW,
        //                                                  self.cellHeightRef - 10);
        
        [swipeActionStandardBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        //        [swipeActionStandardBtn setTitleColor:[UIColor whiteColor]
        //                                     forState:UIControlStateHighlighted];
        //        [swipeActionStandardBtn setTitleColor:[UIColor whiteColor]
        //        forState:UIControlStateSelected];
      }
    }
  }
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"常用信息";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.touristTableView);
  
  [self.touristTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view);
    //    make.width.mas_equalTo(DEVICE_WIDTH);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)touristTableView {
  if (!_touristTableView) {
    _touristTableView = [QMUITableView new];
    _touristTableView.backgroundColor = UIColor.clearColor;
    [_touristTableView registerClass:MineInfoButtonCell.class
              forCellReuseIdentifier:MINEINFOBUTTONCELL];
    [_touristTableView registerClass:IDCardInfoCell.class forCellReuseIdentifier:IDCARDINFOCELL];
    _touristTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _touristTableView.delegate = self;
    _touristTableView.dataSource = self;
  }
  return _touristTableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#ifdef Test_Hotel
  if (section == 0) return 1;
  if (section == 1) { return self.infoList.count; }
#endif
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (tableView == self.touristTableView) {
    switch (section) {
      case 0:
        return UITableViewAutomaticDimension;
      case 1:
        return DEVICE_HEIGHT / 9;
      default:
        break;
    }
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (tableView == self.touristTableView) {
    if (section == 0) {
      MineInfoButtonCell *minbCell =
      [tableView dequeueReusableCellWithIdentifier:MINEINFOBUTTONCELL forIndexPath:indexPath];
      return minbCell;
    }
    if (section == 1) {
      IDCardInfoCell *inCell =
      [tableView dequeueReusableCellWithIdentifier:IDCARDINFOCELL forIndexPath:indexPath];
      inCell.model = self.infoList[indexPath.row];
      return inCell;
    }
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
  MineInfoEditController *editCon = [MineInfoEditController new];
  editCon.info = self.infoList[indexPath.row];
  [self.navigationController pushViewController:editCon animated:YES];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
  UIContextualAction *deleteRowAction =
  [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                          title:@""
                                        handler:^(UIContextualAction *_Nonnull action,
                                                  __kindof UIView *_Nonnull sourceView,
                                                  void (^_Nonnull completionHandler)(BOOL)) {
    [self.infoList removeObjectAtIndex:indexPath.row];
    completionHandler(YES);
    [self.touristTableView reloadData];
  }];
  deleteRowAction.backgroundColor = UIColor.qd_customBackgroundColor;
  deleteRowAction.image = UIImageMake(@"mine_tourist_delete");
  
  UISwipeActionsConfiguration *config =
  [UISwipeActionsConfiguration configurationWithActions:@[ deleteRowAction ]];
  return config;
}

- (void)setInfoList:(NSMutableArray<Info *> *)infoList {
  _infoList = infoList;
  [self.touristTableView reloadData];
}
@end
