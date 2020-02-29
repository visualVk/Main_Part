//
//  PowerCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface PowerCell : QMUITableViewCell
@property(nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UICollectionView *powerView;
@end
