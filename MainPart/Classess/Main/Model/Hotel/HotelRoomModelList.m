//
//  HotelRoomModelList.m
//  MainPart
//
//  Created by blacksky on 2020/3/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelRoomModelList.h"

@implementation HotelRoomModelList

+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"data" : [HotelRoomModel class] };
}
@end
