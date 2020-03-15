//
//  MineFoodCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(Food *food);
@interface MineFoodCell : UICollectionViewCell
@property (nonatomic, strong) UIViewController *parenController;
@property (nonatomic, strong) Food *model;
@property (nonatomic, strong) ClickBlock clickBlock;
- (void)loadData:(Food *_Nonnull)model;
@end
