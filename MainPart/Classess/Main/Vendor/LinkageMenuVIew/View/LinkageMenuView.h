//
//  LinkageMenuView.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageModel.h"
#import <UIKit/UIKit.h>

@protocol LinkageMenuProtocol <NSObject>
@optional
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                    drawCellForIndexPath:(NSIndexPath *)indexPath;
- (CGSize)collectionView:(UICollectionView *)collectionView
    sizeForIndexPathCell:(NSIndexPath *)indexPath;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView
   sizeForFooterInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView
   sizeForHeaderInSection:(NSInteger)section;

- (NSInteger)rightTopAndBottomTotolNum:(NSInteger)section;
- (NSInteger)rightNumberOfSections;
- (NSInteger)leftTotal:(NSInteger)section;
- (NSString *)loadLeftTitle;
@end

@interface LinkageMenuView : UIView
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
// section名和左菜单栏标题
@property (nonatomic, strong) NSArray<LinkageModel *> *datas;

@property (nonatomic, assign) BOOL isBegin;

@property (nonatomic, weak) id<LinkageMenuProtocol> link_delegate;
- (instancetype)initWithDataSource:(NSArray<LinkageModel *> *)datasource;
- (void)loadData:(NSArray<LinkageModel *> *)datasource;
@end
