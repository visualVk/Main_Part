//
//  HotelDiscussModel.m
//  MainPart
//
//  Created by blacksky on 2020/5/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelDiscussModel.h"
@implementation HotelDiscussModel
+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"data" : [HotelDisscussList class] };
}
@end
