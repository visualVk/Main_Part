//
//	Log.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Log.h"

NSString *const kLogImageList = @"imageList";
NSString *const kLogLog = @"log";

@interface Log ()
@end
@implementation Log




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLogImageList] isKindOfClass:[NSNull class]]){
		self.imageList = dictionary[kLogImageList];
	}	
	if(![dictionary[kLogLog] isKindOfClass:[NSNull class]]){
		self.log = dictionary[kLogLog];
	}	
	return self;
}
@end