//
//  PayController.m
//  MainPart
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PayMethodController.h"
#import "AppDelegate.h"
#import "MarkUtils.h"
#import "PayDeadlineCell.h"
#import "PayFinishController.h"
#import "PayMethodCell.h"
#import "PayPasswordController.h"
#import <POP.h>
#define PAYDEADLINECELL @"paydeadlinecell"
#define PAYMETHODCELL @"paymethodcell"
@interface PayMethodController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, PayPasswordDelegate> {
  NSInteger methodIndex;
}
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUIButton *subBtn;
@property (nonatomic, strong) PayPasswordController *ppCon;
@end

@implementation PayMethodController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  methodIndex = 0;
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
  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
                              animated:YES
                        scrollPosition:UITableViewScrollPositionNone];
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
  self.title = @"支付";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  addView(self.view, self.subBtn);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.left.right.equalTo(self.view);
  }];
  
  [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.height.mas_equalTo(DEVICE_HEIGHT / 20);
    make.left.right.equalTo(self.view).with.inset(0.5 * SPACE);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:PayMethodCell.class forCellReuseIdentifier:PAYMETHODCELL];
    [_tableView registerClass:PayDeadlineCell.class forCellReuseIdentifier:PAYDEADLINECELL];
    //    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
    //                            animated:YES
    //                      scrollPosition:UITableViewScrollPositionNone];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (QMUIButton *)subBtn {
  if (!_subBtn) {
    _subBtn = [QDUIHelper generateDarkFilledButton];
    [_subBtn setTitle:@"确认支付" forState:normal];
    [_subBtn addTarget:self
                action:@selector(confirmPayment)
      forControlEvents:UIControlEventTouchUpInside];
  }
  return _subBtn;
}

#pragma mark - ,QMUITableViewDelegate,QMUITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 3;
    default:
      break;
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  switch (section) {
    case 0:
      return DEVICE_HEIGHT / 4;
    case 1:
      return DEVICE_HEIGHT / 15;
      
    default:
      break;
  }
  return DEVICE_HEIGHT / 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) { return 0.1; }
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    PayDeadlineCell *pdCell =
    [tableView dequeueReusableCellWithIdentifier:PAYDEADLINECELL forIndexPath:indexPath];
    [pdCell reloadShouldPay:self.price];
    return pdCell;
  }
  if (section == 1) {
    PayMethodCell *pmCell =
    [tableView dequeueReusableCellWithIdentifier:PAYMETHODCELL forIndexPath:indexPath];
    switch (indexPath.row) {
      case 0:
        pmCell.method.text = @"支付宝";
        break;
      case 1:
        pmCell.method.text = @"微信";
        break;
      default:
        pmCell.method.text = @"银行卡";
    }
    return pmCell;
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
  [tableView selectRowAtIndexPath:indexPath
                         animated:YES
                   scrollPosition:UITableViewScrollPositionNone];
  methodIndex = indexPath.row;
}

- (void)confirmPayment {
  self.ppCon = [PayPasswordController new];
  self.ppCon.price = self.price;
  self.ppCon.payDelegate = self;
  UIWindow *window = UIApplication.sharedApplication.keyWindow;
  [self presentPayAnimate:self.ppCon.container];
  [window addSubview:self.ppCon.view];
}

- (void)didFinishInput:(NSString *)password {
  QMUILogInfo(@"pay method controller", @"password:%@", password);
  [QMUITips showLoading:@"支付中" inView:UIApplication.sharedApplication.keyWindow];
  __weak __typeof(self) weakSelf = self;
#ifndef Test_Hotel
  [weakSelf postPay];
#endif
#ifdef Test_Hotel
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
    [QMUITips hideAllTips];
    [weakSelf.ppCon.view removeFromSuperview];
    BOOL result = true;
    if (result) { //支付成功
      NSMutableArray<UIViewController *> *cons =
      weakSelf.navigationController.viewControllers.mutableCopy;
      [cons removeObjectsInRange:NSMakeRange(cons.count - 2, 2)];
      PayFinishController *pfCon = [PayFinishController new];
      pfCon.title = @"支付成功";
      [cons addObject:pfCon];
      weakSelf.navigationController.viewControllers = cons;
    }
  });
#endif
}

- (void)closePayPassword {
  [self.ppCon.view removeFromSuperview];
}

- (void)presentPayAnimate:(UIView *)view {
  [view.layer pop_removeAnimationForKey:@"scale"];
  POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  spring.springBounciness = 10;
  spring.springSpeed = 10;
  spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
  spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
  [view.layer pop_addAnimation:spring forKey:@"scale"];
}

- (void)postPay {
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager]
   RequestPostWithUrl:PostPay
   Object:self.model
   Success:^(NSDictionary *_Nullable dict) {
    [QMUITips hideAllTips];
    [QMUITips showInfo:dict[@"message"] inView:self.view hideAfterDelay:2];
    QMUILogInfo(@"method info controller", @"success");
    [weakSelf.ppCon.view removeFromSuperview];
    BOOL result = ([dict[@"code"] integerValue] == 200);
    if (result) { //支付成功
      NSMutableArray<UIViewController *> *cons =
      weakSelf.navigationController.viewControllers.mutableCopy;
      [cons removeObjectsInRange:NSMakeRange(cons.count - 2, 2)];
      PayFinishController *pfCon = [PayFinishController new];
      pfCon.title = @"支付成功";
      [cons addObject:pfCon];
      weakSelf.navigationController.viewControllers = cons;
    }
  }
   Failure:^(NSError *_Nullable err){
    
  }];
}
@end
