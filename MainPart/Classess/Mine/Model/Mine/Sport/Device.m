//
//	Device.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Device.h"

NSString *const kDeviceDeviceID = @"deviceID";
NSString *const kDeviceDeviceName = @"deviceName";
NSString *const kDeviceDeviceNum = @"deviceNum";
NSString *const kDeviceDeviceUsedNum = @"deviceUsedNum";

@interface Device ()
@end
@implementation Device




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDeviceDeviceID] isKindOfClass:[NSNull class]]){
		self.deviceID = [dictionary[kDeviceDeviceID] integerValue];
	}

	if(![dictionary[kDeviceDeviceName] isKindOfClass:[NSNull class]]){
		self.deviceName = dictionary[kDeviceDeviceName];
	}	
	if(![dictionary[kDeviceDeviceNum] isKindOfClass:[NSNull class]]){
		self.deviceNum = [dictionary[kDeviceDeviceNum] integerValue];
	}

	if(![dictionary[kDeviceDeviceUsedNum] isKindOfClass:[NSNull class]]){
		self.deviceUsedNum = [dictionary[kDeviceDeviceUsedNum] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kDeviceDeviceID] = @(self.deviceID);
	if(self.deviceName != nil){
		dictionary[kDeviceDeviceName] = self.deviceName;
	}
	dictionary[kDeviceDeviceNum] = @(self.deviceNum);
	dictionary[kDeviceDeviceUsedNum] = @(self.deviceUsedNum);
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
	[aCoder encodeObject:@(self.deviceID) forKey:kDeviceDeviceID];	if(self.deviceName != nil){
		[aCoder encodeObject:self.deviceName forKey:kDeviceDeviceName];
	}
	[aCoder encodeObject:@(self.deviceNum) forKey:kDeviceDeviceNum];	[aCoder encodeObject:@(self.deviceUsedNum) forKey:kDeviceDeviceUsedNum];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.deviceID = [[aDecoder decodeObjectForKey:kDeviceDeviceID] integerValue];
	self.deviceName = [aDecoder decodeObjectForKey:kDeviceDeviceName];
	self.deviceNum = [[aDecoder decodeObjectForKey:kDeviceDeviceNum] integerValue];
	self.deviceUsedNum = [[aDecoder decodeObjectForKey:kDeviceDeviceUsedNum] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Device *copy = [Device new];

	copy.deviceID = self.deviceID;
	copy.deviceName = [self.deviceName copy];
	copy.deviceNum = self.deviceNum;
	copy.deviceUsedNum = self.deviceUsedNum;

	return copy;
}
@end