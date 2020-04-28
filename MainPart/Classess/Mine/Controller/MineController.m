//
//  MineController.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineController.h"
#import "LevelSectionHeaderView.h"
#import "MarkUtils.h"
#import "MineActivityBannerCell.h"
#import "MineHeaderView.h"
#import "MineProfileController.h"
#import "NSObject+BlockSEL.h"
#import "OrderCell.h"
#import "PowerCell.h"
#import "ProfileStatusCell.h"
#import "ToolCell.h"
#define POWERCELL @"powercell"
#define ORDERCELL @"ordercell"
#define TOOLCELL @"toolcell"
#define STATUESCELL @"statuscell"
#define MINEACTIVITYCELL @"mineactivitycell"
#define MIENACITIVITYHEIGHT
#define ORDERCELLHEIGHT DEVICE_HEIGHT / 8
#define TOOLCELLHEIGHT DEVICE_HEIGHT / 4
#define STATUSHEIGHT DEVICE_HEIGHT / 10

@interface MineController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource> {
  BOOL _didScolled;
  BOOL isOverStep;
  BOOL isChecked;
}
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) MineHeaderView *mineHeader;
@property (nonatomic, strong) NSArray *powerList;
@end

@implementation MineController
- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.powerList = @[
    @{ @"image" : @"mine_flash",
       @"title" : @"快速入住" },
    @{ @"image" : @"mine_send",
       @"title" : @"免费寄送行李" },
    @{ @"image" : @"mine_discount",
       @"title" : @"享受9折优惠" },
    @{ @"image" : @"mine_free",
       @"title" : @"免收中介费" },
    @{ @"image" : @"mine_super",
       @"title" : @"享受会员活动" },
    @{ @"image" : @"mine_travel_any",
       @"title" : @"旅行分析" },
    @{ @"image" : @"mine_travel",
       @"title" : @"年度旅行总结" },
    @{ @"image" : @"mine_live_any",
       @"title" : @"住宿分析" },
    @{ @"image" : @"mine_home",
       @"title" : @"年度住宿总结" },
    @{ @"image" : @"mine_id_scan",
       @"title" : @"身份免检" }
  ];
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
  self.title = @"我的";
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithImage:UIImageMake(@"mine_profile")
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(go2MineInfo)];
}

- (void)go2MineInfo {
  MineProfileController *mpCon = [MineProfileController new];
  [self.navigationController pushViewController:mpCon animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGPoint point = scrollView.contentOffset;
  if (point.y > NavigationContentTop) {
    if (!_didScolled) {
      scrollView.contentInset = UIEdgeInsetsMake(NavigationContentTop, 0, 0, 0);
      _didScolled = true;
    }
  } else {
    if (_didScolled) {
      scrollView.contentInset = UIEdgeInsetsZero;
      _didScolled = false;
    }
    if (point.y < 0) {
      self.mineHeader.imgBackground.frame =
      CGRectMake(point.y, point.y, DEVICE_WIDTH - 2 * point.y, DEVICE_HEIGHT / 3.5 - point.y);
      //      [self.mineHeader layoutIfNeeded];
      isOverStep = true;
    } else {
      if (isOverStep) {
        self.mineHeader.imgBackground.frame = self.mineHeader.frame;
        isOverStep = false;
      }
    }
  }
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  //  UIEdgeInsets padding = UIEdgeInsetsMake(-DEVICE_HEIGHT / 64, 0, 0, 0);
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
  [self navBarAlp];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _tableView.backgroundColor = UIColor.qd_customBackgroundColor;
    self.mineHeader =
    [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 3.5)];
    self.mineHeader.imgBackground.frame = self.mineHeader.frame;
    _tableView.tableHeaderView = self.mineHeader;
    //    _tableView.tableHeaderView.clipsToBounds = YES;
    [_tableView registerClass:OrderCell.class forCellReuseIdentifier:ORDERCELL];
    [_tableView registerClass:ToolCell.class forCellReuseIdentifier:TOOLCELL];
    [_tableView registerClass:ProfileStatusCell.class forCellReuseIdentifier:STATUESCELL];
    [_tableView registerClass:MineActivityBannerCell.class forCellReuseIdentifier:MINEACTIVITYCELL];
    [_tableView registerClass:PowerCell.class forCellReuseIdentifier:POWERCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 2) { return 3; }
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 0) return ORDERCELLHEIGHT;
  if (section == 1) return TOOLCELLHEIGHT;
  if (section == 2) {
    if (row == 0) { return STATUSHEIGHT; }
    if (row == 1) return STATUSHEIGHT;
    if (row == 2) return self.powerList.count / 2 * ORDERCELLHEIGHT;
  }
  //  if (section == 3) { return STATUSHEIGHT; }
  //  if (section == 4) { return self.powerList.count / 2 * ORDERCELLHEIGHT; }
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 0) {
    OrderCell *oCell =
    [tableView dequeueReusableCellWithIdentifier:ORDERCELL forIndexPath:indexPath];
    return oCell;
  }
  if (section == 1) {
    ToolCell *tCell = [tableView dequeueReusableCellWithIdentifier:TOOLCELL forIndexPath:indexPath];
    return tCell;
  }
  if (section == 2) {
    if (row == 0) {
      ProfileStatusCell *psCell =
      [tableView dequeueReusableCellWithIdentifier:STATUESCELL forIndexPath:indexPath];
      return psCell;
    }
    if (row == 1) {
      MineActivityBannerCell *mabCell =
      [tableView dequeueReusableCellWithIdentifier:MINEACTIVITYCELL forIndexPath:indexPath];
      return mabCell;
    }
    if (row == 2) {
      PowerCell *pCell =
      [tableView dequeueReusableCellWithIdentifier:POWERCELL forIndexPath:indexPath];
      pCell.datas = self.powerList;
      [pCell.powerView reloadData];
      return pCell;
    }
  }
  //  if (section == 3) {
  //    MineActivityBannerCell *mabCell =
  //    [tableView dequeueReusableCellWithIdentifier:MINEACTIVITYCELL forIndexPath:indexPath];
  //    return mabCell;
  //  }
  //  if (section == 4) {
  //    PowerCell *pCell =
  //    [tableView dequeueReusableCellWithIdentifier:POWERCELL forIndexPath:indexPath];
  //    pCell.datas = self.powerList;
  //    [pCell.powerView reloadData];
  //    return pCell;
  //  }
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 2) { return DEVICE_HEIGHT / 4; }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 2) {
    LevelSectionHeaderView *sectionHeader = [LevelSectionHeaderView new];
    return sectionHeader;
  }
  return nil;
}

