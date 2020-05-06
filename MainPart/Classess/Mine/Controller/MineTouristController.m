//
//  MineTouristController.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineTouristController.h"
#import "LogList.h"
#import "MarkUtils.h"
#import "MineTouristHeaderView.h"
#import "NSDictionary+LoadJson.h"
#import "RepertoireCell.h"
#import <SJAttributesFactory.h>
#define REPERTOIRECELL @"repertoirecell"
#define imgList @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=c689c6e6b3ea4aa16719a5dad5b93d36&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%2Fupload%2F19779%2F19778120.JPG",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=ded22c5d5202213bfdc3aaeb2f2ecf09&imgtype=0&src=http%3A%2F%2Fwww.bizhidaquan.com%2Fd%2Ffile%2F1%2F1159829.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513024&di=829f7b9b0ba4222a9bab2282e2b239bd&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201310%2F19%2F235356fyjkkugokokczyo0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=557632a98119862074f6306c6b269a9d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2017-10-13%2F59e0270c6ba4e.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=8db59485be71f14b5a70286128d1aec1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513023&di=4d4057e96f0b47cb8cb04575ba744ef1&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F1%2F53a15a1343174.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783660279&di=3c9f7da2c66bd25d350e03656e746696&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2155983538%2C3860699715%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588783513022&di=f8308055cabe18057cb07d55193f547f&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201408%2F05%2F222353wu5y5mzv6mprxvhn.jpg"]
#define briefList @[@"have fun",@"be happy",@"i'm back",@"weclome me! The new world!",@"Don't let your emotions override your judgement.",@"I will go out of this world the same way i came in, alone and nothing."]

@interface MineTouristController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) MineTouristHeaderView *headerView;
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *logList;
@end

@implementation MineTouristController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  NSDictionary *dict = [NSDictionary readLocalFileWithName:@"LogModelListJSON"];
  self.logList = [[[LogList alloc] initWithDictionary:dict].log mutableCopy];
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
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  [self navBarAlp];
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableHeaderView = self.headerView;
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.estimatedRowHeight = 100;
    _tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
    [_tableView registerClass:RepertoireCell.class forCellReuseIdentifier:REPERTOIRECELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (MineTouristHeaderView *)headerView {
  if (!_headerView) {
    _headerView = [[MineTouristHeaderView alloc]
                   initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT * 2 / 5)];
  }
  return _headerView;
}

- (UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"check_selected");
        make.alignment = SJUTVerticalAlignmentCenter;
      });
      make.append(@"\t shadowburn");
    }];
    _titleLabel.attributedText = str;
  }
  return _titleLabel;
}
#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.logList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return -1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @(((Log *)self.logList[indexPath.row]).imageList.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RepertoireCell *rpCell =
  [tableView dequeueReusableCellWithIdentifier:REPERTOIRECELL forIndexPath:indexPath];
  [rpCell loadData:self.logList[indexPath.row]];
  return rpCell;
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.headerView scrollViewDidScroll:scrollView.contentOffset];
  __weak __typeof(self) weakSelf = self;
  if (scrollView.contentOffset.y >= NavigationContentTop) {
    [UIView transitionWithView:self.titleView.titleLabel
                      duration:0.5
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{ weakSelf.navigationItem.titleView = weakSelf.titleLabel; }
                    completion:nil];
  } else {
    [UIView transitionWithView:self.titleView.titleLabel
                      duration:0.5
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{ weakSelf.navigationItem.titleView = [UILabel new]; }
                    completion:nil];
  }
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
  return @"MineTouristController";
}
@end
