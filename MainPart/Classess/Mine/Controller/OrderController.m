//
//  OrderController.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderController.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "MarkUtils.h"
#import "MineOrderCell.h"
#import <HMSegmentedControl.h>
#define MINEORDERCELL @"mineordercell"

@interface OrderController () <QMUITableViewDelegate, QMUITableViewDataSource,
GenerateEntityDelegate>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) HMSegmentedControl *segCon;
@property (nonatomic, assign) NSInteger *selectedIndex;
@property (nonatomic, strong) GHDropMenu *dropMenu;
@end

@implementation OrderController

- (instancetype)initWithOrderType:(OrderControllerType)type {
  if (self = [super init]) {
    [self didInitialize];
    switch (type) {
      case AllOrder:
        self.selectedIndex = 0;
        break;
      case NonPaymentOrder:
        self.selectedIndex = 1;
        break;
      case FutureOrder:
        self.selectedIndex = 2;
        break;
      case RemarkOrder:
        self.selectedIndex = 3;
        break;
      default:
        break;
    }
  }
  return self;
}

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
  self.title = @"订单";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.dropMenu);
  addView(self.view, self.segCon);
  addView(self.view, self.tableView);
  
  [self.segCon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.dropMenu.mas_bottom);
    make.left.right.equalTo(self.view);
    make.height.mas_equalTo(DEVICE_HEIGHT / 20);
  }];
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.segCon.mas_bottom);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:MineOrderCell.class forCellReuseIdentifier:MINEORDERCELL];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.qd_customBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (HMSegmentedControl *)segCon {
  if (!_segCon) {
    _segCon = [[HMSegmentedControl alloc]
               initWithSectionTitles:@[ @"全部订单", @"待付款", @"为出行", @"待评价" ]];
    _segCon.selectedSegmentIndex = self.selectedIndex;
    _segCon.selectedTitleTextAttributes =
    @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]};
    _segCon.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    _segCon.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segCon.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCon.selectionIndicatorHeight = 3.0f;
    _segCon.backgroundColor = UIColor.qd_backgroundColor;
    _segCon.titleTextAttributes = @{
      NSForegroundColorAttributeName : UIColor.qd_titleTextColor,
      NSFontAttributeName : UIFontMake(14)
    };
    _segCon.indexChangeBlock =
    ^(NSInteger index) { QMUILogInfo(@"order controller", @"change:%li", index); };
  }
  return _segCon;
}
- (GHDropMenu *)dropMenu {
  if (!_dropMenu) {
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc] init];
    configuration.recordSeleted = NO;
    configuration.titles = [configuration creaDropMenuData];
    
    __weak __typeof(self) weakSelf = self;
    _dropMenu = [GHDropMenu creatDropMenuWithConfiguration:configuration
                                                     frame:CGRectMake(0, kGHSafeAreaTopHeight, kGHScreenWidth, 44)
                                        dropMenuTitleBlock:^(GHDropMenuModel *_Nonnull dropMenuModel) {
      
    }
                                     dropMenuTagArrayBlock:^(NSArray *_Nonnull tagArray) { [weakSelf getStrWith:tagArray]; }];
    _dropMenu.titleSeletedImageName = @"up_normal";
    _dropMenu.titleNormalImageName = @"down_normal";
    _dropMenu.delegate = self;
    _dropMenu.durationTime = 0.5;
  }
  return _dropMenu;
}
#pragma mark - DropMenuDelegate
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
  self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@", dropMenuTitleModel.title];
}
- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
  [self getStrWith:tagArray];
}
- (void)getStrWith:(NSArray *)tagArray {
  NSMutableString *string = [NSMutableString string];
  if (tagArray.count) {
    for (GHDropMenuModel *dropMenuTagModel in tagArray) {
      if (dropMenuTagModel.tagSeleted) {
        if (dropMenuTagModel.tagName.length) {
          [string appendFormat:@"%@", dropMenuTagModel.tagName];
        }
      }
      if (dropMenuTagModel.maxPrice.length) {
        [string appendFormat:@"最大价格%@", dropMenuTagModel.maxPrice];
      }
      if (dropMenuTagModel.minPrice.length) {
        [string appendFormat:@"最小价格%@", dropMenuTagModel.minPrice];
      }
      if (dropMenuTagModel.singleInput.length) {
        [string appendFormat:@"%@", dropMenuTagModel.singleInput];
      }
    }
  }
  //  self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@", string];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineOrderCell *moCell =
  [tableView dequeueReusableCellWithIdentifier:MINEORDERCELL forIndexPath:indexPath];
  [moCell loadData];
  return moCell;
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