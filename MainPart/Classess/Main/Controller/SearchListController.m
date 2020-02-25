//
//  SearchListController.m
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SearchListController.h"
#define ITEMCELLHEIGHT DEVICE_HEIGHT / 5;

@interface SearchListController () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUISearchController *mySearchController;
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) NSArray *hotelList;
@end

@implementation SearchListController

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
  self.title = @"<##>";
}

#pragma mark - GenerateRooViewDelegate
- (void)generateRootView {
  
  self.tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  
  self.navigationAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
  self.navigationAnimator.scrollView = self.tableView; // 指定要关联的 scrollView
  self.navigationAnimator.offsetYToStartAnimation =
  30;                                               // 设置滚动的起点，值即表示在默认停靠的位置往下滚动多少距离后即触发动画，默认是 0
  self.navigationAnimator.distanceToStopAnimation = 64; // 设置从起点开始滚动多长的距离达到终点
}

#pragma mark - QMUITablviewDataSource,QMUITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return ITEMCELLHEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
