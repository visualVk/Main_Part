//
//  PowerCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PowerCell.h"
#import "MarkUtils.h"
#import "SimpleImageTitleCell.h"
#import <JQCollectionViewAlignLayout.h>
#define SIMPLEIMAGETITLECELL @"simpleimagetitlecell"

@interface PowerCell () <GenerateEntityDelegate, UICollectionViewDelegate,
UICollectionViewDataSource, JQCollectionViewAlignLayoutDelegate>

@end

@implementation PowerCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  UIView *superview = self.contentView;
  addView(superview, self.powerView);
  
  [self.powerView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UICollectionView *)powerView {
  if (!_powerView) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment = JQCollectionViewItemsHorizontalAlignmentCenter;
    layout.itemsVerticalAlignment = JQCollectionViewItemsVerticalAlignmentCenter;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    _powerView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _powerView.backgroundColor = UIColor.clearColor;
    _powerView.scrollEnabled = false;
    [_powerView registerClass:SimpleImageTitleCell.class
   forCellWithReuseIdentifier:SIMPLEIMAGETITLECELL];
    _powerView.delegate = self;
    _powerView.dataSource = self;
  }
  return _powerView;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  SimpleImageTitleCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:SIMPLEIMAGETITLECELL
                                            forIndexPath:indexPath];
  
  cell.image.image = UIImageMake(self.datas[indexPath.row][@"image"]);
  cell.title.text = self.datas[indexPath.row][@"title"];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT / 8);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"power cell", @"click:%li,%li", indexPath.section, indexPath.row);
}
@end
