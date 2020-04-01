//
//  HotelRoomModel.m
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "HotelRoomModel.h"

NSString *const kHotelRoomModelAvgGrade = @"avgGrade";
NSString *const kHotelRoomModelBedInfo = @"bedInfo";
NSString *const kHotelRoomModelBreakfast = @"breakfast";
NSString *const kHotelRoomModelCastPolicy = @"castPolicy";
NSString *const kHotelRoomModelConvenienceFacilities = @"convenienceFacilities";
NSString *const kHotelRoomModelCreateTime = @"createTime";
NSString *const kHotelRoomModelCreater = @"creater";
NSString *const kHotelRoomModelFacilitiesGrade = @"facilitiesGrade";
NSString *const kHotelRoomModelHotelId = @"hotelId";
NSString *const kHotelRoomModelHygieneGrade = @"hygieneGrade";
NSString *const kHotelRoomModelIdField = @"id";
NSString *const kHotelRoomModelLocationGrade = @"locationGrade";
NSString *const kHotelRoomModelMembershipInterests = @"membershipInterests";
NSString *const kHotelRoomModelRoomArea = @"roomArea";
NSString *const kHotelRoomModelRoomCount = @"roomCount";
NSString *const kHotelRoomModelRoomDetails = @"roomDetails";
NSString *const kHotelRoomModelRoomName = @"roomName";
NSString *const kHotelRoomModelRoomOrgprice = @"roomOrgprice";
NSString *const kHotelRoomModelRoomPrice = @"roomPrice";
NSString *const kHotelRoomModelRoomSize = @"roomSize";
NSString *const kHotelRoomModelRoomSpace = @"roomSpace";
NSString *const kHotelRoomModelRoomType = @"roomType";
NSString *const kHotelRoomModelServiceGrade = @"serviceGrade";
NSString *const kHotelRoomModelUrlList = @"urlList";
NSString *const kHotelRoomModelUserIntegral = @"userIntegral";
NSString *const kHotelRoomModelWashroomCollocation = @"washroomCollocation";
NSString *const kHotelRoomModelWifiInfo = @"wifiInfo";
NSString *const kHotelRoomModelWindows = @"windows";

