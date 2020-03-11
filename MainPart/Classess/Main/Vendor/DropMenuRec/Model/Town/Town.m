//
//	Town.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Town.h"

NSString *const kTownChild = @"child";
NSString *const kTownName = @"name";

@interface Town ()
@end
@implementation Town




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTownChild] isKindOfClass:[NSNull class]]){
		self.child = dictionary[kTownChild];
	}	
	if(![dictionary[kTownName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kTownName];
	}	
	return self;
}
@end