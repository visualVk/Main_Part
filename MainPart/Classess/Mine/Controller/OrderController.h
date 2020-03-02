//
//  OrderController.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
typedef enum { AllOrder, NonPaymentOrder, FutureOrder, RemarkOrder } OrderControllerType;
@interface OrderController : QMUICommonViewController
- (instancetype)initWithOrderType:(OrderControllerType)type;
@end
