//
//	Title.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Title.h"

NSString *const kTitleString = @"String";
NSString *const kTitleIdField = @"id";

@interface Title ()
@end
@implementation Title




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTitleString] isKindOfClass:[NSNull class]]){
		self.string = dictionary[kTitleString];
	}	
	if(![dictionary[kTitleIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kTitleIdField] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.string != nil){
		dictionary[kTitleString] = self.string;
	}
	dictionary[kTitleIdField] = @(self.idField);
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
	if(self.string != nil){
		[aCoder encodeObject:self.string forKey:kTitleString];
	}
	[aCoder encodeObject:@(self.idField) forKey:kTitleIdField];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.string = [aDecoder decodeObjectForKey:kTitleString];
	self.idField = [[aDecoder decodeObjectForKey:kTitleIdField] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Title *copy = [Title new];

	copy.string = [self.string copy];
	copy.idField = self.idField;

	return copy;
}
@end