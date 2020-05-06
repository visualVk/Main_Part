//
//	ReplyEntity.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ReplyEntity.h"

NSString *const kReplyEntityContent = @"content";
NSString *const kReplyEntityCreateTime = @"createTime";
NSString *const kReplyEntityDeleted = @"deleted";
NSString *const kReplyEntityHotelId = @"hotelId";
NSString *const kReplyEntityIdField = @"id";
NSString *const kReplyEntityToId = @"toId";
NSString *const kReplyEntityUserId = @"userId";
NSString *const kReplyEntityUsername = @"username";

@interface ReplyEntity ()
@end
@implementation ReplyEntity




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kReplyEntityContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kReplyEntityContent];
	}	
	if(![dictionary[kReplyEntityCreateTime] isKindOfClass:[NSNull class]]){
		self.createTime = dictionary[kReplyEntityCreateTime];
	}	
	if(![dictionary[kReplyEntityDeleted] isKindOfClass:[NSNull class]]){
		self.deleted = [dictionary[kReplyEntityDeleted] integerValue];
	}

	if(![dictionary[kReplyEntityHotelId] isKindOfClass:[NSNull class]]){
		self.hotelId = [dictionary[kReplyEntityHotelId] integerValue];
	}

	if(![dictionary[kReplyEntityIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kReplyEntityIdField] integerValue];
	}

	if(![dictionary[kReplyEntityToId] isKindOfClass:[NSNull class]]){
		self.toId = [dictionary[kReplyEntityToId] integerValue];
	}

	if(![dictionary[kReplyEntityUserId] isKindOfClass:[NSNull class]]){
		self.userId = [dictionary[kReplyEntityUserId] integerValue];
	}

	if(![dictionary[kReplyEntityUsername] isKindOfClass:[NSNull class]]){
		self.username = dictionary[kReplyEntityUsername];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.content != nil){
		dictionary[kReplyEntityContent] = self.content;
	}
	if(self.createTime != nil){
		dictionary[kReplyEntityCreateTime] = self.createTime;
	}
	dictionary[kReplyEntityDeleted] = @(self.deleted);
	dictionary[kReplyEntityHotelId] = @(self.hotelId);
	dictionary[kReplyEntityIdField] = @(self.idField);
	dictionary[kReplyEntityToId] = @(self.toId);
	dictionary[kReplyEntityUserId] = @(self.userId);
	if(self.username != nil){
		dictionary[kReplyEntityUsername] = self.username;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kReplyEntityContent];
	}
	if(self.createTime != nil){
		[aCoder encodeObject:self.createTime forKey:kReplyEntityCreateTime];
	}
	[aCoder encodeObject:@(self.deleted) forKey:kReplyEntityDeleted];	[aCoder encodeObject:@(self.hotelId) forKey:kReplyEntityHotelId];	[aCoder encodeObject:@(self.idField) forKey:kReplyEntityIdField];	[aCoder encodeObject:@(self.toId) forKey:kReplyEntityToId];	[aCoder encodeObject:@(self.userId) forKey:kReplyEntityUserId];	if(self.username != nil){
		[aCoder encodeObject:self.username forKey:kReplyEntityUsername];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.content = [aDecoder decodeObjectForKey:kReplyEntityContent];
	self.createTime = [aDecoder decodeObjectForKey:kReplyEntityCreateTime];
	self.deleted = [[aDecoder decodeObjectForKey:kReplyEntityDeleted] integerValue];
	self.hotelId = [[aDecoder decodeObjectForKey:kReplyEntityHotelId] integerValue];
	self.idField = [[aDecoder decodeObjectForKey:kReplyEntityIdField] integerValue];
	self.toId = [[aDecoder decodeObjectForKey:kReplyEntityToId] integerValue];
	self.userId = [[aDecoder decodeObjectForKey:kReplyEntityUserId] integerValue];
	self.username = [aDecoder decodeObjectForKey:kReplyEntityUsername];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ReplyEntity *copy = [ReplyEntity new];

	copy.content = [self.content copy];
	copy.createTime = [self.createTime copy];
	copy.deleted = self.deleted;
	copy.hotelId = self.hotelId;
	copy.idField = self.idField;
	copy.toId = self.toId;
	copy.userId = self.userId;
	copy.username = [self.username copy];

	return copy;
}
@end