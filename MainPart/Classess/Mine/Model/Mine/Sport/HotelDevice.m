//
//	HotelDevice.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HotelDevice.h"

NSString *const kHotelDeviceDevice = @"device";
NSString *const kHotelDeviceDeviceDescription = @"deviceDescription";
NSString *const kHotelDeviceEdDate = @"edDate";
NSString *const kHotelDeviceHotelId = @"hotelId";
NSString *const kHotelDeviceHotelName = @"hotelName";
NSString *const kHotelDeviceStDate = @"stDate";

@interface HotelDevice ()
@end
@implementation HotelDevice




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kHotelDeviceDevice] != nil && [dictionary[kHotelDeviceDevice] isKindOfClass:[NSArray class]]){
		NSArray * deviceDictionaries = dictionary[kHotelDeviceDevice];
		NSMutableArray * deviceItems = [NSMutableArray array];
		for(NSDictionary * deviceDictionary in deviceDictionaries){
			Device * deviceItem = [[Device alloc] initWithDictionary:deviceDictionary];
			[deviceItems addObject:deviceItem];
		}
		self.device = deviceItems;
	}
	if(![dictionary[kHotelDeviceDeviceDescription] isKindOfClass:[NSNull class]]){
		self.deviceDescription = dictionary[kHotelDeviceDeviceDescription];
	}	
	if(![dictionary[kHotelDeviceEdDate] isKindOfClass:[NSNull class]]){
		self.edDate = dictionary[kHotelDeviceEdDate];
	}	
	if(![dictionary[kHotelDeviceHotelId] isKindOfClass:[NSNull class]]){
		self.hotelId = [dictionary[kHotelDeviceHotelId] boolValue];
	}

	if(![dictionary[kHotelDeviceHotelName] isKindOfClass:[NSNull class]]){
		self.hotelName = dictionary[kHotelDeviceHotelName];
	}	
	if(![dictionary[kHotelDeviceStDate] isKindOfClass:[NSNull class]]){
		self.stDate = dictionary[kHotelDeviceStDate];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.device != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Device * deviceElement in self.device){
			[dictionaryElements addObject:[deviceElement toDictionary]];
		}
		dictionary[kHotelDeviceDevice] = dictionaryElements;
	}
	if(self.deviceDescription != nil){
		dictionary[kHotelDeviceDeviceDescription] = self.deviceDescription;
	}
	if(self.edDate != nil){
		dictionary[kHotelDeviceEdDate] = self.edDate;
	}
	dictionary[kHotelDeviceHotelId] = @(self.hotelId);
	if(self.hotelName != nil){
		dictionary[kHotelDeviceHotelName] = self.hotelName;
	}
	if(self.stDate != nil){
		dictionary[kHotelDeviceStDate] = self.stDate;
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
	if(self.device != nil){
		[aCoder encodeObject:self.device forKey:kHotelDeviceDevice];
	}
	if(self.deviceDescription != nil){
		[aCoder encodeObject:self.deviceDescription forKey:kHotelDeviceDeviceDescription];
	}
	if(self.edDate != nil){
		[aCoder encodeObject:self.edDate forKey:kHotelDeviceEdDate];
	}
	[aCoder encodeObject:@(self.hotelId) forKey:kHotelDeviceHotelId];	if(self.hotelName != nil){
		[aCoder encodeObject:self.hotelName forKey:kHotelDeviceHotelName];
	}
	if(self.stDate != nil){
		[aCoder encodeObject:self.stDate forKey:kHotelDeviceStDate];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.device = [aDecoder decodeObjectForKey:kHotelDeviceDevice];
	self.deviceDescription = [aDecoder decodeObjectForKey:kHotelDeviceDeviceDescription];
	self.edDate = [aDecoder decodeObjectForKey:kHotelDeviceEdDate];
	self.hotelId = [[aDecoder decodeObjectForKey:kHotelDeviceHotelId] boolValue];
	self.hotelName = [aDecoder decodeObjectForKey:kHotelDeviceHotelName];
	self.stDate = [aDecoder decodeObjectForKey:kHotelDeviceStDate];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	HotelDevice *copy = [HotelDevice new];

	copy.device = [self.device copy];
	copy.deviceDescription = [self.deviceDescription copy];
	copy.edDate = [self.edDate copy];
	copy.hotelId = self.hotelId;
	copy.hotelName = [self.hotelName copy];
	copy.stDate = [self.stDate copy];

	return copy;
}
@end