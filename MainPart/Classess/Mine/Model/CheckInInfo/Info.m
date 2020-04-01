//
//	Info.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Info.h"

NSString *const kInfoBirthday = @"birthday";
NSString *const kInfoGender = @"gender";
NSString *const kInfoIdCard = @"idCard";
NSString *const kInfoName = @"name";
NSString *const kInfoPhoneNum = @"phoneNum";

@interface Info ()
@end
@implementation Info




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kInfoBirthday] isKindOfClass:[NSNull class]]){
		self.birthday = dictionary[kInfoBirthday];
	}	
	if(![dictionary[kInfoGender] isKindOfClass:[NSNull class]]){
		self.gender = [dictionary[kInfoGender] boolValue];
	}

	if(![dictionary[kInfoIdCard] isKindOfClass:[NSNull class]]){
		self.idCard = dictionary[kInfoIdCard];
	}	
	if(![dictionary[kInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kInfoName];
	}	
	if(![dictionary[kInfoPhoneNum] isKindOfClass:[NSNull class]]){
		self.phoneNum = dictionary[kInfoPhoneNum];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.birthday != nil){
		dictionary[kInfoBirthday] = self.birthday;
	}
	dictionary[kInfoGender] = @(self.gender);
	if(self.idCard != nil){
		dictionary[kInfoIdCard] = self.idCard;
	}
	if(self.name != nil){
		dictionary[kInfoName] = self.name;
	}
	if(self.phoneNum != nil){
		dictionary[kInfoPhoneNum] = self.phoneNum;
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
	if(self.birthday != nil){
		[aCoder encodeObject:self.birthday forKey:kInfoBirthday];
	}
	[aCoder encodeObject:@(self.gender) forKey:kInfoGender];	if(self.idCard != nil){
		[aCoder encodeObject:self.idCard forKey:kInfoIdCard];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kInfoName];
	}
	if(self.phoneNum != nil){
		[aCoder encodeObject:self.phoneNum forKey:kInfoPhoneNum];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.birthday = [aDecoder decodeObjectForKey:kInfoBirthday];
	self.gender = [[aDecoder decodeObjectForKey:kInfoGender] boolValue];
	self.idCard = [aDecoder decodeObjectForKey:kInfoIdCard];
	self.name = [aDecoder decodeObjectForKey:kInfoName];
	self.phoneNum = [aDecoder decodeObjectForKey:kInfoPhoneNum];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Info *copy = [Info new];

	copy.birthday = [self.birthday copy];
	copy.gender = self.gender;
	copy.idCard = [self.idCard copy];
	copy.name = [self.name copy];
	copy.phoneNum = [self.phoneNum copy];

	return copy;
}
@end