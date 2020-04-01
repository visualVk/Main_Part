//
//	RecModelList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RecModelList.h"

NSString *const kRecModelListRecList = @"recList";

@interface RecModelList ()
@end
@implementation RecModelList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kRecModelListRecList] != nil && [dictionary[kRecModelListRecList] isKindOfClass:[NSArray class]]){
		NSArray * recListDictionaries = dictionary[kRecModelListRecList];
		NSMutableArray * recListItems = [NSMutableArray array];
		for(NSDictionary * recListDictionary in recListDictionaries){
			RecList * recListItem = [[RecList alloc] initWithDictionary:recListDictionary];
			[recListItems addObject:recListItem];
		}
		self.recList = recListItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.recList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(RecList * recListElement in self.recList){
			[dictionaryElements addObject:[recListElement toDictionary]];
		}
		dictionary[kRecModelListRecList] = dictionaryElements;
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
	if(self.recList != nil){
		[aCoder encodeObject:self.recList forKey:kRecModelListRecList];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.recList = [aDecoder decodeObjectForKey:kRecModelListRecList];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	RecModelList *copy = [RecModelList new];

	copy.recList = [self.recList copy];

	return copy;
}
@end