//
//	LogList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LogList.h"

NSString *const kLogListLog = @"log";

@interface LogList ()
@end
@implementation LogList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kLogListLog] != nil && [dictionary[kLogListLog] isKindOfClass:[NSArray class]]){
		NSArray * logDictionaries = dictionary[kLogListLog];
		NSMutableArray * logItems = [NSMutableArray array];
		for(NSDictionary * logDictionary in logDictionaries){
			Log * logItem = [[Log alloc] initWithDictionary:logDictionary];
			[logItems addObject:logItem];
		}
		self.log = logItems;
	}
	return self;
}
@end