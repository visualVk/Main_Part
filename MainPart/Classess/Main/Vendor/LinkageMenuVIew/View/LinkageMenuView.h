//
//  LinkageMenuView.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageMenuProtocol.h"
#import "LinkageModel.h"
#import <UIKit/UIKit.h>

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
