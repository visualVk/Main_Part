//
//	RankList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RankList.h"

NSString *const kRankListRank = @"rank";

@interface RankList ()
@end
@implementation RankList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kRankListRank] != nil && [dictionary[kRankListRank] isKindOfClass:[NSArray class]]){
		NSArray * rankDictionaries = dictionary[kRankListRank];
		NSMutableArray * rankItems = [NSMutableArray array];
		for(NSDictionary * rankDictionary in rankDictionaries){
			Rank * rankItem = [[Rank alloc] initWithDictionary:rankDictionary];
			[rankItems addObject:rankItem];
		}
		self.rank = rankItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.rank != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Rank * rankElement in self.rank){
			[dictionaryElements addObject:[rankElement toDictionary]];
		}
		dictionary[kRankListRank] = dictionaryElements;
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
	if(self.rank != nil){
		[aCoder encodeObject:self.rank forKey:kRankListRank];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.rank = [aDecoder decodeObjectForKey:kRankListRank];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	RankList *copy = [RankList new];

	copy.rank = [self.rank copy];

	return copy;
}
@end