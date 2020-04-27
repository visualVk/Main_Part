//
//  MainFoodController.m
//  MainPart
//
//  Created by blacksky on 2020/4/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainFoodController.h"
#import "MainFoodCell.h"
#import "MarkUtils.h"
#define MAINFOODCELL @"MainFoodCell"

@interface MainFoodController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) NSArray *imgList;
@end

@implementation MainFoodController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  [self generateImgList];
#endif
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
  self.title = @"附近小吃";
}

- (void)generateImgList {
  self.imgList = @[
    @"http://img4.imgtn.bdimg.com/it/u=2597470571,4105445397&fm=26&gp=0.jpg",
    @"http://img4.imgtn.bdimg.com/it/u=1194064447,3680178733&fm=26&gp=0.jpg",
    @"http://img1.imgtn.bdimg.com/it/u=2686742867,1757251788&fm=26&gp=0.jpg",
    @"http://n.sinaimg.cn/sinacn10/244/w640h404/20180402/4247-fyssmme6064947.jpg",
    @"http://img1.imgtn.bdimg.com/it/u=3645470627,3687906852&fm=26&gp=0.jpg",
    @"http://img4.imgtn.bdimg.com/it/u=3084729598,3159246742&fm=26&gp=0.jpg",
    @"http://dealer0.autoimg.cn/dl/122602/newsimg/130512469295591733.jpg"
  ];
}

- (void)generateRootView {
  self.tableview = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.tableview.delegate = self;
  self.tableview.dataSource = self;
  [self.tableview registerClass:MainFoodCell.class forCellReuseIdentifier:MAINFOODCELL];
  
  addView(self.view, self.tableview);
  
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.bottom.equalTo(self.view);
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  MainFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:MAINFOODCELL];
  [cell setModel:@{
    @"food" : self.imgList[indexPath.row],
    @"title" : [NSString stringWithFormat:@"店铺%li", indexPath.row]
  }];
  return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.imgList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
