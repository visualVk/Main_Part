//
//  HotelDisscussList.m
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "HotelDisscussList.h"

NSString *const kHotelDisscussListContent = @"content";
NSString *const kHotelDisscussListCreateTime = @"createTime";
NSString *const kHotelDisscussListHotelId = @"hotelId";
NSString *const kHotelDisscussListIdField = @"id";
NSString *const kHotelDisscussListReplyEntities = @"replyEntities";
NSString *const kHotelDisscussListUserId = @"userId";
NSString *const kHotelDisscussListUsername = @"username";

@interface HotelDisscussList ()
@end
@implementation HotelDisscussList

+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"replyEntities" : [ReplyEntity class] };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{ @"idField" : @"id" };
}
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (![dictionary[kHotelDisscussListContent] isKindOfClass:[NSNull class]]) {
    self.content = dictionary[kHotelDisscussListContent];
  }
  if (![dictionary[kHotelDisscussListCreateTime] isKindOfClass:[NSNull class]]) {
    self.createTime = dictionary[kHotelDisscussListCreateTime];
  }
  if (![dictionary[kHotelDisscussListHotelId] isKindOfClass:[NSNull class]]) {
    self.hotelId = [dictionary[kHotelDisscussListHotelId] integerValue];
  }
  
  if (![dictionary[kHotelDisscussListIdField] isKindOfClass:[NSNull class]]) {
    self.idField = [dictionary[kHotelDisscussListIdField] integerValue];
  }
  
  if (dictionary[kHotelDisscussListReplyEntities] != nil &&
      [dictionary[kHotelDisscussListReplyEntities] isKindOfClass:[NSArray class]]) {
    NSArray *replyEntitiesDictionaries = dictionary[kHotelDisscussListReplyEntities];
    NSMutableArray *replyEntitiesItems = [NSMutableArray array];
    for (NSDictionary *replyEntitiesDictionary in replyEntitiesDictionaries) {
      ReplyEntity *replyEntitiesItem =
      [[ReplyEntity alloc] initWithDictionary:replyEntitiesDictionary];
      [replyEntitiesItems addObject:replyEntitiesItem];
    }
    self.replyEntities = replyEntitiesItems;
  }
  if (![dictionary[kHotelDisscussListUserId] isKindOfClass:[NSNull class]]) {
    self.userId = [dictionary[kHotelDisscussListUserId] integerValue];
  }
  
  if (![dictionary[kHotelDisscussListUsername] isKindOfClass:[NSNull class]]) {
    self.username = dictionary[kHotelDisscussListUsername];
  }
  return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the
 * approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  if (self.content != nil) { dictionary[kHotelDisscussListContent] = self.content; }
  if (self.createTime != nil) { dictionary[kHotelDisscussListCreateTime] = self.createTime; }
  dictionary[kHotelDisscussListHotelId] = @(self.hotelId);
  dictionary[kHotelDisscussListIdField] = @(self.idField);
  if (self.replyEntities != nil) {
    NSMutableArray *dictionaryElements = [NSMutableArray array];
    for (ReplyEntity *replyEntitiesElement in self.replyEntities) {
      [dictionaryElements addObject:[replyEntitiesElement toDictionary]];
    }
    dictionary[kHotelDisscussListReplyEntities] = dictionaryElements;
  }
  dictionary[kHotelDisscussListUserId] = @(self.userId);
  if (self.username != nil) { dictionary[kHotelDisscussListUsername] = self.username; }
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
  if (self.content != nil) { [aCoder encodeObject:self.content forKey:kHotelDisscussListContent]; }
  if (self.createTime != nil) {
    [aCoder encodeObject:self.createTime forKey:kHotelDisscussListCreateTime];
  }
  [aCoder encodeObject:@(self.hotelId) forKey:kHotelDisscussListHotelId];
  [aCoder encodeObject:@(self.idField) forKey:kHotelDisscussListIdField];
  if (self.replyEntities != nil) {
    [aCoder encodeObject:self.replyEntities forKey:kHotelDisscussListReplyEntities];
  }
  [aCoder encodeObject:@(self.userId) forKey:kHotelDisscussListUserId];
  if (self.username != nil) {
    [aCoder encodeObject:self.username forKey:kHotelDisscussListUsername];
  }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.content = [aDecoder decodeObjectForKey:kHotelDisscussListContent];
  self.createTime = [aDecoder decodeObjectForKey:kHotelDisscussListCreateTime];
  self.hotelId = [[aDecoder decodeObjectForKey:kHotelDisscussListHotelId] integerValue];
  self.idField = [[aDecoder decodeObjectForKey:kHotelDisscussListIdField] integerValue];
  self.replyEntities = [aDecoder decodeObjectForKey:kHotelDisscussListReplyEntities];
  self.userId = [[aDecoder decodeObjectForKey:kHotelDisscussListUserId] integerValue];
  self.username = [aDecoder decodeObjectForKey:kHotelDisscussListUsername];
  return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
  HotelDisscussList *copy = [HotelDisscussList new];
  
  copy.content = [self.content copy];
  copy.createTime = [self.createTime copy];
  copy.hotelId = self.hotelId;
  copy.idField = self.idField;
  copy.replyEntities = [self.replyEntities copy];
  copy.userId = self.userId;
  copy.username = [self.username copy];
  
  return copy;
}
@end
