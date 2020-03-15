//
//	CheckInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CheckInfo.h"

NSString *const kCheckInfoPersonCard = @"personCard";
NSString *const kCheckInfoPersonName = @"personName";
NSString *const kCheckInfoRoomAddress = @"roomAddress";
NSString *const kCheckInfoRoomStatus = @"roomStatus";

@interface CheckInfo ()
@end
@implementation CheckInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCheckInfoPersonCard] isKindOfClass:[NSNull class]]){
		self.personCard = dictionary[kCheckInfoPersonCard];
	}	
	if(![dictionary[kCheckInfoPersonName] isKindOfClass:[NSNull class]]){
		self.personName = dictionary[kCheckInfoPersonName];
	}	
	if(![dictionary[kCheckInfoRoomAddress] isKindOfClass:[NSNull class]]){
		self.roomAddress = dictionary[kCheckInfoRoomAddress];
	}	
	if(![dictionary[kCheckInfoRoomStatus] isKindOfClass:[NSNull class]]){
		self.roomStatus = [dictionary[kCheckInfoRoomStatus] boolValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.personCard != nil){
		dictionary[kCheckInfoPersonCard] = self.personCard;
	}
	if(self.personName != nil){
		dictionary[kCheckInfoPersonName] = self.personName;
	}
	if(self.roomAddress != nil){
		dictionary[kCheckInfoRoomAddress] = self.roomAddress;
	}
	dictionary[kCheckInfoRoomStatus] = @(self.roomStatus);
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
	if(self.personCard != nil){
		[aCoder encodeObject:self.personCard forKey:kCheckInfoPersonCard];
	}
	if(self.personName != nil){
		[aCoder encodeObject:self.personName forKey:kCheckInfoPersonName];
	}
	if(self.roomAddress != nil){
		[aCoder encodeObject:self.roomAddress forKey:kCheckInfoRoomAddress];
	}
	[aCoder encodeObject:@(self.roomStatus) forKey:kCheckInfoRoomStatus];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.personCard = [aDecoder decodeObjectForKey:kCheckInfoPersonCard];
	self.personName = [aDecoder decodeObjectForKey:kCheckInfoPersonName];
	self.roomAddress = [aDecoder decodeObjectForKey:kCheckInfoRoomAddress];
	self.roomStatus = [[aDecoder decodeObjectForKey:kCheckInfoRoomStatus] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CheckInfo *copy = [CheckInfo new];

	copy.personCard = [self.personCard copy];
	copy.personName = [self.personName copy];
	copy.roomAddress = [self.roomAddress copy];
	copy.roomStatus = self.roomStatus;

	return copy;
}
@end