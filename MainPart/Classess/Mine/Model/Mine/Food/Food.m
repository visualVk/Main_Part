//
//	Food.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Food.h"

NSString *const kFoodFoodDescription = @"foodDescription";
NSString *const kFoodFoodName = @"foodName";
NSString *const kFoodFoodNum = @"foodNum";
NSString *const kFoodFoodPrice = @"foodPrice";
NSString *const kFoodType = @"type";
NSString *const kFoodTypeName = @"typeName";

@interface Food ()
@end
@implementation Food




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kFoodFoodDescription] isKindOfClass:[NSNull class]]){
		self.foodDescription = dictionary[kFoodFoodDescription];
	}	
	if(![dictionary[kFoodFoodName] isKindOfClass:[NSNull class]]){
		self.foodName = dictionary[kFoodFoodName];
	}	
	if(![dictionary[kFoodFoodNum] isKindOfClass:[NSNull class]]){
		self.foodNum = [dictionary[kFoodFoodNum] integerValue];
	}

	if(![dictionary[kFoodFoodPrice] isKindOfClass:[NSNull class]]){
		self.foodPrice = dictionary[kFoodFoodPrice];
	}	
	if(![dictionary[kFoodType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kFoodType] integerValue];
	}

	if(![dictionary[kFoodTypeName] isKindOfClass:[NSNull class]]){
		self.typeName = dictionary[kFoodTypeName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.foodDescription != nil){
		dictionary[kFoodFoodDescription] = self.foodDescription;
	}
	if(self.foodName != nil){
		dictionary[kFoodFoodName] = self.foodName;
	}
	dictionary[kFoodFoodNum] = @(self.foodNum);
	if(self.foodPrice != nil){
		dictionary[kFoodFoodPrice] = self.foodPrice;
	}
	dictionary[kFoodType] = @(self.type);
	if(self.typeName != nil){
		dictionary[kFoodTypeName] = self.typeName;
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
	if(self.foodDescription != nil){
		[aCoder encodeObject:self.foodDescription forKey:kFoodFoodDescription];
	}
	if(self.foodName != nil){
		[aCoder encodeObject:self.foodName forKey:kFoodFoodName];
	}
	[aCoder encodeObject:@(self.foodNum) forKey:kFoodFoodNum];	if(self.foodPrice != nil){
		[aCoder encodeObject:self.foodPrice forKey:kFoodFoodPrice];
	}
	[aCoder encodeObject:@(self.type) forKey:kFoodType];	if(self.typeName != nil){
		[aCoder encodeObject:self.typeName forKey:kFoodTypeName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.foodDescription = [aDecoder decodeObjectForKey:kFoodFoodDescription];
	self.foodName = [aDecoder decodeObjectForKey:kFoodFoodName];
	self.foodNum = [[aDecoder decodeObjectForKey:kFoodFoodNum] integerValue];
	self.foodPrice = [aDecoder decodeObjectForKey:kFoodFoodPrice];
	self.type = [[aDecoder decodeObjectForKey:kFoodType] integerValue];
	self.typeName = [aDecoder decodeObjectForKey:kFoodTypeName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Food *copy = [Food new];

	copy.foodDescription = [self.foodDescription copy];
	copy.foodName = [self.foodName copy];
	copy.foodNum = self.foodNum;
	copy.foodPrice = [self.foodPrice copy];
	copy.type = self.type;
	copy.typeName = [self.typeName copy];

	return copy;
}
@end