//
//  PopListController.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PopListController.h"
#import "AppDelegate.h"
#import "MarkUtils.h"
#import "PopListItemCell.h"
#import "PopListSectionView.h"
#define POPLISTITEMCELL @"poplistitemcell"

@interface PopListController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource> {
  CGPoint contentOffset;
}
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) UIView *dimingView;
@property (nonatomic, strong) UIView *container;
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
  //  self.title = @"<##>";
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:PopListItemCell.class forCellReuseIdentifier:POPLISTITEMCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.qd_backgroundColor;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (UIView *)dimingView {
  if (!_dimingView) {
    _dimingView = [UIView new];
    _dimingView.layer.masksToBounds = YES;
    _dimingView.backgroundColor = [UIColorBlack colorWithAlphaComponent:0.45];
    addView(_dimingView, self.tableView);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.equalTo(_dimingView);
    }];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopListView)];
    [_dimingView addGestureRecognizer:tap];
  }
  return _dimingView;
}

- (UIView *)bottomView {
  if (!_bottomView) {
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColorWhite colorWithAlphaComponent:0];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopListView)];
    [_bottomView addGestureRecognizer:tap];
  }
  return _bottomView;
}

- (UIView *)container {
  if (!_container) {
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    addView(_container, self.dimingView);
    addView(_container, self.bottomView);
    //    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.bottom.left.right.equalTo(_container);
    //    }];
    
    [self.dimingView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(_container);
      make.bottom.equalTo(self.bottomView.mas_top);
    }];
  }
  return _container;
}

- (void)setFoodList:(NSMutableArray *)foodList {
  _foodList = foodList;
  CGFloat emHeight = self.foodList.count > 6 ? 350 : (foodList.count + 1) * 50;
  [self.tableView
   mas_updateConstraints:^(MASConstraintMaker *make) { make.height.mas_equalTo(emHeight); }];
  
  [self.tableView setNeedsLayout];
  [self.tableView layoutIfNeeded];
  [self.tableView reloadData];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  contentOffset = scrollView.contentOffset;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.foodList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  PopListSectionView *plsHeader = [PopListSectionView new];
  __weak __typeof(self)weakSelf = self;
  plsHeader.popListClearBlock = ^{
    for (Food *food in weakSelf.foodList) {
      food.foodNum = 0;
    }
    if ([weakSelf.delegate respondsToSelector:@selector(foodNumberValueChanged:)]) {
      [weakSelf.delegate foodNumberValueChanged:0];
      [weakSelf.tableView performBatchUpdates:^{ [weakSelf.tableView reloadData]; }
                                   completion:^(BOOL finished) { [weakSelf.tableView setContentOffset:contentOffset]; }];
    }
  };
  return plsHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PopListItemCell *pliCell =
  [tableView dequeueReusableCellWithIdentifier:POPLISTITEMCELL forIndexPath:indexPath];
  pliCell.model = self.foodList[indexPath.row];
  __weak __typeof(self) weakSelf = self;
  pliCell.popItemClickBlock = ^(NSInteger num) {
    if ([weakSelf.delegate respondsToSelector:@selector(foodNumberValueChanged:)]) {
      [weakSelf.delegate foodNumberValueChanged:num];
      [weakSelf.tableView performBatchUpdates:^{ [weakSelf.tableView reloadData]; }
                                   completion:^(BOOL finished) { [weakSelf.tableView setContentOffset:contentOffset]; }];
    }
  };
  return pliCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)showPopListView {
  AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
  [self.tableView pop_removeAllAnimations];
  [self.dimingView pop_removeAllAnimations];
  POPBasicAnimation *popAnimate =
  [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
  popAnimate.fromValue = @((self.foodList.count + 1) * 50);
  [self.tableView.layer pop_addAnimation:popAnimate forKey:@"popanimate"];
  
  POPBasicAnimation *opacityAnimate =
  [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  opacityAnimate.fromValue = @(0);
  opacityAnimate.toValue = @(1);
  opacityAnimate.duration = 0.5;
  [self.dimingView.layer pop_addAnimation:opacityAnimate forKey:@"opacityanimate"];
  
  [delegate.window addSubview:self.container];
}

- (void)hidePopListView {
  [self.tableView pop_removeAllAnimations];
  [self.dimingView pop_removeAllAnimations];
  
  POPBasicAnimation *opacityAnimate =
  [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  opacityAnimate.fromValue = @(1);
  opacityAnimate.toValue = @(0);
  [self.dimingView.layer pop_addAnimation:opacityAnimate forKey:@"opacityanimate"];
  __weak __typeof(self) weakSelf = self;
  opacityAnimate.completionBlock = ^(POPAnimation *anim, BOOL finished) {
    [weakSelf.container removeFromSuperview];
    [weakSelf.dimingView pop_removeAllAnimations];
  };
}
@end
