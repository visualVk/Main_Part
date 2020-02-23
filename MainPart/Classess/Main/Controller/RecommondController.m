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
#import "SpotRotationView.h"
#import <JHChainableAnimations/JHChainableAnimations.h>

@interface RecommondController () <UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, GenerateEntityDelegate> {
  BOOL flag;
}
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) QMUICollectionViewPagingLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *tagList;
@property (nonatomic, strong) UIView *pepView;
@end

@implementation RecommondController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.tagList = @[ @"价格实惠", @"交通方便", @"服务好", @"待人友善", @"环境舒适" ];
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

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 10 + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row > 9) {
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"refreshcell"
                                              forIndexPath:indexPath];
    cell.backgroundColor = UIColor.qmui_randomColor;
    return cell;
  }
  SpotRotationView *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  cell.datas = self.tagList;
  [cell loadData];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(CGRectGetWidth(collectionView.bounds) -
                    UIEdgeInsetsGetHorizontalValue(self.collectionViewLayout.sectionInset) -
                    UIEdgeInsetsGetHorizontalValue(self.collectionview.qmui_contentInset),
                    CGRectGetHeight(collectionView.bounds) -
                    UIEdgeInsetsGetVerticalValue(self.collectionViewLayout.sectionInset) -
                    UIEdgeInsetsGetVerticalValue(self.collectionview.qmui_contentInset));
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row < 10) {
    SpotRotationView *sCell = (SpotRotationView *)cell;
    [sCell stateInit];
  }
}

#pragma mark - GenerateRoowView Delegate
- (void)generateRootView {
  //  self.loadView.backgroundColor = UIColor.qmui_randomColor;
  addView(self.view, self.collectionview);
  //  addView(self.collectionview, self.pepView);
  
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(0.5 * SPACE);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0.5 * SPACE);
    make.right.equalTo(self.view).offset(-0.5 * SPACE);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0.5 * SPACE);
  }];
  
  //  self.pepView.frame = CGRectMake(3500, 200, 50, 50);
}

#pragma mark - Lazy init UICollection View
- (UICollectionView *)collectionview {
  if (!_collectionview) {
    self.collectionViewLayout = [[QMUICollectionViewPagingLayout alloc]
                                 initWithStyle:QMUICollectionViewPagingLayoutStyleRotation];
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
    self.collectionViewLayout.minimumLineSpacing = 0;
    self.collectionViewLayout.minimumInteritemSpacing = 0;
    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:self.collectionViewLayout];
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    //    [_collectionview registerClass:UICollectionViewCell.class
    //    forCellWithReuseIdentifier:@"cell"];
    [_collectionview registerClass:UICollectionViewCell.class
        forCellWithReuseIdentifier:@"refreshcell"];
    [_collectionview registerClass:SpotRotationView.class forCellWithReuseIdentifier:@"cell"];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
  }
  return _collectionview;
}

- (UIView *)pepView {
  if (!_pepView) {
    _pepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _pepView.backgroundColor = UIColor.qmui_randomColor;
  }
  return _pepView;
}
#pragma mark - UIScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  QMUILogInfo(@"recommond controller", @"scrollview,x=%f,y=%f", scrollView.contentOffset.x,
              scrollView.contentOffset.y);
}

@end
