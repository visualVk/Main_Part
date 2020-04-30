
//
//  MainQuestionController.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainQuestionController.h"
#import "AskQuestionView.h"
#import "MarkUtils.h"
#import "MoreQuestionCell.h"
#import "QuestionDetailController.h"
#import "QuestionToolBar.h"
#define MOREQUESTIONCELL @"MoreQuestionCell"

@interface MainQuestionController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) AskQuestionView *askView;
@property (nonatomic, strong) QMUISearchController *searchBar;
@property (nonatomic, strong) QuestionToolBar *questionToolBar;
@end

@implementation MainQuestionController

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
    _tableview = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
      [[view.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
       subscribeNext:^(__kindof UIControl *_Nullable x){
        /// todo:post question
      }];
      con.contentView = view;
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
  return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
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
  return mqCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  QuestionDetailController *qdCon = [QuestionDetailController new];
  [self.navigationController pushViewController:qdCon animated:YES];
}
@end
