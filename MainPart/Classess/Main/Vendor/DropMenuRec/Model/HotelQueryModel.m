//
//  HotelQueryModel.m
//  DropMenuRe
//
//  Created by blacksky on 2020/3/11.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelQueryModel.h"
@implementation HotelQueryModel
- (instancetype)init {
  self = [super init];
  if (self) {
    self.brandList = [NSMutableArray new];
    self.discountList = [NSMutableArray new];
    self.roomComboList = [NSMutableArray new];
    self.hotelRankList = [NSMutableArray new];
  }
  return self;
}
@end
