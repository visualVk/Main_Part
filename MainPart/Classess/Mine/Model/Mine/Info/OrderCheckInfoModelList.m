//
//  OrderCheckInfoModelList.m
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderCheckInfoModelList.h"

@implementation OrderCheckInfoModelList

+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"data" : [OrderCheckInfo class] };
}
@end
