//
//  MineFoodToolBar.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import "OrderCheckInfo.h"
#import <UIKit/UIKit.h>
typedef void (^FoodNumChangeBlock)(void);
@interface MineFoodToolBar : UIView
@property (nonatomic, strong) NSMutableArray<Food *> *modelList;
@property (nonatomic, strong) FoodNumChangeBlock foodNumChangeBlock;
@property (nonatomic, strong) OrderCheckInfo *model;
@property (nonatomic, assign) BOOL addressEnable;
@end
