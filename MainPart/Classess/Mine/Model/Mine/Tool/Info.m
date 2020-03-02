//
//	Info.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Info.h"

NSString *const kInfoAge = @"age";
NSString *const kInfoCountry = @"country";
NSString *const kInfoGender = @"gender";
NSString *const kInfoIdCard = @"idCard";
NSString *const kInfoName = @"name";
NSString *const kInfoPhone = @"phone";

@interface Info ()
@end
@implementation Info




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kInfoAge] isKindOfClass:[NSNull class]]){
		self.age = [dictionary[kInfoAge] integerValue];
	}

	if(![dictionary[kInfoCountry] isKindOfClass:[NSNull class]]){
		self.country = dictionary[kInfoCountry];
	}	
	if(![dictionary[kInfoGender] isKindOfClass:[NSNull class]]){
		self.gender = [dictionary[kInfoGender] integerValue];
	}

	if(![dictionary[kInfoIdCard] isKindOfClass:[NSNull class]]){
		self.idCard = dictionary[kInfoIdCard];
	}	
	if(![dictionary[kInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kInfoName];
	}	
	if(![dictionary[kInfoPhone] isKindOfClass:[NSNull class]]){
		self.phone = dictionary[kInfoPhone];
	}	
	return self;
}
@end