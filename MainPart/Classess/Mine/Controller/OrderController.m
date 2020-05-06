//
//  OrderController.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderController.h"
#import "MarkUtils.h"
#import "MineOrderCell.h"
#import "NSDictionary+LoadJson.h"
#import "OrderCheckInfo.h"
#import "OrderCheckInfoModelList.h"
#import "OrderDetailController.h"
#import <HMSegmentedControl.h>
#define MINEORDERCELL @"mineordercell"
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588774467241&di="                                \
@"fb358dc0537c255c00aa2559bbd9197c&imgtype=0&src=http%3A%2F%2Fhotels.buytrip.cn%2Fhotelimg%"   \
@"2F2012922135236429.jpg",                                                                     \
@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/"                                    \
@"u=775827514,337286644&fm=26&gp=0.jpg"                                                        \
]

@interface OrderController () <QMUITableViewDelegate, QMUITableViewDataSource,
GenerateEntityDelegate>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) HMSegmentedControl *segCon;
@property (nonatomic, assign) NSInteger *selectedIndex;
@property (nonatomic, strong) NSMutableArray<OrderCheckInfo *> *orderCheckInfoList;
@property (nonatomic, strong) NSMutableArray<OrderCheckInfo *> *cancelInfoList;
@property (nonatomic, strong) NSMutableArray<OrderCheckInfo *> *waitPayInfoList;
@property (nonatomic, strong) NSMutableArray<OrderCheckInfo *> *waitReviewInfoList;
@end

@implementation OrderController

- (instancetype)initWithOrderType:(OrderControllerType)type {
  if (self = [super init]) {
    self.cancelInfoList = [NSMutableArray new];
    self.waitPayInfoList = [NSMutableArray new];
    self.waitReviewInfoList = [NSMutableArray new];
    [self didInitialize];
    switch (type) {
      case AllOrder:
        self.selectedIndex = 0;
        break;
      case NonPaymentOrder:
        self.selectedIndex = 1l;
        break;
      case FutureOrder:
        self.selectedIndex = 2l;
        break;
      case RemarkOrder:
        self.selectedIndex = 3l;
        break;
      default:
        break;
    }
    
#ifdef Test_Hotel
    NSDictionary *dict = [NSDictionary readLocalFileWithName:@"MineOrderListJSON"];
    //    OrderCheckInfo *modelOne = [[OrderCheckInfo alloc] initWithDictionary:dict];
    //    OrderCheckInfo *modelTwo = [[OrderCheckInfo alloc] initWithDictionary:dict];
    //    OrderCheckInfo *modelThree = [[OrderCheckInfo alloc] initWithDictionary:dict];
    self.orderCheckInfoList = [OrderCheckInfoModelList mj_objectWithKeyValues:dict].data;
    for (OrderCheckInfo *obj in self.orderCheckInfoList) {
      obj.imgUrl = imgList[arc4random() % imgList.count];
      switch (obj.orderStatus) {
        case 0:
          [self.cancelInfoList addObject:obj];
          break;
        case 1:
          [self.waitReviewInfoList addObject:obj];
          break;
        case 2:
          [self.waitPayInfoList addObject:obj];
        default:
          break;
      }
    }
#endif
  }
  return self;
}

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
  self.title = @"订单";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.segCon);
  addView(self.view, self.tableView);
  
  [self.segCon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.height.mas_equalTo(DEVICE_HEIGHT / 20);
  }];
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.segCon.mas_bottom);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:MineOrderCell.class forCellReuseIdentifier:MINEORDERCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (HMSegmentedControl *)segCon {
  if (!_segCon) {
    _segCon = [[HMSegmentedControl alloc]
               initWithSectionTitles:@[ @"全部订单", @"待付款", @"未出行", @"待评价" ]];
    _segCon.selectedSegmentIndex = self.selectedIndex;
    _segCon.selectedTitleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_tintColor,
      NSFontAttributeName : UIFontBoldMake(14)
    };
    _segCon.selectionIndicatorColor = UIColor.qd_tintColor;
    _segCon.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segCon.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCon.selectionIndicatorHeight = 3.0f;
    _segCon.backgroundColor = UIColor.clearColor;
    _segCon.titleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_titleTextColor,
      NSFontAttributeName : UIFontMake(14)
    };
    __weak __typeof(self) weakSelf = self;
    _segCon.indexChangeBlock = ^(NSInteger index) {
      QMUILogInfo(@"order controller", @"change:%li", index);
      weakSelf.selectedIndex = index;
      [weakSelf.tableView reloadData];
    };
  }
  return _segCon;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  //  return 4;
  int i = self.selectedIndex;
  switch (i) {
    case 0:
      return self.orderCheckInfoList.count;
    case 1:
      return self.waitPayInfoList.count;
    case 2:
      return self.cancelInfoList.count;
    default:
      return self.waitReviewInfoList.count;
      break;
  }
  return self.orderCheckInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineOrderCell *moCell =
  [tableView dequeueReusableCellWithIdentifier:MINEORDERCELL forIndexPath:indexPath];
  int i = self.selectedIndex;
  switch (i) {
    case 0:
      moCell.model = self.orderCheckInfoList[indexPath.row];
      break;
    case 1:
      moCell.model = self.waitReviewInfoList[indexPath.row];
      break;
    case 2:
      moCell.model = self.cancelInfoList[indexPath.row];
      break;
    default:
      moCell.model = self.waitPayInfoList[indexPath.row];
      break;
  }
  //  moCell.model = self.orderCheckInfoList[indexPath.row];
  return moCell;
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  OrderDetailController *odCon = [OrderDetailController new];
  odCon.orderCheckInfo = self.orderCheckInfoList[indexPath.row];
  [self.navigationController pushViewController:odCon animated:YES];
}
@end
