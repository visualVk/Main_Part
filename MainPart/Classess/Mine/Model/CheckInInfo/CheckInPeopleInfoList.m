//
//	CheckInPeopleInfoList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CheckInPeopleInfoList.h"

NSString *const kCheckInPeopleInfoListInfo = @"info";

@interface CheckInPeopleInfoList ()
@end
@implementation CheckInPeopleInfoList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kCheckInPeopleInfoListInfo] != nil && [dictionary[kCheckInPeopleInfoListInfo] isKindOfClass:[NSArray class]]){
		NSArray * infoDictionaries = dictionary[kCheckInPeopleInfoListInfo];
		NSMutableArray * infoItems = [NSMutableArray array];
		for(NSDictionary * infoDictionary in infoDictionaries){
			Info * infoItem = [[Info alloc] initWithDictionary:infoDictionary];
			[infoItems addObject:infoItem];
		}
		self.info = infoItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.info != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Info * infoElement in self.info){
			[dictionaryElements addObject:[infoElement toDictionary]];
		}
		dictionary[kCheckInPeopleInfoListInfo] = dictionaryElements;
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
	if(self.info != nil){
		[aCoder encodeObject:self.info forKey:kCheckInPeopleInfoListInfo];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.info = [aDecoder decodeObjectForKey:kCheckInPeopleInfoListInfo];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CheckInPeopleInfoList *copy = [CheckInPeopleInfoList new];

	copy.info = [self.info copy];

	return copy;
}
@end