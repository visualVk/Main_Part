
//
//  MainQuestionController.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainQuestionController.h"
#import "AskQuestionView.h"
#import "HotelDiscussModel.h"
#import "MarkUtils.h"
#import "MoreQuestionCell.h"
#import "QuestionDetailController.h"
#import "QuestionToolBar.h"
#import "Users.h"
#import <MJRefresh.h>
#define MOREQUESTIONCELL @"MoreQuestionCell"

@interface MainQuestionController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource,
QMUIModalPresentationViewControllerDelegate>
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) AskQuestionView *askView;
@property (nonatomic, strong) QMUISearchController *searchBar;
@property (nonatomic, strong) QuestionToolBar *questionToolBar;
@property (nonatomic, strong) NSArray<HotelDisscussList *> *disscussList;
@property (nonatomic, strong) NSString *remarkString;
@end

@implementation MainQuestionController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.remarkString = @"xxxx";
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  self.emptyView.backgroundColor = UIColor.whiteColor;
  self.emptyView.textLabel.text = @"正在加载";
  [self showEmptyView];
  [self findAllDisscussByHotelId:1];
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
  //  self.navigationItem.leftItemsSupplementBackButton = YES;
  self.navigationItem.leftBarButtonItem = NavLeftItemMake(self.searchBar.searchBar);
  self.navigationItem.leftItemsSupplementBackButton = YES;
  //    self.title = @"<##>";
}

- (void)generateRootView {
  addView(self.view, self.tableview);
  addView(self.view, self.questionToolBar);
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.questionToolBar.mas_top);
  }];
  [self.questionToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view);
    make.height.mas_equalTo(88);
    make.left.right.equalTo(self.view);
  }];
}

- (QMUITableView *)tableview {
  if (!_tableview) {
    __weak __typeof(self) weakSelf = self;
    _tableview = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.mj_header = [MJRefreshNormalHeader
                            headerWithRefreshingBlock:^{ [weakSelf findAllDisscussByHotelId:1]; }];
    _tableview.mj_footer = [MJRefreshAutoNormalFooter
                            footerWithRefreshingBlock:^{ [weakSelf findAllDisscussByHotelId:1]; }];
    [_tableview registerClass:MoreQuestionCell.class forCellReuseIdentifier:MOREQUESTIONCELL];
    _tableview.estimatedRowHeight = 10;
    _tableview.qmui_cacheCellHeightByKeyAutomatically = YES;
    _tableview.delegate = self;
    _tableview.dataSource = self;
  }
  return _tableview;
}

- (QuestionToolBar *)questionToolBar {
  if (!_questionToolBar) {
    _questionToolBar = [QuestionToolBar new];
    __weak __typeof(self) weakSelf = self;
    _questionToolBar.questionBlock = ^{
      /// todo:
      QMUIModalPresentationViewController *con = [[QMUIModalPresentationViewController alloc] init];
      con.animationStyle = QMUIModalPresentationAnimationStyleSlide;
      AskQuestionView *view = [[AskQuestionView alloc] initWithFrame:CGRectMake(0, 0, 300, 360)];
      //      [view.textview.rac_textSignal
      //       subscribeNext:^(NSString *_Nullable x) { weakSelf.remarkString = x; }];
      [[view.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
       subscribeNext:^(__kindof UIControl *_Nullable x) {
        /// todo:post question
        [weakSelf postRemark];
      }];
      con.contentView = view;
      con.delegate = weakSelf;
      con.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
      con.layoutBlock =
      ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        view.qmui_frameApplyTransform = CGRectSetXY(
                                                    view.frame,
                                                    CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(view.frame)),
                                                    CGRectGetHeight(containerBounds) - CGRectGetHeight(view.bounds) - 250 -
                                                    keyboardHeight / 3);
      };
      [con showWithAnimated:YES completion:^(BOOL finished){}];
    };
  }
  return _questionToolBar;
}

- (QMUISearchController *)searchBar {
  if (!_searchBar) {
    _searchBar = [[QMUISearchController alloc] initWithContentsViewController:self];
    _searchBar.searchBar.qmui_usedAsTableHeaderView = YES;
    _searchBar.active = NO;
  }
  return _searchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.disscussList.count != 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.disscussList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return -1;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MoreQuestionCell *mqCell =
  [tableView dequeueReusableCellWithIdentifier:MOREQUESTIONCELL forIndexPath:indexPath];
  mqCell.model = self.disscussList[indexPath.section];
  return mqCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  QuestionDetailController *qdCon = [QuestionDetailController new];
  qdCon.model = self.disscussList[indexPath.section];
  [self.navigationController pushViewController:qdCon animated:YES];
}

- (void)findAllDisscussByHotelId:(NSInteger)hotelId {
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager]
   RequestGetWithUrl:[FindDiscussByHotelId stringByAppendingFormat:@"/%li", hotelId]
   Parameter:nil
   Success:^(NSDictionary *_Nullable dict) {
    HotelDiscussModel *tmp = [HotelDiscussModel mj_objectWithKeyValues:dict];
    weakSelf.disscussList = tmp.data;
    [self.tableview reloadData];
    [weakSelf hideEmptyView];
    [weakSelf.tableview.mj_header endRefreshing];
    [weakSelf.tableview.mj_footer endRefreshing];
  }
   Failure:^(NSError *_Nullable err) {
    QMUILogInfo(@"Main question", @"disscuss:{%@}", [err description]);
  }];
}

- (void)postRemark {
  Users *users = [[Users alloc] init];
  [[RequestUtils shareManager] RequestPostWithURLManage:PostDiscuss
                                                 Params:@{
                                                   @"hotelId" : @1,
                                                   @"username" : @"x123123???",
                                                   @"content" : @"what???",
                                                   @"roomtypeId" : @1
                                                 }
                                                Success:^(NSDictionary *_Nullable dict) {
    if ([dict[@"code"] integerValue] == 200) {
      [QMUITips showSucceed:@"评论"
                     inView:[UIApplication sharedApplication].keyWindow
             hideAfterDelay:1];
      QMUILogInfo(@"main question", @"{%@},{token:%@}", [dict description], Bearer);
    }
  }
                                                Failure:^(NSError *_Nullable err){
    
  }];
  //  [[RequestUtils shareManager] RequestPostWithUrl:PostDiscuss
  //                                        Parameter:
  //                                          Success:^(NSDictionary *_Nullable dict) {
  //    if ([dict[@"code"] integerValue] == 200) {
  //      [QMUITips showSucceed:@"发送成功" inView:self.view hideAfterDelay:1];
  //    }
  //    QMUILogInfo(@"main question", @"{%@},{token:%@}", [dict description], Bearer);
  //  }
  //                                          Failure:^(NSError *_Nullable err){
  //
  //  }];
}

- (void)didHideModalPresentationViewController:(QMUIModalPresentationViewController *)controller {
  [self findAllDisscussByHotelId:1];
  [self.tableview reloadData];
}
@end
