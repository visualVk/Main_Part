//
//  HotelModel.m
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "HotelModel.h"

NSString *const kHotelModelHotelComment = @"hotelComment";
NSString *const kHotelModelHotelCountpay = @"hotelCountpay";
NSString *const kHotelModelHotelDetail = @"hotelDetail";
NSString *const kHotelModelHotelLocation = @"hotelLocation";
NSString *const kHotelModelHotelMaxprice = @"hotelMaxprice";
NSString *const kHotelModelHotelName = @"hotelName";
NSString *const kHotelModelHotelPic = @"hotelPic";
NSString *const kHotelModelHotelRank = @"hotelRank";
NSString *const kHotelModelHotelSource = @"hotelSource";
NSString *const kHotelModelIdField = @"id";
NSString *const kHotelModelLogoList = @"logoList";
NSString *const kHotelModelLowPrice = @"lowPrice";
NSString *const kHotelModelOrgPrice = @"orgPrice";

@interface HotelModel ()
@end
@implementation HotelModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (![dictionary[kHotelModelHotelComment] isKindOfClass:[NSNull class]]) {
    self.hotelComment = [dictionary[kHotelModelHotelComment] integerValue];
  }
  
  if (![dictionary[kHotelModelHotelCountpay] isKindOfClass:[NSNull class]]) {
    self.hotelCountpay = [dictionary[kHotelModelHotelCountpay] integerValue];
  }
  
  if (![dictionary[kHotelModelHotelDetail] isKindOfClass:[NSNull class]]) {
    self.hotelDetail = dictionary[kHotelModelHotelDetail];
  }
  if (![dictionary[kHotelModelHotelLocation] isKindOfClass:[NSNull class]]) {
    self.hotelLocation = dictionary[kHotelModelHotelLocation];
  }
  if (![dictionary[kHotelModelHotelMaxprice] isKindOfClass:[NSNull class]]) {
    self.hotelMaxprice = [dictionary[kHotelModelHotelMaxprice] integerValue];
  }
  
  if (![dictionary[kHotelModelHotelName] isKindOfClass:[NSNull class]]) {
    self.hotelName = dictionary[kHotelModelHotelName];
  }
  if (![dictionary[kHotelModelHotelPic] isKindOfClass:[NSNull class]]) {
    self.hotelPic = dictionary[kHotelModelHotelPic];
  }
  if (![dictionary[kHotelModelHotelRank] isKindOfClass:[NSNull class]]) {
    self.hotelRank = dictionary[kHotelModelHotelRank];
  }
  if (![dictionary[kHotelModelHotelSource] isKindOfClass:[NSNull class]]) {
    self.hotelSource = [dictionary[kHotelModelHotelSource] floatValue];
  }
  
  if (![dictionary[kHotelModelIdField] isKindOfClass:[NSNull class]]) {
    self.idField = [dictionary[kHotelModelIdField] integerValue];
  }
  
  if (![dictionary[kHotelModelLogoList] isKindOfClass:[NSNull class]]) {
    self.logoList = dictionary[kHotelModelLogoList];
  }
  if (![dictionary[kHotelModelLowPrice] isKindOfClass:[NSNull class]]) {
    self.lowPrice = [dictionary[kHotelModelLowPrice] integerValue];
  }
  
  if (![dictionary[kHotelModelOrgPrice] isKindOfClass:[NSNull class]]) {
    self.orgPrice = [dictionary[kHotelModelOrgPrice] integerValue];
  }
  
  return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kHotelModelHotelComment] = @(self.hotelComment);
  dictionary[kHotelModelHotelCountpay] = @(self.hotelCountpay);
  if (self.hotelDetail != nil) { dictionary[kHotelModelHotelDetail] = self.hotelDetail; }
  if (self.hotelLocation != nil) { dictionary[kHotelModelHotelLocation] = self.hotelLocation; }
  dictionary[kHotelModelHotelMaxprice] = @(self.hotelMaxprice);
  if (self.hotelName != nil) { dictionary[kHotelModelHotelName] = self.hotelName; }
  if (self.hotelPic != nil) { dictionary[kHotelModelHotelPic] = self.hotelPic; }
  if (self.hotelRank != nil) { dictionary[kHotelModelHotelRank] = self.hotelRank; }
  dictionary[kHotelModelHotelSource] = @(self.hotelSource);
  dictionary[kHotelModelIdField] = @(self.idField);
  if (self.logoList != nil) { dictionary[kHotelModelLogoList] = self.logoList; }
  dictionary[kHotelModelLowPrice] = @(self.lowPrice);
  dictionary[kHotelModelOrgPrice] = @(self.orgPrice);
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
  [aCoder encodeObject:@(self.hotelComment) forKey:kHotelModelHotelComment];
  [aCoder encodeObject:@(self.hotelCountpay) forKey:kHotelModelHotelCountpay];
  if (self.hotelDetail != nil) {
    [aCoder encodeObject:self.hotelDetail forKey:kHotelModelHotelDetail];
  }
  if (self.hotelLocation != nil) {
    [aCoder encodeObject:self.hotelLocation forKey:kHotelModelHotelLocation];
  }
  [aCoder encodeObject:@(self.hotelMaxprice) forKey:kHotelModelHotelMaxprice];
  if (self.hotelName != nil) { [aCoder encodeObject:self.hotelName forKey:kHotelModelHotelName]; }
  if (self.hotelPic != nil) { [aCoder encodeObject:self.hotelPic forKey:kHotelModelHotelPic]; }
  if (self.hotelRank != nil) { [aCoder encodeObject:self.hotelRank forKey:kHotelModelHotelRank]; }
  [aCoder encodeObject:@(self.hotelSource) forKey:kHotelModelHotelSource];
  [aCoder encodeObject:@(self.idField) forKey:kHotelModelIdField];
  if (self.logoList != nil) { [aCoder encodeObject:self.logoList forKey:kHotelModelLogoList]; }
  [aCoder encodeObject:@(self.lowPrice) forKey:kHotelModelLowPrice];
  [aCoder encodeObject:@(self.orgPrice) forKey:kHotelModelOrgPrice];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.hotelComment = [[aDecoder decodeObjectForKey:kHotelModelHotelComment] integerValue];
  self.hotelCountpay = [[aDecoder decodeObjectForKey:kHotelModelHotelCountpay] integerValue];
  self.hotelDetail = [aDecoder decodeObjectForKey:kHotelModelHotelDetail];
  self.hotelLocation = [aDecoder decodeObjectForKey:kHotelModelHotelLocation];
  self.hotelMaxprice = [[aDecoder decodeObjectForKey:kHotelModelHotelMaxprice] integerValue];
  self.hotelName = [aDecoder decodeObjectForKey:kHotelModelHotelName];
  self.hotelPic = [aDecoder decodeObjectForKey:kHotelModelHotelPic];
  self.hotelRank = [aDecoder decodeObjectForKey:kHotelModelHotelRank];
  self.hotelSource = [[aDecoder decodeObjectForKey:kHotelModelHotelSource] floatValue];
  self.idField = [[aDecoder decodeObjectForKey:kHotelModelIdField] integerValue];
  self.logoList = [aDecoder decodeObjectForKey:kHotelModelLogoList];
  self.lowPrice = [[aDecoder decodeObjectForKey:kHotelModelLowPrice] integerValue];
  self.orgPrice = [[aDecoder decodeObjectForKey:kHotelModelOrgPrice] integerValue];
  return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
  HotelModel *copy = [HotelModel new];
  
  copy.hotelComment = self.hotelComment;
  copy.hotelCountpay = self.hotelCountpay;
  copy.hotelDetail = [self.hotelDetail copy];
  copy.hotelLocation = [self.hotelLocation copy];
  copy.hotelMaxprice = self.hotelMaxprice;
  copy.hotelName = [self.hotelName copy];
  copy.hotelPic = [self.hotelPic copy];
  copy.hotelRank = [self.hotelRank copy];
  copy.hotelSource = self.hotelSource;
  copy.idField = self.idField;
  copy.logoList = [self.logoList copy];
  copy.lowPrice = self.lowPrice;
  copy.orgPrice = self.orgPrice;
  
  return copy;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{ @"idField" : @"id" };
}
@end
