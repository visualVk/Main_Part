//
//  OrderCheckInfoModelList.h
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderCheckInfo.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface OrderCheckInfoModelList : NSObject

@property (nonatomic, strong) NSMutableArray<OrderCheckInfo *> *data;
@end

NS_ASSUME_NONNULL_END
