//
//  ListController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ListController.h"
#import "BannerView.h"
#import "BannerViewSpot.h"
#import "MarkUtils.h"
#import "SceneController.h"
#import "SpotCell.h"
#import "SpotFoldCell.h"
#import "SpotHeader.h"

#define SPOTCELL @"spotcell"
#define SPOTFOLDCELL @"spotfoldcell"
#define BANNERHEIGHT DEVICE_HEIGHT / 5
#define FifthHeight UIScreen.mainScreen.bounds.size.height / 5
#define ForthHeight UIScreen.mainScreen.bounds.size.height / 4
#define imgList @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=c689c6e6b3ea4aa16719a5dad5b93d36&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%2Fupload%2F19779%2F19778120.JPG",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=ded22c5d5202213bfdc3aaeb2f2ecf09&imgtype=0&src=http%3A%2F%2Fwww.bizhidaquan.com%2Fd%2Ffile%2F1%2F1159829.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=829f7b9b0ba4222a9bab2282e2b239bd&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201310%2F19%2F235356fyjkkugokokczyo0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=557632a98119862074f6306c6b269a9d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2017-10-13%2F59e0270c6ba4e.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=8db59485be71f14b5a70286128d1aec1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=4d4057e96f0b47cb8cb04575ba744ef1&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F1%2F53a15a1343174.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783660279&di=3c9f7da2c66bd25d350e03656e746696&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2155983538%2C3860699715%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513022&di=f8308055cabe18057cb07d55193f547f&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201408%2F05%2F222353wu5y5mzv6mprxvhn.jpg"]
@interface ListController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, QMUISearchControllerDelegate> {
  CGFloat curAlpha;
}
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) NSArray *bannerImageList;
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellHs;
@property (nonatomic, strong) QMUISearchController *mySearchController;
@property (nonatomic, strong) NSArray *searchResultList;
@property (nonatomic, strong) NSArray *spotList;
@end

@implementation ListController

- (void)didInitialize {
  [super didInitialize];
  self.bannerImageList = @[ @"navigationbar_background", @"navigationbar_background" ];
  self.searchResultList = @[ @"xxx", @"bbb", @"ccc" ];
#ifdef Test_Hotel
  [self generateSpotList];
#endif
  curAlpha = 0;
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
  //  self.definesPresentationContext = YES;
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
  //  self.mySearchController.hidesNavigationBarDuringPresentation = false;
  //  self.navigationItem.leftBarButtonItem = NavLeftItemMake(self.mySearchController.searchBar);
  //  self.navigationItem.leftItemsSupplementBackButton = YES;
  //  self.definesPresentationContext = NO;
  //  self.title = @"<##>";
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.tableView == tableView) {
    return self.spotList.count;
  } else {
    return self.searchResultList.count;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (self.tableView == tableView) {
    if (section == 0) {
      SpotCell *sCell =
      [tableView dequeueReusableCellWithIdentifier:SPOTCELL forIndexPath:indexPath];
      NSDictionary *dict = self.spotList[indexPath.row];
      [sCell reloadData:dict];
      return sCell;
    }
  } else {
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
      cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                               withStyle:UITableViewCellStyleSubtitle
                                         reuseIdentifier:@"cell1"];
    }
    cell.textLabel.text = self.searchResultList[indexPath.row];
    return cell;
  }
  //    if (self.tableView == tableView) {
  //      SpotFoldCell *cell = [SpotFoldCell testCellWithTableView:tableView];
  //      return cell;
  //    }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  SceneController *sCon = [SceneController new];
  [self.navigationController pushViewController:sCon animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  SpotHeader *header =
  [[SpotHeader alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 15)];
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (self.tableView == tableView) { return DEVICE_HEIGHT / 15; }
  return 0;
}

//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
// forRowAtIndexPath:(NSIndexPath *)indexPath {
//  if (self.tableView == tableView) {
//    SpotFoldCell *cellT = (SpotFoldCell *)cell;
//    cellT.animateTimeAry = @[ @0.5, @0.3 ];
//    cellT.number = indexPath.row;
//    [cellT setBGColor];
//    if ([_cellHs[indexPath.row] floatValue] == [SpotFoldCell cellOpenH]) {
//      [cellT startFoldAnimated:NO foldType:FoldTypeOpen];
//    } else {
//      [cellT startFoldAnimated:NO foldType:FoldTypeClose];
//    }
//  }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.tableView == tableView) {
    //    return [_cellHs[indexPath.row] floatValue];
    return UITableViewAutomaticDimension;
  }
  return 44;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.tableView != scrollView) return;
  CGPoint point = scrollView.contentOffset;
  //  [self.navigationController.navigationBar.qmui_backgroundView
  //   setAlpha:point.y / NavigationContentTop];
}

