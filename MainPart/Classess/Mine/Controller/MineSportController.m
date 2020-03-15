//
//  MineSportController.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineSportController.h"
#import "HotelDevice.h"
#import "MarkUtils.h"
#import "MineSportDeviceCell.h"
#import "MineSportDeviceHeaderView.h"
#import "MineSportTitleCell.h"
#import "NSDictionary+LoadJson.h"
#import <JQCollectionViewAlignLayout.h>
#define MINESPORTDEVICECELL @"minesportdevicecell"
#define MINESPORTDEVICEHEADERVIEW @"minesportdeviceheaderview"
#define MINESPORTTITLECELL @"minesporttitlecell"
@interface MineSportController () <GenerateEntityDelegate, UICollectionViewDelegate,
UICollectionViewDataSource, JQCollectionViewAlignLayoutDelegate,
MineSportHeaderDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HotelDevice *hotelDevice;
@property (nonatomic, strong) NSArray<Device *> *deviceList;
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, weak) UIImageView *zoomView;
@end

@implementation MineSportController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  NSDictionary *dict = [NSDictionary readLocalFileWithName:@"MineSportModelListJSON"];
  self.hotelDevice = [[HotelDevice alloc] initWithDictionary:dict];
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
  //  self.title = @"健身";
}
#pragma mark - Lazy Init
- (UICollectionView *)collectionView {
  if (!_collectionView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    //    layout.itemSize = CGSizeMake(DEVICE_WIDTH / 3, DEVICE_WIDTH / 3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.footerReferenceSize = CGSizeMake(DEVICE_WIDTH, 0);
    _collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _collectionView.scrollEnabled = YES;
    _collectionView.bounces = YES;
    _collectionView.bouncesZoom = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = UIColor.qd_backgroundColor;
    _collectionView.showsVerticalScrollIndicator = false;
    [_collectionView registerClass:MineSportDeviceCell.class
        forCellWithReuseIdentifier:MINESPORTDEVICECELL];
    [_collectionView registerClass:MineSportDeviceHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:MINESPORTDEVICEHEADERVIEW];
    [_collectionView registerClass:UICollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"default"];
    [_collectionView registerClass:MineSportTitleCell.class
        forCellWithReuseIdentifier:MINESPORTTITLECELL];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (void)setHotelDevice:(HotelDevice *)hotelDevice {
  _hotelDevice = hotelDevice;
  self.deviceList = hotelDevice.device;
  [self.collectionView reloadData];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.collectionView);
  
  [self navBarAlp];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
    make.top.equalTo(self.view);
  }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGPoint point = scrollView.contentOffset;
  if (point.y < 0) {
    self.zoomView.frame = CGRectMake(point.y, point.y, DEVICE_WIDTH - 2 * point.y,
                                     220.0 / 414 * DEVICE_WIDTH - point.y);
  } else {
    self.zoomView.frame = CGRectMake(0, 0, DEVICE_WIDTH, 220.0 / 414 * DEVICE_WIDTH);
  }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  if (section == 0) return 1;
  return self.deviceList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 20);
  return CGSizeMake(DEVICE_WIDTH / 3, DEVICE_WIDTH / 3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  if (section == 0) return CGSizeMake(DEVICE_WIDTH, 220.0 / 414 * DEVICE_WIDTH);
  return CGSizeMake(DEVICE_WIDTH, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    MineSportDeviceHeaderView *header =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:MINESPORTDEVICEHEADERVIEW
                                              forIndexPath:indexPath];
    if (indexPath.section == 0) {
      header.model = self.hotelDevice;
      self.zoomView = header.sportImg;
    }
    return header;
  } else {
    UICollectionReusableView *view =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:@"default"
                                              forIndexPath:indexPath];
    return view;
  }
  return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    MineSportTitleCell *mstCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MINESPORTTITLECELL
                                              forIndexPath:indexPath];
    return mstCell;
  }
  MineSportDeviceCell *msdCell =
  [collectionView dequeueReusableCellWithReuseIdentifier:MINESPORTDEVICECELL
                                            forIndexPath:indexPath];
  msdCell.device = self.deviceList[indexPath.row];
  return msdCell;
}

#pragma mark - navigation bar alpha
- (void)navBarAlp {
  self.navigationAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
  self.navigationAnimator.scrollView = self.collectionView;
  self.navigationAnimator.offsetYToStartAnimation = 0;
  self.navigationAnimator.distanceToStopAnimation = 220.0 / 414 * DEVICE_WIDTH;
  
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
  return @"MineSportController";
}
@end
