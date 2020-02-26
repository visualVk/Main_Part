//
//  LinkageMenuView.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageMenuView.h"
#import "EvenCell.h"
#import "LeftCell.h"
#import "LinkageFooter.h"
#import "LinkageTitleHeader.h"
#import "MarkUtils.h"
#import "SingularCell.h"
#import <JQCollectionViewAlignLayout.h>
#define SINGULARCELL @"singularcell"
#define FOOTERCELL @"footercell"
#define EVENCELL @"evencell"
#define TITLECELL @"titlecell"
#define LEFTCELL @"leftcell"
@interface LinkageMenuView () <QMUITableViewDelegate, QMUITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate> {
  CGFloat offsetsC;
  CGFloat offsetsT;
  BOOL isDown;
  BOOL isTable;
}
@property (nonatomic, assign) NSInteger curRow;
@property (nonatomic, assign) NSInteger leftTot;
@property (nonatomic, strong) UIView *changeBackView;
@end

@implementation LinkageMenuView
//@synthesize collectionView = _collectionView, tableView = _tableView;

- (instancetype)initWithDataSource:(NSArray<LinkageModel *> *)datasource {
  if (self = [super initWithFrame:CGRectZero]) {
    self.datas = datasource;
    self.changeBackView = [UIView new];
    self.changeBackView.backgroundColor = UIColor.lightGrayColor;
    [self.changeBackView setAlpha:0.25];
    [self generateRootView];
    self.userInteractionEnabled = YES;
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    
    //    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:26];
    //    for (int i = 0; i < 26; i++) { [arr addObject:[NSString stringWithFormat:@"row:%d", i]]; }
    //    self.leftDatas = arr;
    self.userInteractionEnabled = YES;
    //    self.curRow = 0;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  __weak __typeof(self) weakSelf = self;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{ weakSelf.isBegin = true; });
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (scrollView == self.collectionView) {
    offsetsC = scrollView.contentOffset.y;
    isTable = false;
  } else {
    offsetsT = scrollView.contentOffset.y;
    isTable = true;
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.collectionView) {
    isDown = (scrollView.contentOffset.y > offsetsC);
  } else {
    isDown = (scrollView.contentOffset.y > offsetsC);
  }
}

- (void)generateRootView {
  addView(self, self.tableView);
  addView(self, self.collectionView);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.top.equalTo(self);
    make.width.mas_equalTo(DEVICE_WIDTH / 4);
  }];
  
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.tableView.mas_right);
    make.top.right.bottom.equalTo(self);
  }];
}

#pragma mark - tableview part

/// Lazy Init TableView
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:LeftCell.class forCellReuseIdentifier:LEFTCELL];
    _tableView.tableHeaderView = nil;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.qmui_borderColor = UIColor.lightGrayColor;
    _tableView.qmui_borderPosition = QMUIViewBorderPositionRight;
    _tableView.bounces = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                            animated:YES
                      scrollPosition:UITableViewScrollPositionNone];
    //    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0
    //    inSection:0]];
  }
  return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:LEFTCELL forIndexPath:indexPath];
  cell.label.text = self.datas[indexPath.row].title;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  /// 开始不移动
  if (self.isBegin) {
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
    UICollectionViewLayoutAttributes *attributes =
    [self.collectionView layoutAttributesForItemAtIndexPath:index];
    CGFloat yoffset = attributes.frame.origin.y - DEVICE_HEIGHT / 25;
    CGFloat xoffset = self.collectionView.contentOffset.x;
    [self.collectionView setContentOffset:CGPointMake(xoffset, yoffset) animated:YES];
    isTable = true;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

#pragma mark - collectionview part
- (UICollectionView *)collectionView {
  if (!_collectionView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    //    layout.itemsHorizontalAlignment = JQCollectionViewItemsHorizontalAlignmentCenter;
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    _collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.clearColor;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [_collectionView registerClass:SingularCell.class forCellWithReuseIdentifier:SINGULARCELL];
    [_collectionView registerClass:EvenCell.class forCellWithReuseIdentifier:EVENCELL];
    [_collectionView registerClass:LinkageFooter.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
               withReuseIdentifier:FOOTERCELL];
    [_collectionView registerClass:LinkageTitleHeader.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:TITLECELL];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  }
  return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.datas[section].imageList.count + self.datas[section].labelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  LinkageModel *model = self.datas[section];
  if (row < 2) {
    SingularCell *sCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SINGULARCELL forIndexPath:indexPath];
    /// todo: webimage加载
    sCell.imageview.image = UIImageMake(model.imageList[row]);
    sCell.title.text = model.hintList[row];
    return sCell;
  }
  EvenCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:EVENCELL forIndexPath:indexPath];
  cell.title.text = self.datas[section].labelList[row - 2];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  if (row < 2) {
    return CGSizeMake((CGRectGetWidth(self.collectionView.frame) - 30) / 2,
                      (CGRectGetWidth(self.collectionView.frame) - 30) / 2);
  }
  return CGSizeMake((CGRectGetWidth(self.collectionView.frame) - 30) / 2, DEVICE_HEIGHT / 28);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    LinkageTitleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                    withReuseIdentifier:TITLECELL
                                                                           forIndexPath:indexPath];
    header.title.text = self.datas[indexPath.section].title;
    return header;
  }
  LinkageFooter *footer =
  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                     withReuseIdentifier:FOOTERCELL
                                            forIndexPath:indexPath];
  return footer;
}
- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
}

/// 当collection footer即将消失切换对应的tableview cell
/// @param collectionView <#collectionView description#>
/// @param view <#view description#>
/// @param elementKind <#elementKind description#>
/// @param indexPath <#indexPath description#>
- (void)collectionView:(UICollectionView *)collectionView
didEndDisplayingSupplementaryView:(UICollectionReusableView *)view
      forElementOfKind:(NSString *)elementKind
           atIndexPath:(NSIndexPath *)indexPath {
  if (!self.isBegin || isTable) return;
  if (isDown && [elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
    if (collectionView.dragging || collectionView.decelerating) {
      NSInteger row =
      (indexPath.section + 1 < self.datas.count ? indexPath.section + 1 : self.datas.count - 1);
      [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]
                                  animated:YES
                            scrollPosition:UITableViewScrollPositionNone];
      if (![self.tableView
            qmui_cellVisibleAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
      }
    }
  }
}

/// 当collection header即将展示,切换对应tableview cell
/// @param collectionView <#collectionView description#>
/// @param view <#view description#>
/// @param elementKind <#elementKind description#>
/// @param indexPath <#indexPath description#>
- (void)collectionView:(UICollectionView *)collectionView
willDisplaySupplementaryView:(UICollectionReusableView *)view
        forElementKind:(NSString *)elementKind
           atIndexPath:(NSIndexPath *)indexPath {
  if (!self.isBegin || isTable) return;
  if (!isDown && [elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    if (![self.tableView qmui_cellVisibleAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section
                                                                        inSection:0]]) {
      [self.tableView
       scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0]
       atScrollPosition:UITableViewScrollPositionTop
       animated:YES];
    }
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(CGRectGetWidth(self.collectionView.frame), DEVICE_HEIGHT / 25);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
  return CGSizeMake(CGRectGetWidth(self.collectionView.frame), DEVICE_HEIGHT / 25);
}

/// 数据加载
/// @param datasource <#datasource description#>
- (void)loadData:(NSArray<LinkageModel *> *)datasource {
  self.datas = datasource;
  [self.tableView reloadData];
  [self.collectionView reloadData];
}
@end