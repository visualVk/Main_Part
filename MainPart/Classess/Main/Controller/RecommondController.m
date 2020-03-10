//
//  RecommondController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/18.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "RecommondController.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "QiCardView.h"
#import "RecCell.h"
#import "RecToolBar.h"
#define RECCELL @"reccell"

@interface RecommondController () <GenerateEntityDelegate, QiCardViewDelegate,
QiCardViewDataSource> {
  BOOL flag;
  NSInteger curIndex;
}
@property (nonatomic, strong) NSArray *tagList;
@property (nonatomic, strong) QiCardView *cardView;
@property (nonatomic, strong) RecToolBar *recToolBar;
@end

@implementation RecommondController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.tagList = @[ @"价格实惠", @"交通方便", @"服务好", @"待人友善", @"环境舒适" ];
  self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.45];
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
  self.title = @"";
}

#pragma mark - GenerateRoowView Delegate
- (void)generateRootView {
  [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view).with.inset(20);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.inset(20);
    //    make.height.mas_equalTo(DEVICE_HEIGHT * 3 / 5);
    make.bottom.equalTo(self.recToolBar.mas_top);
  }];
  
  [self.recToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.inset(30);
    make.height.mas_equalTo(DEVICE_HEIGHT / 12);
  }];
}

#pragma mark - Lazy Init
- (QiCardView *)cardView {
  if (!_cardView) {
    _cardView =
    [[QiCardView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH - 40, DEVICE_HEIGHT / 2)];
    _cardView.center = CGPointMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT / 2);
    _cardView.dataSource = self;
    _cardView.delegate = self;
    _cardView.visibleCount = 4;
    _cardView.lineSpacing = 15.0;
    _cardView.interitemSpacing = 10.0;
    _cardView.maxAngle = 10.0;
    _cardView.isAlpha = YES;
    _cardView.maxRemoveDistance = 100.0;
    _cardView.layer.cornerRadius = 10.0;
    [_cardView registerClass:RecCell.class forCellReuseIdentifier:RECCELL];
    [self.view addSubview:_cardView];
  }
  return _cardView;
}

- (RecToolBar *)recToolBar {
  if (!_recToolBar) {
    _recToolBar = [RecToolBar new];
    _recToolBar.detailBlock = ^(NSInteger tag) {
      
    };
    _recToolBar.discountBlock = ^(NSInteger tag) {
      
    };
    _recToolBar.favorBlock = ^(NSInteger tag) {
      
    };
    [self.view addSubview:_recToolBar];
  }
  return _recToolBar;
}

#pragma mark - QiCardViewDataSource

- (RecCell *)cardView:(QiCardView *)cardView cellForRowAtIndex:(NSInteger)index {
  
  RecCell *cell = [cardView dequeueReusableCellWithIdentifier:RECCELL];
  //    cell.cellData = _cellItems[index];
  cell.layer.cornerRadius = 10.0;
  cell.layer.masksToBounds = YES;
  //    cell.buttonClicked = ^(UIButton *sender) {
  //        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL
  //        URLWithString:self.cellItems[index].url]]; [self presentViewController:safariVC
  //        animated:YES completion:nil];
  //    };
  return cell;
}

- (NSInteger)numberOfCountInCardView:(UITableView *)cardView {
  return 3;
}

#pragma mark - QiCardViewDelegate

- (void)cardView:(QiCardView *)cardView
didRemoveLastCell:(QiCardViewCell *)cell
   forRowAtIndex:(NSInteger)index {
  [cardView reloadDataAnimated:YES];
}

- (void)cardView:(QiCardView *)cardView
   didRemoveCell:(QiCardViewCell *)cell
   forRowAtIndex:(NSInteger)index {
  NSLog(@"didRemoveCell forRowAtIndex = %ld", index);
}

- (void)cardView:(QiCardView *)cardView
  didDisplayCell:(QiCardViewCell *)cell
   forRowAtIndex:(NSInteger)index {
  
  NSLog(@"didDisplayCell forRowAtIndex = %ld", index);
  
  NSLog(@"currentFirstIndex = %ld", cardView.currentFirstIndex);
  NSLog(@"%ld", index);
  curIndex = index;
}

- (void)cardView:(QiCardView *)cardView
     didMoveCell:(QiCardViewCell *)cell
    forMovePoint:(CGPoint)point {
  //    NSLog(@"move point = %@", NSStringFromCGPoint(point));
}
@end
