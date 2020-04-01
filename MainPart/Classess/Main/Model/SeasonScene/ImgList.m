//
//	ImgList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ImgList.h"

NSString *const kImgListImgId = @"imgId";
NSString *const kImgListImgName = @"imgName";
NSString *const kImgListImgUrl = @"imgUrl";

@interface ImgList ()
@end
@implementation ImgList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kImgListImgId] isKindOfClass:[NSNull class]]){
		self.imgId = [dictionary[kImgListImgId] integerValue];
	}

	if(![dictionary[kImgListImgName] isKindOfClass:[NSNull class]]){
		self.imgName = dictionary[kImgListImgName];
	}	
	if(![dictionary[kImgListImgUrl] isKindOfClass:[NSNull class]]){
		self.imgUrl = dictionary[kImgListImgUrl];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kImgListImgId] = @(self.imgId);
	if(self.imgName != nil){
		dictionary[kImgListImgName] = self.imgName;
	}
	if(self.imgUrl != nil){
		dictionary[kImgListImgUrl] = self.imgUrl;
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
	[aCoder encodeObject:@(self.imgId) forKey:kImgListImgId];	if(self.imgName != nil){
		[aCoder encodeObject:self.imgName forKey:kImgListImgName];
	}
	if(self.imgUrl != nil){
		[aCoder encodeObject:self.imgUrl forKey:kImgListImgUrl];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.imgId = [[aDecoder decodeObjectForKey:kImgListImgId] integerValue];
	self.imgName = [aDecoder decodeObjectForKey:kImgListImgName];
	self.imgUrl = [aDecoder decodeObjectForKey:kImgListImgUrl];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ImgList *copy = [ImgList new];

	copy.imgId = self.imgId;
	copy.imgName = [self.imgName copy];
	copy.imgUrl = [self.imgUrl copy];

	return copy;
}
@end