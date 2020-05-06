//
//  MineFoodOrderController.h
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderCheckInfo.h"
#import "QMUICommonViewController.h"
typedef enum { RoomOrderType, QRCodeOrderType } FoodOrderType;
@interface MineFoodOrderController : QMUICommonViewController
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) FoodOrderType foodOrderType;
@property (nonatomic, strong) OrderCheckInfo *orderCheckInfo;
@end
