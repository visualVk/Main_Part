
//
//  HotelModelList.m
//  MainPart
//
//  Created by blacksky on 2020/3/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelModelList.h"
NSString *const kHotelModelListData = @"data";
@implementation HotelModelList

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (![dictionary[kHotelModelListData] isKindOfClass:[NSNull class]]) {
    self.data = dictionary[kHotelModelListData];
  }
  return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  if (self.data != nil) { dictionary[kHotelModelListData] = self.data; }
  return dictionary;
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
  if (self.data != nil) { [aCoder encodeObject:self.data forKey:kHotelModelListData]; }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.data = [aDecoder decodeObjectForKey:kHotelModelListData];
  return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
  HotelModelList *copy = [HotelModelList new];
  
  copy.data = [self.data copy];
  
  return copy;
}

+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"data" : [HotelModel class] };
}
@end
