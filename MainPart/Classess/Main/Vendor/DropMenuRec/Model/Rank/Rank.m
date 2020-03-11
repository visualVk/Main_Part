//
//	Rank.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Rank.h"

NSString *const kRankTitle = @"title";
NSString *const kRankType = @"type";

@interface Rank ()
@end
@implementation Rank




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kRankTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kRankTitle];
	}	
	if(![dictionary[kRankType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kRankType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.title != nil){
		dictionary[kRankTitle] = self.title;
	}
	dictionary[kRankType] = @(self.type);
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
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kRankTitle];
	}
	[aCoder encodeObject:@(self.type) forKey:kRankType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.title = [aDecoder decodeObjectForKey:kRankTitle];
	self.type = [[aDecoder decodeObjectForKey:kRankType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Rank *copy = [Rank new];

	copy.title = [self.title copy];
	copy.type = self.type;

	return copy;
}
@end