//#pragma mark - UISearchBar Delegate
//- (void)searchController:(QMUISearchController *)searchController
// updateResultsForSearchString:(NSString *)searchString {
//  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:15];
//  [self.mySearchController.tableView reloadData];
//  //  self.collectionview.hidden = YES;
//}
//
//- (void)willDismissSearchController:(QMUISearchController *)searchController {
//  //  self.tableview.hidden = YES;
//  //  self.collectionview.hidden = NO;
//  //  [self.navigationController.navigationBar.qmui_backgroundView setAlpha:curAlpha];
//}
//
//- (void)willPresentSearchController:(QMUISearchController *)searchController {
//  //  curAlpha = self.navigationController.navigationBar.qmui_backgroundView.alpha;
//  //  [self.navigationController.navigationBar.qmui_backgroundView setAlpha:1];
//}
//
//- (void)didPresentSearchController:(QMUISearchController *)searchController {
//  //  [self.navigationController.navigationBar.qmui_backgroundView setAlpha:1];
//}

#pragma mark - GenerateRootViewDelegate

- (void)generateRootView {
  self.mySearchController = [[QMUISearchController alloc] initWithContentsViewController:self];
  self.mySearchController.hidesNavigationBarDuringPresentation = false;
  self.mySearchController.searchBar.qmui_usedAsTableHeaderView = YES;
  self.mySearchController.searchResultsDelegate = self;
  self.mySearchController.tableView.sectionFooterHeight = 0;
  self.mySearchController.tableView.sectionHeaderHeight = 0;
  self.mySearchController.tableView.tableHeaderView =
  [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, NavigationContentTop)];
  [self.mySearchController.tableView registerClass:QMUITableViewCell.class
                            forCellReuseIdentifier:@"cell"];
  self.mySearchController.tableView.estimatedRowHeight = 44;
  self.tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = false;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.estimatedRowHeight = cellCloseH;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  [self.tableView registerClass:SpotCell.class forCellReuseIdentifier:SPOTCELL];
  self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  BannerViewSpot *banner =
  [[BannerViewSpot alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, BANNERHEIGHT + SPACE)];
  banner.datas = self.bannerImageList;
  [banner loadData];
  self.tableView.tableHeaderView = banner;
  [self navBarAlp];
  addView(self.view, self.tableView);
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
  
  //  self.cellHs = [NSMutableArray array];
  //  for (int i = 0; i < 100; i++) {
  //    [self.cellHs addObject:[NSNumber numberWithFloat:[SpotFoldCell cellCloseH]]];
  //  }
}

#pragma mark - navigation bar alpha
- (void)navBarAlp {
  self.navigationAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
  self.navigationAnimator.scrollView = self.tableView;
  self.navigationAnimator.offsetYToStartAnimation = 0;
  self.navigationAnimator.distanceToStopAnimation = 88;
  
  self.navigationAnimator.backgroundImageBlock =
  ^UIImage *_Nonnull(QMUINavigationBarScrollingAnimator *_Nonnull animator, float progress) {
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

//- (UIColor *)navigationBarTintColor {
//  return self.navigationAnimator.tintColorBlock(self.navigationAnimator,
//                                                self.navigationAnimator.progress);
//}
//
//- (UIColor *)titleViewTintColor {
//  return [self navigationBarTintColor];
//}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
//转场效果
- (NSString *)customNavigationBarTransitionKey {
  return self.navigationAnimator.progress >= 1 ? nil : @"List";
}

- (void)generateSpotList {
  self.spotList = @[
    @{
      @"title" : @"九寨沟",
      @"favor" : @"99",
      @"recommond" : @"you can you up",
      @"numRank" : @"1"
    },
    @{
      @"title" : @"新气息",
      @"favor" : @"99",
      @"recommond" : @"you can you up1",
      @"numRank" : @"2"
    },
    @{ @"title" : @"九龙",
       @"favor" : @"99",
       @"recommond" : @"you can you up2",
       @"numRank" : @"3" },
    @{ @"title" : @"黄山",
       @"favor" : @"99",
       @"recommond" : @"you can you up3",
       @"numRank" : @"4" },
    @{ @"title" : @"仙山",
       @"favor" : @"99",
       @"recommond" : @"you can you up4",
       @"numRank" : @"5" },
    @{ @"title" : @"海沟",
       @"favor" : @"99",
       @"recommond" : @"you can you up5",
       @"numRank" : @"6" },
    @{ @"title" : @"仙台",
       @"favor" : @"99",
       @"recommond" : @"you can you up6",
       @"numRank" : @"7" },
    @{ @"title" : @"天台",
       @"favor" : @"99",
       @"recommond" : @"you can you up7",
       @"numRank" : @"8" },
    @{ @"title" : @"巨擎",
       @"favor" : @"99",
       @"recommond" : @"you can you up8",
       @"numRank" : @"9" },
    @{
      @"title" : @"预料",
      @"favor" : @"99",
      @"recommond" : @"you can you up9",
      @"numRank" : @"10"
    }
  ];
}
@end
