//
//  BannerView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "BannerView.h"
#import "ImageAndLabelCell.h"
#import "ListController.h"
#import "SearchListController.h"

@interface BannerView () <UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) WMZBannerParam *param;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSArray *tabList;
@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.tabList = @[
      @{ @"image" : @"main_scene",
         @"title" : @"风景" },
      @{ @"image" : @"main_food",
         @"title" : @"吃喝" },
      @{ @"image" : @"main_play",
         @"title" : @"玩乐" },
      @{ @"image" : @"main_bed",
         @"title" : @"住宿" }
    ];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - generate root view
- (void)generateRootView {
  self.backgroundColor = UIColor.clearColor;
  self.layer.masksToBounds = false;
  self.clipsToBounds = false;
  self.param = BannerParam()
  .wFrameSet(CGRectMake(0, 0, BannerWitdh, BannerHeight / 4))
  .wDataSet([self getArray])
  .wRepeatSet(YES)
  .wAutoScrollSet(YES)
  .wAutoScrollSecondSet(3)
  .wEventClickSet(^(id anyID, NSInteger index) { NSLog(@"index:%li", index); })
  .wCanFingerSlidingSet(YES)
  .wBannerControlImageRadiusSet(0);
  self.banner = [[WMZBannerView alloc] initConfigureWithModel:self.param];
  
  // collection
  QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                            initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  layout.sectionInset = UIEdgeInsetsZero;
  layout.itemSize = CGSizeMake(1. * (BannerWitdh - 40) / 4, BannerHeight / 15);
  layout.minimumInteritemSpacing = 0;
  self.collectionview =
  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BannerWitdh - 20, BannerHeight / 15)
                     collectionViewLayout:layout];
  self.collectionview.center = CGPointMake(BannerWitdh / 2, CGRectGetHeight(self.banner.frame));
  self.collectionview.layer.cornerRadius = BannerHeight / 80;
  self.collectionview.scrollEnabled = NO;
  self.collectionview.showsHorizontalScrollIndicator = NO;
  self.collectionview.backgroundColor = UIColor.qd_backgroundColor;
  
  [self.collectionview registerClass:[ImageAndLabelCell class]
          forCellWithReuseIdentifier:@"recommondcell"];
  self.collectionview.delegate = self;
  self.collectionview.dataSource = self;
  [self addSubview:self.banner];
  [self addSubview:self.collectionview];
  
  self.collectionview.layer.shadowOffset = CGSizeMake(0, 1);
  self.collectionview.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.collectionview.layer.shadowRadius = 5;
  self.collectionview.layer.shadowOpacity = 0.25;
  self.collectionview.clipsToBounds = false;
  self.collectionview.layer.masksToBounds = false;
}

- (void)loadData {
  self.param.wDataSet([self getArray]);
  [self.banner updateUI];
  [self layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ImageAndLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommondcell"
                                                                      forIndexPath:indexPath];
  cell.imageview.image = UIImageMake(self.tabList[indexPath.row][@"image"]);
  cell.label.text = self.tabList[indexPath.row][@"title"];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"banner cell", @"click:(section:%li,row:%li)", indexPath.section, indexPath.row);
  if (indexPath.row == 3) {
    [self.qmui_viewController.navigationController pushViewController:[SearchListController new]
                                                             animated:YES];
  } else {
    [self.qmui_viewController.navigationController pushViewController:[ListController new]
                                                             animated:YES];
  }
}

- (NSArray *)getArray {
  return @[
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1585728804851&di="
    @"e8278d3456daec9c01baa3a4e6b5fa78&imgtype=0&src=http%3A%2F%2Fimg1.qunarzz.com%2Ftravel%2Fpoi%"
    @"2F1806%2F18%2F42413e19ce497737.jpg",
    @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/"
    @"u=1853571223,3568240217&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1585728804850&di="
    @"89cb8a957738b6143faac79c50bd76d5&imgtype=0&src=http%3A%2F%2Fb3-q.mafengwo.net%2Fs9%2FM00%"
    @"2F89%2FE3%2FwKgBs1efDaWAUfEYAAOi6EHRWcY30.jpeg%3FimageView2%2F2%2Fw%2F680%2Fq%2F90"
  ];
}
@end
