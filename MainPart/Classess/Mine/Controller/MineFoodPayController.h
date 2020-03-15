//
//  MineFoodPayController.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import "OrderCheckInfo.h"
#import "QMUICommonViewController.h"
typedef enum { OrderPayType, QRCodePayType } FoodPayType;
@interface MineFoodPayController : QMUICommonViewController
@property (nonatomic, strong) NSArray<Food *> *foodList;
@property (nonatomic, assign) CGFloat foodTotPrice;
@property (nonatomic, assign) FoodPayType foodPayType;
@property (nonatomic, strong) OrderCheckInfo *model;
@end
