//
//  SceneHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneDetailHeaderView.h"
#import "MarkUtils.h"
#import "SceneDetailHeaderCell.h"
#import "SceneMultiLineCell.h"
#import "SceneSingleLineCell.h"
#define SCENEHEADERCELL @"sceneheadercell"
#define SCENESINGLELINECELL @"scenesinglelinecell"
#define SCENEMULTILINECELL @"scenemultilinecell"
#import <JQCollectionViewAlignLayout.h>
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"c689c6e6b3ea4aa16719a5dad5b93d36&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%"          \
@"2Fupload%2F19779%2F19778120.JPG",                                                            \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"ded22c5d5202213bfdc3aaeb2f2ecf09&imgtype=0&src=http%3A%2F%2Fwww.bizhidaquan.com%2Fd%"        \
@"2Ffile%2F1%2F1159829.jpg",                                                                   \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"829f7b9b0ba4222a9bab2282e2b239bd&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201310%2F19%2F235356fyjkkugokokczyo0.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"557632a98119862074f6306c6b269a9d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F2017-10-13%2F59e0270c6ba4e.jpg",                                                           \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"8db59485be71f14b5a70286128d1aec1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"4d4057e96f0b47cb8cb04575ba744ef1&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F1%2F53a15a1343174.jpg",                                                                    \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783660279&di="                                \
@"3c9f7da2c66bd25d350e03656e746696&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%"  \
@"3D2155983538%2C3860699715%26fm%3D214%26gp%3D0.jpg",                                          \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513022&di="                                \
@"f8308055cabe18057cb07d55193f547f&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201408%2F05%2F222353wu5y5mzv6mprxvhn.jpg"                                                  \
]
@interface SceneDetailHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, GenerateEntityDelegate>
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation SceneDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.remarkOne.layer.cornerRadius = self.remarkOne.frame.size.height / 2;
  self.remarkOne.layer.masksToBounds = YES;
  self.remarkTwo.layer.cornerRadius = self.remarkTwo.frame.size.height / 2;
  self.remarkTwo.layer.masksToBounds = YES;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self, self.banner);
  addView(self, self.collectionView);
  addView(self, self.remarkOne);
  addView(self, self.remarkTwo);
  [self insertSubview:self.shadowView belowSubview:self.collectionView];
  
  [self.shadowView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.collectionView); }];
  
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.banner.mas_bottom).offset(-20);
    make.leading.trailing.equalTo(self).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(DEVICE_HEIGHT / 3);
  }];
  
  [@[ self.remarkOne, self.remarkTwo ] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.banner).with.inset(0.5 * SPACE);
  }];
  
  [self.remarkTwo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.collectionView.mas_top).with.inset(0.25 * SPACE);
  }];
  
  [self.remarkOne mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.remarkTwo.mas_top).with.inset(0.25 * SPACE);
  }];
}

#pragma mark - Lazy Init
- (UIView *)shadowView {
  if (!_shadowView) {
    _shadowView = [UIView new];
    _shadowView.layer.cornerRadius = 10;
    _shadowView.layer.shadowOpacity = 0.25f;
    _shadowView.layer.shadowRadius = 10;
    _shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    _shadowView.backgroundColor = UIColor.qd_backgroundColor;
  }
  return _shadowView;
}

- (SDCycleScrollView *)banner {
  if (!_banner) {
    _banner = [SDCycleScrollView
               cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 3)
               imageNamesGroup:[imgList subarrayWithRange:NSMakeRange(0, arc4random() %
                                                                      imgList.count)]];
    //    _banner.imageURLStringsGroup = @[@""]
    _banner.showPageControl = false;
  }
  return _banner;
}

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment = JQCollectionViewItemsHorizontalAlignmentCenter;
    _collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:SceneDetailHeaderCell.class
        forCellWithReuseIdentifier:SCENEHEADERCELL];
    [_collectionView registerClass:SceneSingleLineCell.class
        forCellWithReuseIdentifier:SCENESINGLELINECELL];
    [_collectionView registerClass:SceneMultiLineCell.class
        forCellWithReuseIdentifier:SCENEMULTILINECELL];
    _collectionView.backgroundColor = UIColor.qd_backgroundColor;
    _collectionView.scrollEnabled = false;
    _collectionView.layer.cornerRadius = 10;
    _collectionView.layer.masksToBounds = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (QMUILabel *)remarkOne {
  if (!_remarkOne) {
    _remarkOne = [self generateCommonLabel];
    _remarkOne.textColor = UIColor.qd_backgroundColor;
    _remarkOne.font = UIFontMake(13);
    _remarkOne.text = @"山清水秀";
  }
  return _remarkOne;
}

- (QMUILabel *)remarkTwo {
  if (!_remarkTwo) {
    _remarkTwo = [self generateCommonLabel];
    _remarkTwo.textColor = UIColor.qd_backgroundColor;
    _remarkTwo.font = UIFontMake(13);
    _remarkTwo.text = @"瀑布之景更为神奇秀丽";
  }
  return _remarkTwo;
}

- (QMUILabel *)generateCommonLabel {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
  label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
  label.highlightedTextColor = nil;
  label.highlightedBackgroundColor = nil;
  return label;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,JQCollectionViewAlignLayoutDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  switch (row) {
    case 0:
      return CGSizeMake(DEVICE_WIDTH - SPACE, DEVICE_HEIGHT / 13);
    case 1:
    case 2:
      return CGSizeMake(DEVICE_WIDTH - SPACE, DEVICE_HEIGHT / 17);
    case 3:
      return CGSizeMake(DEVICE_WIDTH - SPACE, DEVICE_HEIGHT / 15);
    default:
      break;
  }
  return CGSizeMake(DEVICE_WIDTH - SPACE, DEVICE_HEIGHT / 15);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  if (row == 0) {
    SceneDetailHeaderCell *sCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SCENEHEADERCELL
                                              forIndexPath:indexPath];
    return sCell;
  }
  if (row == 1) {
    SceneSingleLineCell *ssCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SCENESINGLELINECELL
                                              forIndexPath:indexPath];
    ssCell.container.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.45];
    ssCell.content.text = @"该地区排名第3";
    ssCell.qmui_borderLocation = QMUIViewBorderPositionNone;
    return ssCell;
  }
  if (row == 2) {
    SceneSingleLineCell *ssCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SCENESINGLELINECELL
                                              forIndexPath:indexPath];
    ssCell.container.backgroundColor = UIColor.qd_backgroundColor;
    //    ssCell.container.qmui_borderColor = UIColor.qd_separatorColor;
    //    ssCell.container.qmui_borderLocation = QMUIToastViewPositionBottom;
    ssCell.imageview.image = UIImageMake(@"spot_locate");
    ssCell.content.text = @"四川阿坝藏族自治区";
    ssCell.qmui_borderColor = UIColor.qd_separatorColor;
    ssCell.qmui_borderPosition = QMUIViewBorderPositionBottom;
    return ssCell;
  }
  if (row == 3) {
    SceneMultiLineCell *smCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SCENEMULTILINECELL
                                              forIndexPath:indexPath];
    smCell.imageview.image = UIImageMake(@"edit");
    smCell.content.text = @"四川阿坝藏族自治区";
    return smCell;
  }
  
  return nil;
}
@end
