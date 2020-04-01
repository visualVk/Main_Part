//
//  HotelAppreaiseModel.m
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "HotelAppreaiseModel.h"

NSString *const kHotelAppreaiseModelContent = @"content";
NSString *const kHotelAppreaiseModelCreateTime = @"createTime";
NSString *const kHotelAppreaiseModelFacilitiesGrade = @"facilitiesGrade";
NSString *const kHotelAppreaiseModelHotelId = @"hotelId";
NSString *const kHotelAppreaiseModelHygieneGrade = @"hygieneGrade";
NSString *const kHotelAppreaiseModelIdField = @"id";
NSString *const kHotelAppreaiseModelLiveTime = @"liveTime";
NSString *const kHotelAppreaiseModelLocationGrade = @"locationGrade";
NSString *const kHotelAppreaiseModelPayNumber = @"payNumber";
NSString *const kHotelAppreaiseModelRoomtypeId = @"roomtypeId";
NSString *const kHotelAppreaiseModelRoomtypeName = @"roomtypeName";
NSString *const kHotelAppreaiseModelServiceGrade = @"serviceGrade";
NSString *const kHotelAppreaiseModelUrlList = @"urlList";
NSString *const kHotelAppreaiseModelUserId = @"userId";

@interface HotelAppreaiseModel ()
@end
@implementation HotelAppreaiseModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (![dictionary[kHotelAppreaiseModelContent] isKindOfClass:[NSNull class]]) {
    self.content = dictionary[kHotelAppreaiseModelContent];
  }
  if (![dictionary[kHotelAppreaiseModelCreateTime] isKindOfClass:[NSNull class]]) {
    self.createTime = dictionary[kHotelAppreaiseModelCreateTime];
  }
  if (![dictionary[kHotelAppreaiseModelFacilitiesGrade] isKindOfClass:[NSNull class]]) {
    self.facilitiesGrade = [dictionary[kHotelAppreaiseModelFacilitiesGrade] floatValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelHotelId] isKindOfClass:[NSNull class]]) {
    self.hotelId = [dictionary[kHotelAppreaiseModelHotelId] integerValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelHygieneGrade] isKindOfClass:[NSNull class]]) {
    self.hygieneGrade = [dictionary[kHotelAppreaiseModelHygieneGrade] floatValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelIdField] isKindOfClass:[NSNull class]]) {
    self.idField = [dictionary[kHotelAppreaiseModelIdField] integerValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelLiveTime] isKindOfClass:[NSNull class]]) {
    self.liveTime = dictionary[kHotelAppreaiseModelLiveTime];
  }
  if (![dictionary[kHotelAppreaiseModelLocationGrade] isKindOfClass:[NSNull class]]) {
    self.locationGrade = [dictionary[kHotelAppreaiseModelLocationGrade] floatValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelPayNumber] isKindOfClass:[NSNull class]]) {
    self.payNumber = dictionary[kHotelAppreaiseModelPayNumber];
  }
  if (![dictionary[kHotelAppreaiseModelRoomtypeId] isKindOfClass:[NSNull class]]) {
    self.roomtypeId = [dictionary[kHotelAppreaiseModelRoomtypeId] integerValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelRoomtypeName] isKindOfClass:[NSNull class]]) {
    self.roomtypeName = dictionary[kHotelAppreaiseModelRoomtypeName];
  }
  if (![dictionary[kHotelAppreaiseModelServiceGrade] isKindOfClass:[NSNull class]]) {
    self.serviceGrade = [dictionary[kHotelAppreaiseModelServiceGrade] floatValue];
  }
  
  if (![dictionary[kHotelAppreaiseModelUrlList] isKindOfClass:[NSNull class]]) {
    self.urlList = dictionary[kHotelAppreaiseModelUrlList];
  }
  if (![dictionary[kHotelAppreaiseModelUserId] isKindOfClass:[NSNull class]]) {
    self.userId = [dictionary[kHotelAppreaiseModelUserId] integerValue];
  }
  
  return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  if (self.content != nil) { dictionary[kHotelAppreaiseModelContent] = self.content; }
  if (self.createTime != nil) { dictionary[kHotelAppreaiseModelCreateTime] = self.createTime; }
  dictionary[kHotelAppreaiseModelFacilitiesGrade] = @(self.facilitiesGrade);
  dictionary[kHotelAppreaiseModelHotelId] = @(self.hotelId);
  dictionary[kHotelAppreaiseModelHygieneGrade] = @(self.hygieneGrade);
  dictionary[kHotelAppreaiseModelIdField] = @(self.idField);
  if (self.liveTime != nil) { dictionary[kHotelAppreaiseModelLiveTime] = self.liveTime; }
  dictionary[kHotelAppreaiseModelLocationGrade] = @(self.locationGrade);
  if (self.payNumber != nil) { dictionary[kHotelAppreaiseModelPayNumber] = self.payNumber; }
  dictionary[kHotelAppreaiseModelRoomtypeId] = @(self.roomtypeId);
  if (self.roomtypeName != nil) {
    dictionary[kHotelAppreaiseModelRoomtypeName] = self.roomtypeName;
  }
  dictionary[kHotelAppreaiseModelServiceGrade] = @(self.serviceGrade);
  if (self.urlList != nil) { dictionary[kHotelAppreaiseModelUrlList] = self.urlList; }
  dictionary[kHotelAppreaiseModelUserId] = @(self.userId);
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
  if (self.content != nil) {
    [aCoder encodeObject:self.content forKey:kHotelAppreaiseModelContent];
  }
  if (self.createTime != nil) {
    [aCoder encodeObject:self.createTime forKey:kHotelAppreaiseModelCreateTime];
  }
  [aCoder encodeObject:@(self.facilitiesGrade) forKey:kHotelAppreaiseModelFacilitiesGrade];
  [aCoder encodeObject:@(self.hotelId) forKey:kHotelAppreaiseModelHotelId];
  [aCoder encodeObject:@(self.hygieneGrade) forKey:kHotelAppreaiseModelHygieneGrade];
  [aCoder encodeObject:@(self.idField) forKey:kHotelAppreaiseModelIdField];
  if (self.liveTime != nil) {
    [aCoder encodeObject:self.liveTime forKey:kHotelAppreaiseModelLiveTime];
  }
  [aCoder encodeObject:@(self.locationGrade) forKey:kHotelAppreaiseModelLocationGrade];
  if (self.payNumber != nil) {
    [aCoder encodeObject:self.payNumber forKey:kHotelAppreaiseModelPayNumber];
  }
  [aCoder encodeObject:@(self.roomtypeId) forKey:kHotelAppreaiseModelRoomtypeId];
  if (self.roomtypeName != nil) {
    [aCoder encodeObject:self.roomtypeName forKey:kHotelAppreaiseModelRoomtypeName];
  }
  [aCoder encodeObject:@(self.serviceGrade) forKey:kHotelAppreaiseModelServiceGrade];
  if (self.urlList != nil) {
    [aCoder encodeObject:self.urlList forKey:kHotelAppreaiseModelUrlList];
  }
  [aCoder encodeObject:@(self.userId) forKey:kHotelAppreaiseModelUserId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.content = [aDecoder decodeObjectForKey:kHotelAppreaiseModelContent];
  self.createTime = [aDecoder decodeObjectForKey:kHotelAppreaiseModelCreateTime];
  self.facilitiesGrade =
  [[aDecoder decodeObjectForKey:kHotelAppreaiseModelFacilitiesGrade] floatValue];
  self.hotelId = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelHotelId] integerValue];
  self.hygieneGrade = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelHygieneGrade] floatValue];
  self.idField = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelIdField] integerValue];
  self.liveTime = [aDecoder decodeObjectForKey:kHotelAppreaiseModelLiveTime];
  self.locationGrade = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelLocationGrade] floatValue];
  self.payNumber = [aDecoder decodeObjectForKey:kHotelAppreaiseModelPayNumber];
  self.roomtypeId = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelRoomtypeId] integerValue];
  self.roomtypeName = [aDecoder decodeObjectForKey:kHotelAppreaiseModelRoomtypeName];
  self.serviceGrade = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelServiceGrade] floatValue];
  self.urlList = [aDecoder decodeObjectForKey:kHotelAppreaiseModelUrlList];
  self.userId = [[aDecoder decodeObjectForKey:kHotelAppreaiseModelUserId] integerValue];
  return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
  HotelAppreaiseModel *copy = [HotelAppreaiseModel new];
  
  copy.content = [self.content copy];
  copy.createTime = [self.createTime copy];
  copy.facilitiesGrade = self.facilitiesGrade;
  copy.hotelId = self.hotelId;
  copy.hygieneGrade = self.hygieneGrade;
  copy.idField = self.idField;
  copy.liveTime = [self.liveTime copy];
  copy.locationGrade = self.locationGrade;
  copy.payNumber = [self.payNumber copy];
  copy.roomtypeId = self.roomtypeId;
  copy.roomtypeName = [self.roomtypeName copy];
  copy.serviceGrade = self.serviceGrade;
  copy.urlList = [self.urlList copy];
  copy.userId = self.userId;
  
  return copy;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{ @"idField" : @"id" };
}
@end
