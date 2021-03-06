//
//  HotCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotCell.h"
#import "MarkUtils.h"
#define BOTTOMHEIGHT DEVICE_HEIGHT / 12
#define DEFAULTPINK UIColorMakeWithHex(@"#FEB692")
#pragma mark - hot content cell
@interface HotContentCell : UICollectionViewCell <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUILabel *placeholder;
@end

@implementation HotContentCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  self.imageview = [UIImageView new];
  self.imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  self.bottomView = [UIImageView new];
  self.bottomView.contentMode = QMUIImageResizingModeScaleAspectFill;
  self.bottomView.image = UIImageMake(@"pink_gradient");
  self.bottomView.backgroundColor = UIColor.qd_backgroundColor;
  self.title = [UILabel new];
  self.title.font = UIFontBoldMake(TITLEFONTSIZE);
  self.title.text = @"温州万达";
  self.title.textColor = UIColor.qd_backgroundColor;
  self.placeholder = [QMUILabel new];
  self.placeholder.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
  self.placeholder.font = UIFontMake(TITLEPLACE);
  self.placeholder.text = @"舒适的温州 ";
  self.placeholder.textColor = DEFAULTPINK;
  self.placeholder.backgroundColor = UIColor.qd_backgroundColor;
  self.placeholder.layer.cornerRadius = BOTTOMHEIGHT / 20;
  self.placeholder.layer.masksToBounds = YES;
  
  superview.mas_key = @"superview";
  self.imageview.mas_key = @"imageview";
  addView(superview, self.imageview);
  self.bottomView.mas_key = @"bottomView";
  addView(superview, self.bottomView);
  self.title.mas_key = @"title";
  addView(self.bottomView, self.title);
  self.placeholder.mas_key = @"placeholder";
  addView(self.bottomView, self.placeholder);
  MASAttachKeys(superview);
  
  [self.imageview mas_updateConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(superview);
    make.bottom.equalTo(self.bottomView);
  }];
  
  [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.height.equalTo(@(BOTTOMHEIGHT));
    make.bottom.equalTo(superview);
  }];
  
  [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.bottomView).offset(0.5 * SPACE);
    make.right.equalTo(self.bottomView).offset(-0.5 * SPACE);
  }];
  
  [self.placeholder mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title);
    make.top.equalTo(self.title.mas_bottom).offset(0.5 * SPACE);
    make.bottom.equalTo(self.bottomView).offset(-0.5 * SPACE);
  }];
  
  UIView *shadowView = [UIView new];
  insertViewBelow(self, shadowView, superview);
  [shadowView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

@end

#pragma mark - hot cell
#import <MJRefresh/MJRefresh.h>
//#import <WSLWaterFlowLayout/WSLWaterFlowLayout.h>
#import "FooterEmptyView.h"
#import "HotHeaderView.h"
#import "NSObject+BlockSEL.h"
#import "WSLWaterFlowLayout.h"
#define HOTCONTENTCELL @"hotecontentcell"
#define TOPTITLECELL @"toptitlecell"
#define HEADERVIEW @"headerview"
#define FOOTERVIEW @"footerview"
#define FIRSTCELLHEIGHT DEVICE_HEIGHT / 5
#define SECONDCELLHEIGHT DEVICE_HEIGHT / 4
#define THIRDCELLHEIGHT DEVICE_HEIGHT / 3
#define BORDERRADIUS DEVICE_HEIGHT / 100
#define COL 2
#define SEC 2
#define ITEMWIDTH (DEVICE_WIDTH - 2 * SPACE) / 4
#define BOTTOMNOTIFICATION @"bottomnotification"
#import "NSDictionary+LoadJson.h"
#import "RecModelList.h"
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588776355194&di="                                \
@"3a142f696b216bc3e8702a0c6f8b7c0f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F04%2F33%"    \
@"2F01300533988875133905331294017.jpg",                                                        \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588776358494&di="                                \
@"14e2a0bc73029b424043b8d5ccdd5dff&imgtype=0&src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%"         \
@"2Fimages%2F20160520%2F1463729160_10819_6.jpg",                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588776360797&di="                                \
@"99b5b8e6e882b864b448be3a3543e34c&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%"   \
@"2Fimages%2F20180110%2F46f202e36892412ea13f245ca10e0476.jpeg",                                \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588776362639&di="                                \
@"c6a28c6e714c586ebcf140fa9e7df26f&imgtype=0&src=http%3A%2F%2Fi4.qhimg.com%"                   \
@"2Ft0165d5f96adbfac81f.jpg"                                                                   \
]
@interface HotCell () <UICollectionViewDelegate, UICollectionViewDataSource,
WSLWaterFlowLayoutDelegate, GenerateEntityDelegate, HotHeaderClickDelegate> {
  double speed;
  double y;
}
@property (nonatomic, assign) NSInteger tot;
@property (nonatomic, strong) RecModelList *modelList;
@end

