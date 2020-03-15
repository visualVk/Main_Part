//
//  MineOrderServiceCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCheckInfo.h"
@interface MineOrderServiceCell : UICollectionViewCell
@property(nonatomic, strong) UIViewController *parentController;
@property(nonatomic, strong) OrderCheckInfo *model;
@end
