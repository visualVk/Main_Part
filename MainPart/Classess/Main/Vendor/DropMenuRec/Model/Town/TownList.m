//
//	TownList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TownList.h"

NSString *const kTownListTown = @"town";

@interface TownList ()
@end
@implementation TownList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kTownListTown] != nil && [dictionary[kTownListTown] isKindOfClass:[NSArray class]]){
		NSArray * townDictionaries = dictionary[kTownListTown];
		NSMutableArray * townItems = [NSMutableArray array];
		for(NSDictionary * townDictionary in townDictionaries){
			Town * townItem = [[Town alloc] initWithDictionary:townDictionary];
			[townItems addObject:townItem];
		}
		self.town = townItems;
	}
	return self;
}
@end