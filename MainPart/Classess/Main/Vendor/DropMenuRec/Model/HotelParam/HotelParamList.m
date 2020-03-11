//
//	HotelParamList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HotelParamList.h"

NSString *const kHotelParamListHotelParam = @"hotelParam";

@interface HotelParamList ()
@end
@implementation HotelParamList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kHotelParamListHotelParam] != nil && [dictionary[kHotelParamListHotelParam] isKindOfClass:[NSArray class]]){
		NSArray * hotelParamDictionaries = dictionary[kHotelParamListHotelParam];
		NSMutableArray * hotelParamItems = [NSMutableArray array];
		for(NSDictionary * hotelParamDictionary in hotelParamDictionaries){
			HotelParam * hotelParamItem = [[HotelParam alloc] initWithDictionary:hotelParamDictionary];
			[hotelParamItems addObject:hotelParamItem];
		}
		self.hotelParam = hotelParamItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.hotelParam != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(HotelParam * hotelParamElement in self.hotelParam){
			[dictionaryElements addObject:[hotelParamElement toDictionary]];
		}
		dictionary[kHotelParamListHotelParam] = dictionaryElements;
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
	if(self.hotelParam != nil){
		[aCoder encodeObject:self.hotelParam forKey:kHotelParamListHotelParam];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.hotelParam = [aDecoder decodeObjectForKey:kHotelParamListHotelParam];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	HotelParamList *copy = [HotelParamList new];

	copy.hotelParam = [self.hotelParam copy];

	return copy;
}
@end