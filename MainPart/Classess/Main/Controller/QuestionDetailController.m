//
//  QuestionDetailController.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QuestionDetailController.h"
#import "MarkUtils.h"
#import "QuestionAnsDetailCell.h"
#import "QuestionAnsTitleCell.h"
#import "QuestionDetailTitleView.h"
#define QUESTIONANSTITLECELL @"QuestionAnsTitleCell"
#define QUESTIONANSDETAILCELL @"QuestionAnsDetailCell"

@interface QuestionDetailController () <QMUITableViewDelegate, QMUITableViewDataSource,
GenerateEntityDelegate>
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) QuestionDetailTitleView *questionTitleView;
@end

@implementation QuestionDetailController

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
  self.view.backgroundColor = UIColor.lightGrayColor;
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
  self.title = @"问答详情";
}

- (void)generateRootView {
  addView(self.view, self.questionTitleView);
  addView(self.view, self.tableview);
  
  [self.questionTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
  }];
  
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.questionTitleView.mas_bottom).with.inset(5);
    make.left.right.bottom.equalTo(self.view);
  }];
}

- (QMUITableView *)tableview {
  if (!_tableview) {
    _tableview = [QMUITableView new];
    _tableview.estimatedRowHeight = 10;
    _tableview.qmui_cacheCellHeightByKeyAutomatically = YES;
    [_tableview registerClass:QuestionAnsDetailCell.class
       forCellReuseIdentifier:QUESTIONANSDETAILCELL];
    [_tableview registerClass:QuestionAnsTitleCell.class
       forCellReuseIdentifier:QUESTIONANSTITLECELL];
    _tableview.delegate = self;
    _tableview.dataSource = self;
  }
  return _tableview;
}

- (QuestionDetailTitleView *)questionTitleView {
  if (!_questionTitleView) {
    _questionTitleView = [QuestionDetailTitleView new];
    _questionTitleView.backgroundColor = UIColorWhite;
  }
  return _questionTitleView;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) return 1;
  return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    QuestionAnsTitleCell *qatCell =
    [tableView dequeueReusableCellWithIdentifier:QUESTIONANSTITLECELL forIndexPath:indexPath];
    return qatCell;
  }
  QuestionAnsDetailCell *qadCell =
  [tableView dequeueReusableCellWithIdentifier:QUESTIONANSDETAILCELL forIndexPath:indexPath];
  return qadCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
