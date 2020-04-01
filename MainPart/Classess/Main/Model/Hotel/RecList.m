//
//	RecList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RecList.h"

NSString *const kRecListImgUrl = @"imgUrl";
NSString *const kRecListRecId = @"recId";
NSString *const kRecListSubTitle = @"subTitle";
NSString *const kRecListTitleName = @"titleName";

@interface RecList ()
@end
@implementation RecList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kRecListImgUrl] isKindOfClass:[NSNull class]]){
		self.imgUrl = dictionary[kRecListImgUrl];
	}	
	if(![dictionary[kRecListRecId] isKindOfClass:[NSNull class]]){
		self.recId = [dictionary[kRecListRecId] integerValue];
	}

	if(![dictionary[kRecListSubTitle] isKindOfClass:[NSNull class]]){
		self.subTitle = dictionary[kRecListSubTitle];
	}	
	if(![dictionary[kRecListTitleName] isKindOfClass:[NSNull class]]){
		self.titleName = dictionary[kRecListTitleName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.imgUrl != nil){
		dictionary[kRecListImgUrl] = self.imgUrl;
	}
	dictionary[kRecListRecId] = @(self.recId);
	if(self.subTitle != nil){
		dictionary[kRecListSubTitle] = self.subTitle;
	}
	if(self.titleName != nil){
		dictionary[kRecListTitleName] = self.titleName;
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
	if(self.imgUrl != nil){
		[aCoder encodeObject:self.imgUrl forKey:kRecListImgUrl];
	}
	[aCoder encodeObject:@(self.recId) forKey:kRecListRecId];	if(self.subTitle != nil){
		[aCoder encodeObject:self.subTitle forKey:kRecListSubTitle];
	}
	if(self.titleName != nil){
		[aCoder encodeObject:self.titleName forKey:kRecListTitleName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.imgUrl = [aDecoder decodeObjectForKey:kRecListImgUrl];
	self.recId = [[aDecoder decodeObjectForKey:kRecListRecId] integerValue];
	self.subTitle = [aDecoder decodeObjectForKey:kRecListSubTitle];
	self.titleName = [aDecoder decodeObjectForKey:kRecListTitleName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	RecList *copy = [RecList new];

	copy.imgUrl = [self.imgUrl copy];
	copy.recId = self.recId;
	copy.subTitle = [self.subTitle copy];
	copy.titleName = [self.titleName copy];

	return copy;
}
@end