@implementation HotCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.tot = 10;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(acceptMsgOfBottomView:)
                                               name:BOTTOMNOTIFICATION
                                             object:nil];
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.userInteractionEnabled = true;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  UIView *superview = self.contentView;
  self.backgroundColor = UIColor.clearColor;
  addView(self.contentView, self.collectionview);
  UIWindow *window = UIApplication.sharedApplication.delegate.window;
  QMUILogInfo(@"window", @"top:%f,bottom:%f", window.safeAreaInsets.top,
              window.safeAreaInsets.bottom);
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview);
    make.centerX.equalTo(superview);
    make.width.equalTo(@(DEVICE_WIDTH));
    make.height.equalTo(@(DEVICE_HEIGHT - NavigationContentTop - TabBarHeight));
    make.bottom.equalTo(superview).offset(-SPACE);
  }];
}
#pragma mark - 懒加载 collection view
- (UICollectionView *)collectionview {
  if (!_collectionview) {
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc] init];
    layout.delegate = self;
    layout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    _collectionview.scrollsToTop = YES;
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.scrollEnabled = false;
    _collectionview.showsVerticalScrollIndicator = false;
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [_collectionview registerClass:[HotHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:HEADERVIEW];
    [_collectionview registerClass:[HotContentCell class]
        forCellWithReuseIdentifier:HOTCONTENTCELL];
    [_collectionview registerClass:[FooterEmptyView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
               withReuseIdentifier:FOOTERVIEW];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
      
      dispatch_after(
                     dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                     ^{
        [_collectionview.mj_footer endRefreshing];
        [_collectionview
         setContentOffset:CGPointMake(
                                      0, _collectionview.contentSize.height -
                                      (DEVICE_HEIGHT - NavigationContentTop - TabBarHeight))
         animated:YES];
      });
    }];
    footer.stateLabel.text = @"xxxx";
    // Set footer
    _collectionview.mj_footer = footer;
  }
  return _collectionview;
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return self.datas.count;
  }
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  if (section == 0) {
    HotContentCell *hcCell = [collectionView dequeueReusableCellWithReuseIdentifier:HOTCONTENTCELL
                                                                       forIndexPath:indexPath];
    hcCell.imageview.image = UIImageMake(@"launch_background");
    if (self.modelList != nil && self.modelList.recList.count) {
      RecList *model = self.datas[row];
      model.imgUrl = imgList[arc4random() % imgList.count];
      hcCell.title.text = model.titleName;
      hcCell.placeholder.text = model.subTitle;
      [hcCell.imageview sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]
                          placeholderImage:UIImageMake(@"launch_background")];
    }
    
    hcCell.contentView.layer.cornerRadius = BORDERRADIUS;
    hcCell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    hcCell.contentView.layer.masksToBounds = YES;
    
    hcCell.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    hcCell.layer.shadowOffset = CGSizeMake(0, 1);
    hcCell.layer.shadowRadius = BORDERRADIUS;
    hcCell.layer.shadowOpacity = 0.25f;
    hcCell.layer.masksToBounds = NO;
    hcCell.layer.shadowPath =
    [UIBezierPath bezierPathWithRoundedRect:hcCell.bounds
                               cornerRadius:hcCell.contentView.layer.cornerRadius]
    .CGPath;
    return hcCell;
  }
  
  return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      HotHeaderView *titleHeader = [collectionView
                                    dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                    withReuseIdentifier:HEADERVIEW
                                    forIndexPath:indexPath];
      titleHeader.delegate = self;
      return titleHeader;
    } else {
      FooterEmptyView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                   withReuseIdentifier:FOOTERVIEW
                                                                          forIndexPath:indexPath];
      return footer;
    }
  }
  UICollectionReusableView *view = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
  return view;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
sizeForFooterViewInSection:(NSInteger)section {
  return CGSizeMake(0, 0);
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
sizeForHeaderViewInSection:(NSInteger)section {
  if (section == 0) {
    QMUILogInfo(@"hot cell", @"width=%f,height=%f", DEVICE_WIDTH, 1.5 * ITEMWIDTH + SPACE);
    return CGSizeMake(DEVICE_WIDTH, 1.5 * ITEMWIDTH + SPACE);
  }
  return CGSizeZero;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  NSInteger section = indexPath.section;
  //  if (section == 0) { return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 20); }
  switch (row % 3) {
    case 0:
      return CGSizeMake(20, THIRDCELLHEIGHT);
    case 1:
      return CGSizeMake(20, SECONDCELLHEIGHT);
    case 2:
      return CGSizeMake(20, FIRSTCELLHEIGHT);
  }
  return CGSizeZero;
}

- (CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return 2;
}

- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return UIEdgeInsetsMake(0, SPACE, SPACE, SPACE);
}

- (CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return SPACE;
}

- (CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return SPACE;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  QMUILogInfo(@"hot cell", @"no refresh height=%f", self.collectionview.contentSize.height);
  CGPoint point = scrollView.contentOffset;
  if (point.y <= -20) {
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTTOMNOTIFICATION
                                                        object:nil
                                                      userInfo:@{
                                                        @"flag" : @(true)
                                                      }];
  }
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  //  @weakify(self);
  //  [self.collectionview performBatchUpdates:^{
  //    @strongify(self);
  //    QMUILogInfo(@"hot collection view", @"click:{%li,%li}", indexPath.section, indexPath.row);
  //    self.tot++;
  //    [self.collectionview reloadItemsAtIndexPaths:@[ indexPath ]];
  //  }
  //                                completion:^(BOOL finished) {
  //    [self.collectionview selectItemAtIndexPath:indexPath
  //                                      animated:YES
  //                                scrollPosition:UICollectionViewScrollPositionBottom];
  //  }];
}

- (void)acceptMsgOfBottomView:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSNumber *result = userInfo[@"flag"];
  if (result.boolValue) {
    self.tableview.scrollEnabled = YES;
    self.collectionview.scrollEnabled = NO;
    [self.collectionview setContentOffset:CGPointMake(0, 0) animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"topnotification"
                                                        object:nil
                                                      userInfo:@{
                                                        @"flag" : @(1)
                                                      }];
  }
}

- (void)reloadDataWithIndex:(NSInteger)index {
  NSDictionary *dict = [NSDictionary readLocalFileWithName:@"HotRecModelListJSON"];
  self.modelList = [[RecModelList alloc] initWithDictionary:dict];
  self.datas = self.modelList.recList;
  [self.collectionview reloadData];
}
@end
