//
//	FoodList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FoodList.h"

NSString *const kFoodListFood = @"food";

@interface FoodList ()
@end
@implementation FoodList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kFoodListFood] != nil && [dictionary[kFoodListFood] isKindOfClass:[NSArray class]]){
		NSArray * foodDictionaries = dictionary[kFoodListFood];
		NSMutableArray * foodItems = [NSMutableArray array];
		for(NSDictionary * foodDictionary in foodDictionaries){
			Food * foodItem = [[Food alloc] initWithDictionary:foodDictionary];
			[foodItems addObject:foodItem];
		}
		self.food = foodItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.food != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Food * foodElement in self.food){
			[dictionaryElements addObject:[foodElement toDictionary]];
		}
		dictionary[kFoodListFood] = dictionaryElements;
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
	if(self.food != nil){
		[aCoder encodeObject:self.food forKey:kFoodListFood];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.food = [aDecoder decodeObjectForKey:kFoodListFood];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	FoodList *copy = [FoodList new];

	copy.food = [self.food copy];

	return copy;
}
@end