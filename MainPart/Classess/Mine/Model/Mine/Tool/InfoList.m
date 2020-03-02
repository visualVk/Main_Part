//
//	InfoList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "InfoList.h"

NSString *const kInfoListInfo = @"info";

@interface InfoList ()
@end
@implementation InfoList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kInfoListInfo] != nil && [dictionary[kInfoListInfo] isKindOfClass:[NSArray class]]){
		NSArray * infoDictionaries = dictionary[kInfoListInfo];
		NSMutableArray * infoItems = [NSMutableArray array];
		for(NSDictionary * infoDictionary in infoDictionaries){
			Info * infoItem = [[Info alloc] initWithDictionary:infoDictionary];
			[infoItems addObject:infoItem];
		}
		self.info = infoItems;
	}
	return self;
}
@end
