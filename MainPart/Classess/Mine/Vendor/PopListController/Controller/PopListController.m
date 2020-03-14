//
//  PopListController.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PopListController.h"
#import "MarkUtils.h"

@interface PopListController () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) QMUITableView *tableView;
@end

@implementation PopListController

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

@end