@interface HotelRoomModel ()
@end
@implementation HotelRoomModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (![dictionary[kHotelRoomModelAvgGrade] isKindOfClass:[NSNull class]]) {
    self.avgGrade = [dictionary[kHotelRoomModelAvgGrade] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelBedInfo] isKindOfClass:[NSNull class]]) {
    self.bedInfo = dictionary[kHotelRoomModelBedInfo];
  }
  if (![dictionary[kHotelRoomModelBreakfast] isKindOfClass:[NSNull class]]) {
    self.breakfast = dictionary[kHotelRoomModelBreakfast];
  }
  if (![dictionary[kHotelRoomModelCastPolicy] isKindOfClass:[NSNull class]]) {
    self.castPolicy = dictionary[kHotelRoomModelCastPolicy];
  }
  if (![dictionary[kHotelRoomModelConvenienceFacilities] isKindOfClass:[NSNull class]]) {
    self.convenienceFacilities = dictionary[kHotelRoomModelConvenienceFacilities];
  }
  if (![dictionary[kHotelRoomModelCreateTime] isKindOfClass:[NSNull class]]) {
    self.createTime = dictionary[kHotelRoomModelCreateTime];
  }
  if (![dictionary[kHotelRoomModelCreater] isKindOfClass:[NSNull class]]) {
    self.creater = dictionary[kHotelRoomModelCreater];
  }
  if (![dictionary[kHotelRoomModelFacilitiesGrade] isKindOfClass:[NSNull class]]) {
    self.facilitiesGrade = [dictionary[kHotelRoomModelFacilitiesGrade] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelHotelId] isKindOfClass:[NSNull class]]) {
    self.hotelId = [dictionary[kHotelRoomModelHotelId] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelHygieneGrade] isKindOfClass:[NSNull class]]) {
    self.hygieneGrade = [dictionary[kHotelRoomModelHygieneGrade] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelIdField] isKindOfClass:[NSNull class]]) {
    self.idField = [dictionary[kHotelRoomModelIdField] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelLocationGrade] isKindOfClass:[NSNull class]]) {
    self.locationGrade = [dictionary[kHotelRoomModelLocationGrade] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelMembershipInterests] isKindOfClass:[NSNull class]]) {
    self.membershipInterests = dictionary[kHotelRoomModelMembershipInterests];
  }
  if (![dictionary[kHotelRoomModelRoomArea] isKindOfClass:[NSNull class]]) {
    self.roomArea = dictionary[kHotelRoomModelRoomArea];
  }
  if (![dictionary[kHotelRoomModelRoomCount] isKindOfClass:[NSNull class]]) {
    self.roomCount = [dictionary[kHotelRoomModelRoomCount] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelRoomDetails] isKindOfClass:[NSNull class]]) {
    self.roomDetails = dictionary[kHotelRoomModelRoomDetails];
  }
  if (![dictionary[kHotelRoomModelRoomName] isKindOfClass:[NSNull class]]) {
    self.roomName = dictionary[kHotelRoomModelRoomName];
  }
  if (![dictionary[kHotelRoomModelRoomOrgprice] isKindOfClass:[NSNull class]]) {
    self.roomOrgprice = [dictionary[kHotelRoomModelRoomOrgprice] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelRoomPrice] isKindOfClass:[NSNull class]]) {
    self.roomPrice = [dictionary[kHotelRoomModelRoomPrice] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelRoomSize] isKindOfClass:[NSNull class]]) {
    self.roomSize = [dictionary[kHotelRoomModelRoomSize] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelRoomSpace] isKindOfClass:[NSNull class]]) {
    self.roomSpace = [dictionary[kHotelRoomModelRoomSpace] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelRoomType] isKindOfClass:[NSNull class]]) {
    self.roomType = dictionary[kHotelRoomModelRoomType];
  }
  if (![dictionary[kHotelRoomModelServiceGrade] isKindOfClass:[NSNull class]]) {
    self.serviceGrade = [dictionary[kHotelRoomModelServiceGrade] floatValue];
  }
  
  if (![dictionary[kHotelRoomModelUrlList] isKindOfClass:[NSNull class]]) {
    self.urlList = dictionary[kHotelRoomModelUrlList];
  }
  if (![dictionary[kHotelRoomModelUserIntegral] isKindOfClass:[NSNull class]]) {
    self.userIntegral = [dictionary[kHotelRoomModelUserIntegral] integerValue];
  }
  
  if (![dictionary[kHotelRoomModelWashroomCollocation] isKindOfClass:[NSNull class]]) {
    self.washroomCollocation = dictionary[kHotelRoomModelWashroomCollocation];
  }
  if (![dictionary[kHotelRoomModelWifiInfo] isKindOfClass:[NSNull class]]) {
    self.wifiInfo = dictionary[kHotelRoomModelWifiInfo];
  }
  if (![dictionary[kHotelRoomModelWindows] isKindOfClass:[NSNull class]]) {
    self.windows = dictionary[kHotelRoomModelWindows];
  }
  return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kHotelRoomModelAvgGrade] = @(self.avgGrade);
  if (self.bedInfo != nil) { dictionary[kHotelRoomModelBedInfo] = self.bedInfo; }
  if (self.breakfast != nil) { dictionary[kHotelRoomModelBreakfast] = self.breakfast; }
  if (self.castPolicy != nil) { dictionary[kHotelRoomModelCastPolicy] = self.castPolicy; }
  if (self.convenienceFacilities != nil) {
    dictionary[kHotelRoomModelConvenienceFacilities] = self.convenienceFacilities;
  }
  if (self.createTime != nil) { dictionary[kHotelRoomModelCreateTime] = self.createTime; }
  if (self.creater != nil) { dictionary[kHotelRoomModelCreater] = self.creater; }
  dictionary[kHotelRoomModelFacilitiesGrade] = @(self.facilitiesGrade);
  dictionary[kHotelRoomModelHotelId] = @(self.hotelId);
  dictionary[kHotelRoomModelHygieneGrade] = @(self.hygieneGrade);
  dictionary[kHotelRoomModelIdField] = @(self.idField);
  dictionary[kHotelRoomModelLocationGrade] = @(self.locationGrade);
  if (self.membershipInterests != nil) {
    dictionary[kHotelRoomModelMembershipInterests] = self.membershipInterests;
  }
  if (self.roomArea != nil) { dictionary[kHotelRoomModelRoomArea] = self.roomArea; }
  dictionary[kHotelRoomModelRoomCount] = @(self.roomCount);
  if (self.roomDetails != nil) { dictionary[kHotelRoomModelRoomDetails] = self.roomDetails; }
  if (self.roomName != nil) { dictionary[kHotelRoomModelRoomName] = self.roomName; }
  dictionary[kHotelRoomModelRoomOrgprice] = @(self.roomOrgprice);
  dictionary[kHotelRoomModelRoomPrice] = @(self.roomPrice);
  dictionary[kHotelRoomModelRoomSize] = @(self.roomSize);
  dictionary[kHotelRoomModelRoomSpace] = @(self.roomSpace);
  if (self.roomType != nil) { dictionary[kHotelRoomModelRoomType] = self.roomType; }
  dictionary[kHotelRoomModelServiceGrade] = @(self.serviceGrade);
  if (self.urlList != nil) { dictionary[kHotelRoomModelUrlList] = self.urlList; }
  dictionary[kHotelRoomModelUserIntegral] = @(self.userIntegral);
  if (self.washroomCollocation != nil) {
    dictionary[kHotelRoomModelWashroomCollocation] = self.washroomCollocation;
  }
  if (self.wifiInfo != nil) { dictionary[kHotelRoomModelWifiInfo] = self.wifiInfo; }
  if (self.windows != nil) { dictionary[kHotelRoomModelWindows] = self.windows; }
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
  [aCoder encodeObject:@(self.avgGrade) forKey:kHotelRoomModelAvgGrade];
  if (self.bedInfo != nil) { [aCoder encodeObject:self.bedInfo forKey:kHotelRoomModelBedInfo]; }
  if (self.breakfast != nil) {
    [aCoder encodeObject:self.breakfast forKey:kHotelRoomModelBreakfast];
  }
  if (self.castPolicy != nil) {
    [aCoder encodeObject:self.castPolicy forKey:kHotelRoomModelCastPolicy];
  }
  if (self.convenienceFacilities != nil) {
    [aCoder encodeObject:self.convenienceFacilities forKey:kHotelRoomModelConvenienceFacilities];
  }
  if (self.createTime != nil) {
    [aCoder encodeObject:self.createTime forKey:kHotelRoomModelCreateTime];
  }
  if (self.creater != nil) { [aCoder encodeObject:self.creater forKey:kHotelRoomModelCreater]; }
  [aCoder encodeObject:@(self.facilitiesGrade) forKey:kHotelRoomModelFacilitiesGrade];
  [aCoder encodeObject:@(self.hotelId) forKey:kHotelRoomModelHotelId];
  [aCoder encodeObject:@(self.hygieneGrade) forKey:kHotelRoomModelHygieneGrade];
  [aCoder encodeObject:@(self.idField) forKey:kHotelRoomModelIdField];
  [aCoder encodeObject:@(self.locationGrade) forKey:kHotelRoomModelLocationGrade];
  if (self.membershipInterests != nil) {
    [aCoder encodeObject:self.membershipInterests forKey:kHotelRoomModelMembershipInterests];
  }
  if (self.roomArea != nil) { [aCoder encodeObject:self.roomArea forKey:kHotelRoomModelRoomArea]; }
  [aCoder encodeObject:@(self.roomCount) forKey:kHotelRoomModelRoomCount];
  if (self.roomDetails != nil) {
    [aCoder encodeObject:self.roomDetails forKey:kHotelRoomModelRoomDetails];
  }
  if (self.roomName != nil) { [aCoder encodeObject:self.roomName forKey:kHotelRoomModelRoomName]; }
  [aCoder encodeObject:@(self.roomOrgprice) forKey:kHotelRoomModelRoomOrgprice];
  [aCoder encodeObject:@(self.roomPrice) forKey:kHotelRoomModelRoomPrice];
  [aCoder encodeObject:@(self.roomSize) forKey:kHotelRoomModelRoomSize];
  [aCoder encodeObject:@(self.roomSpace) forKey:kHotelRoomModelRoomSpace];
  if (self.roomType != nil) { [aCoder encodeObject:self.roomType forKey:kHotelRoomModelRoomType]; }
  [aCoder encodeObject:@(self.serviceGrade) forKey:kHotelRoomModelServiceGrade];
  if (self.urlList != nil) { [aCoder encodeObject:self.urlList forKey:kHotelRoomModelUrlList]; }
  [aCoder encodeObject:@(self.userIntegral) forKey:kHotelRoomModelUserIntegral];
  if (self.washroomCollocation != nil) {
    [aCoder encodeObject:self.washroomCollocation forKey:kHotelRoomModelWashroomCollocation];
  }
  if (self.wifiInfo != nil) { [aCoder encodeObject:self.wifiInfo forKey:kHotelRoomModelWifiInfo]; }
  if (self.windows != nil) { [aCoder encodeObject:self.windows forKey:kHotelRoomModelWindows]; }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.avgGrade = [[aDecoder decodeObjectForKey:kHotelRoomModelAvgGrade] floatValue];
  self.bedInfo = [aDecoder decodeObjectForKey:kHotelRoomModelBedInfo];
  self.breakfast = [aDecoder decodeObjectForKey:kHotelRoomModelBreakfast];
  self.castPolicy = [aDecoder decodeObjectForKey:kHotelRoomModelCastPolicy];
  self.convenienceFacilities = [aDecoder decodeObjectForKey:kHotelRoomModelConvenienceFacilities];
  self.createTime = [aDecoder decodeObjectForKey:kHotelRoomModelCreateTime];
  self.creater = [aDecoder decodeObjectForKey:kHotelRoomModelCreater];
  self.facilitiesGrade = [[aDecoder decodeObjectForKey:kHotelRoomModelFacilitiesGrade] floatValue];
  self.hotelId = [[aDecoder decodeObjectForKey:kHotelRoomModelHotelId] integerValue];
  self.hygieneGrade = [[aDecoder decodeObjectForKey:kHotelRoomModelHygieneGrade] floatValue];
  self.idField = [[aDecoder decodeObjectForKey:kHotelRoomModelIdField] integerValue];
  self.locationGrade = [[aDecoder decodeObjectForKey:kHotelRoomModelLocationGrade] floatValue];
  self.membershipInterests = [aDecoder decodeObjectForKey:kHotelRoomModelMembershipInterests];
  self.roomArea = [aDecoder decodeObjectForKey:kHotelRoomModelRoomArea];
  self.roomCount = [[aDecoder decodeObjectForKey:kHotelRoomModelRoomCount] floatValue];
  self.roomDetails = [aDecoder decodeObjectForKey:kHotelRoomModelRoomDetails];
  self.roomName = [aDecoder decodeObjectForKey:kHotelRoomModelRoomName];
  self.roomOrgprice = [[aDecoder decodeObjectForKey:kHotelRoomModelRoomOrgprice] integerValue];
  self.roomPrice = [[aDecoder decodeObjectForKey:kHotelRoomModelRoomPrice] integerValue];
  self.roomSize = [[aDecoder decodeObjectForKey:kHotelRoomModelRoomSize] integerValue];
  self.roomSpace = [[aDecoder decodeObjectForKey:kHotelRoomModelRoomSpace] integerValue];
  self.roomType = [aDecoder decodeObjectForKey:kHotelRoomModelRoomType];
  self.serviceGrade = [[aDecoder decodeObjectForKey:kHotelRoomModelServiceGrade] floatValue];
  self.urlList = [aDecoder decodeObjectForKey:kHotelRoomModelUrlList];
  self.userIntegral = [[aDecoder decodeObjectForKey:kHotelRoomModelUserIntegral] integerValue];
  self.washroomCollocation = [aDecoder decodeObjectForKey:kHotelRoomModelWashroomCollocation];
  self.wifiInfo = [aDecoder decodeObjectForKey:kHotelRoomModelWifiInfo];
  self.windows = [aDecoder decodeObjectForKey:kHotelRoomModelWindows];
  return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
  HotelRoomModel *copy = [HotelRoomModel new];
  
  copy.avgGrade = self.avgGrade;
  copy.bedInfo = [self.bedInfo copy];
  copy.breakfast = [self.breakfast copy];
  copy.castPolicy = [self.castPolicy copy];
  copy.convenienceFacilities = [self.convenienceFacilities copy];
  copy.createTime = [self.createTime copy];
  copy.creater = [self.creater copy];
  copy.facilitiesGrade = self.facilitiesGrade;
  copy.hotelId = self.hotelId;
  copy.hygieneGrade = self.hygieneGrade;
  copy.idField = self.idField;
  copy.locationGrade = self.locationGrade;
  copy.membershipInterests = [self.membershipInterests copy];
  copy.roomArea = [self.roomArea copy];
  copy.roomCount = self.roomCount;
  copy.roomDetails = [self.roomDetails copy];
  copy.roomName = [self.roomName copy];
  copy.roomOrgprice = self.roomOrgprice;
  copy.roomPrice = self.roomPrice;
  copy.roomSize = self.roomSize;
  copy.roomSpace = self.roomSpace;
  copy.roomType = [self.roomType copy];
  copy.serviceGrade = self.serviceGrade;
  copy.urlList = [self.urlList copy];
  copy.userIntegral = self.userIntegral;
  copy.washroomCollocation = [self.washroomCollocation copy];
  copy.wifiInfo = [self.wifiInfo copy];
  copy.windows = [self.windows copy];
  
  return copy;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{ @"idField" : @"id" };
}
@end
