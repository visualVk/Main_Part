//
//	Tool.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Tool.h"

NSString *const kToolImage = @"image";
NSString *const kToolTitle = @"title";

@interface Tool ()
@end
@implementation Tool




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kToolImage] isKindOfClass:[NSNull class]]){
		self.image = dictionary[kToolImage];
	}	
	if(![dictionary[kToolTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kToolTitle];
	}	
	return self;
}
@end