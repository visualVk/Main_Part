//
//  CheckInController.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "CheckInController.h"
#import "AppDelegate.h"
#import "HotelComboCell.h"
#import "HotelWarnCell.h"
#import "MarkUtils.h"
#import "MentionCell.h"
#import "OrderDiscountCell.h"
#import "OrderInfoCell.h"
#import "OrderToolBarView.h"
#import "PayMethodController.h"
#import "SloganCell.h"
#define MENTIONCELL @"mentioncell"
#define SLOGANCELL @"slogancell"
#define HOTELCOMBOCELL @"hotelcombocell"
#define HOTELWARNCELL @"hotelwarncell"
#define ORDERDISCOUNTCELL @"orderdiscountcell"
#define ORDERINFOCELL @"orderinfocell"

@interface CheckInController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) OrderToolBarView *orderToolBar;
@property (nonatomic, strong) UIView *dmingView;
@property (nonatomic, strong) POPSpringAnimation *anim;
@end

@implementation CheckInController

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
  //  self.title = @"酒店名";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  addView(self.view, self.orderToolBar);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.orderToolBar.mas_top);
  }];
  
  [self.orderToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.trailing.leading.equalTo(self.view);
    make.height.mas_equalTo(DEVICE_HEIGHT / 12);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    _tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
    _tableView.estimatedRowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:HotelComboCell.class forCellReuseIdentifier:HOTELCOMBOCELL];
    [_tableView registerClass:HotelWarnCell.class forCellReuseIdentifier:HOTELWARNCELL];
    [_tableView registerClass:OrderInfoCell.class forCellReuseIdentifier:ORDERINFOCELL];
    [_tableView registerClass:OrderDiscountCell.class forCellReuseIdentifier:ORDERDISCOUNTCELL];
    [_tableView registerClass:MentionCell.class forCellReuseIdentifier:MENTIONCELL];
    [_tableView registerClass:SloganCell.class forCellReuseIdentifier:SLOGANCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColor.qd_customBackgroundColor;
  }
  return _tableView;
}

- (OrderToolBarView *)orderToolBar {
  if (!_orderToolBar) {
    _orderToolBar = [OrderToolBarView new];
    __weak __typeof(self) weakSelf = self;
    //    addView(self.dmingView, _orderToolBar.tableView);
    _orderToolBar.popOrderDetail = ^{
      addView(weakSelf.dmingView, weakSelf.orderToolBar.tableView);
      AppDelegate *delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
      //      addView(weakSelf.view, weakSelf.orderToolBar.tableView);
      [delegate.window addSubview:weakSelf.dmingView];
      [weakSelf.orderToolBar.tableView.layer removeAnimationForKey:@"springanimate"];
      [weakSelf.orderToolBar.tableView.layer pop_addAnimation:weakSelf.anim
                                                       forKey:@"springanimate"];
    };
    _orderToolBar.pushPay = ^{
      PayMethodController *pCon = [PayMethodController new];
      //      [weakSelf popDimingView];
      [weakSelf removeDimingContainer];
      [weakSelf.navigationController pushViewController:pCon animated:YES];
    };
  }
  return _orderToolBar;
}

- (UIView *)dmingView {
  if (!_dmingView) {
    _dmingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    UIView *topView = [[UIView alloc]
                       initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,
                                                DEVICE_HEIGHT -
                                                (DEVICE_HEIGHT / 12 +
                                                 SafeAreaInsetsConstantForDeviceWithNotch.bottom))];
    topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    UIView *bottomView = [[UIView alloc]
                          initWithFrame:CGRectMake(0,
                                                   DEVICE_HEIGHT - (DEVICE_HEIGHT / 12 +
                                                                    SafeAreaInsetsConstantForDeviceWithNotch.bottom),
                                                   DEVICE_WIDTH,
                                                   DEVICE_HEIGHT / 12 +
                                                   SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
    bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    addView(_dmingView, topView);
    addView(_dmingView, bottomView);
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popDimingView:)];
    [_dmingView addGestureRecognizer:tap];
  }
  return _dmingView;
}

- (POPSpringAnimation *)anim {
  if (!_anim) {
    _anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    _anim.springBounciness = 6;
    _anim.springSpeed = 10;
    _anim.fromValue = @(self.dmingView.frame.size.height);
    _anim.toValue =
    @(self.dmingView.frame.size.height - self.orderToolBar.tableView.frame.size.height);
    //    [self.orderToolBar.tableView.layer pop_addAnimation:_anim forKey:@"AnimationScale"];
  }
  return _anim;
}

- (void)popDimingView:(UITapGestureRecognizer *)tap {
  //  [self.dmingView qmui_removeAllSubviews];
  CGPoint point = [tap locationInView:self.dmingView];
  if (!CGRectContainsPoint(self.orderToolBar.tableView.frame, point)) {
    [self removeDimingContainer];
  }
}

- (void)removeDimingContainer {
  [self.dmingView removeFromSuperview];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return -1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  if (row == 0) {
    HotelComboCell *hcCell =
    [tableView dequeueReusableCellWithIdentifier:HOTELCOMBOCELL forIndexPath:indexPath];
    [hcCell loadData:@{
      @"stDate" : [NSDate dateWithTimeIntervalSinceNow:0],
      @"edDate" : [NSDate dateWithTimeIntervalSinceNow:6 * 24 * 60 * 60],
      @"room" : @"1",
      @"people" : @"2"
    }];
    return hcCell;
  }
  if (row == 1) {
    HotelWarnCell *hwCell =
    [tableView dequeueReusableCellWithIdentifier:HOTELWARNCELL forIndexPath:indexPath];
    return hwCell;
  }
  if (row == 2) {
    OrderInfoCell *oiCell =
    [tableView dequeueReusableCellWithIdentifier:ORDERINFOCELL forIndexPath:indexPath];
    return oiCell;
  }
  if (row == 3) {
    OrderDiscountCell *odCell =
    [tableView dequeueReusableCellWithIdentifier:ORDERDISCOUNTCELL forIndexPath:indexPath];
    return odCell;
  }
  if (row == 4) {
    MentionCell *mCell =
    [tableView dequeueReusableCellWithIdentifier:MENTIONCELL forIndexPath:indexPath];
    return mCell;
  }
  if (row == 5) {
    SloganCell *sCell =
    [tableView dequeueReusableCellWithIdentifier:SLOGANCELL forIndexPath:indexPath];
    return sCell;
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