#pragma mark - navigation bar alpha
- (void)navBarAlp {
  __weak __typeof(self) weakSelf = self;
  self.navigationAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
  self.navigationAnimator.scrollView = self.tableView;
  self.navigationAnimator.offsetYToStartAnimation = 0;
  self.navigationAnimator.distanceToStopAnimation = 88;
  
  self.navigationAnimator.backgroundImageBlock =
  ^UIImage *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    [weakSelf.titleView setAlpha:progress];
    return [NavBarBackgroundImage qmui_imageWithAlpha:progress];
  };
  self.navigationAnimator.shadowImageBlock =
  ^UIImage *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    return [NavBarShadowImage qmui_imageWithAlpha:progress];
  };
  /**
   当背景非蓝色时启用
   */
  self.navigationAnimator.tintColorBlock =
  ^UIColor *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    return [UIColor qmui_colorFromColor:UIColor.qd_backgroundColor
                                toColor:NavBarTintColor
                               progress:progress];
  };
  self.navigationAnimator.titleViewTintColorBlock = self.navigationAnimator.tintColorBlock;
  self.navigationAnimator.statusbarStyleBlock =
  ^UIStatusBarStyle(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
    //    return progress < .25 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    return UIStatusBarStyleLightContent;
  };
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  if (self.navigationAnimator) {
    return self.navigationAnimator.statusbarStyleBlock(self.navigationAnimator,
                                                       self.navigationAnimator.progress);
  }
  return [super preferredStatusBarStyle];
}

#pragma mark - <QMUINavigationControllerAppearanceDelegate>

- (UIImage *)navigationBarBackgroundImage {
  return self.navigationAnimator.backgroundImageBlock(self.navigationAnimator,
                                                      self.navigationAnimator.progress);
}

- (UIImage *)navigationBarShadowImage {
  return self.navigationAnimator.shadowImageBlock(self.navigationAnimator,
                                                  self.navigationAnimator.progress);
}

- (UIColor *)navigationBarTintColor {
  return self.navigationAnimator.tintColorBlock(self.navigationAnimator,
                                                self.navigationAnimator.progress);
}

- (UIColor *)titleViewTintColor {
  return [self navigationBarTintColor];
}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
//转场效果
- (NSString *)customNavigationBarTransitionKey {
  return @"MineController";
}
@end
