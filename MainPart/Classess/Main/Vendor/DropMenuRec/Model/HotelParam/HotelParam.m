//
//	HotelParam.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HotelParam.h"

NSString *const kHotelParamIsMuti = @"isMuti";
NSString *const kHotelParamParam = @"param";
NSString *const kHotelParamTitle = @"title";
NSString *const kHotelParamType = @"type";

@interface HotelParam ()
@end
@implementation HotelParam




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kHotelParamIsMuti] isKindOfClass:[NSNull class]]){
		self.isMuti = [dictionary[kHotelParamIsMuti] boolValue];
	}

	if(![dictionary[kHotelParamParam] isKindOfClass:[NSNull class]]){
		self.param = dictionary[kHotelParamParam];
	}	
	if(dictionary[kHotelParamTitle] != nil && [dictionary[kHotelParamTitle] isKindOfClass:[NSArray class]]){
		NSArray * titleDictionaries = dictionary[kHotelParamTitle];
		NSMutableArray * titleItems = [NSMutableArray array];
		for(NSDictionary * titleDictionary in titleDictionaries){
			Title * titleItem = [[Title alloc] initWithDictionary:titleDictionary];
			[titleItems addObject:titleItem];
		}
		self.title = titleItems;
	}
	if(![dictionary[kHotelParamType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kHotelParamType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kHotelParamIsMuti] = @(self.isMuti);
	if(self.param != nil){
		dictionary[kHotelParamParam] = self.param;
	}
	if(self.title != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Title * titleElement in self.title){
			[dictionaryElements addObject:[titleElement toDictionary]];
		}
		dictionary[kHotelParamTitle] = dictionaryElements;
	}
	if(self.type != nil){
		dictionary[kHotelParamType] = self.type;
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
	[aCoder encodeObject:@(self.isMuti) forKey:kHotelParamIsMuti];	if(self.param != nil){
		[aCoder encodeObject:self.param forKey:kHotelParamParam];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kHotelParamTitle];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kHotelParamType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isMuti = [[aDecoder decodeObjectForKey:kHotelParamIsMuti] boolValue];
	self.param = [aDecoder decodeObjectForKey:kHotelParamParam];
	self.title = [aDecoder decodeObjectForKey:kHotelParamTitle];
	self.type = [aDecoder decodeObjectForKey:kHotelParamType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	HotelParam *copy = [HotelParam new];

	copy.isMuti = self.isMuti;
	copy.param = [self.param copy];
	copy.title = [self.title copy];
	copy.type = [self.type copy];

	return copy;
}
@end