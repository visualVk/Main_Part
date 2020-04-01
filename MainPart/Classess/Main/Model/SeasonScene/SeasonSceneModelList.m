//
//	SeasonSceneModelList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "SeasonSceneModelList.h"

NSString *const kSeasonSceneModelListImgList = @"imgList";

@interface SeasonSceneModelList ()
@end
@implementation SeasonSceneModelList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kSeasonSceneModelListImgList] != nil && [dictionary[kSeasonSceneModelListImgList] isKindOfClass:[NSArray class]]){
		NSArray * imgListDictionaries = dictionary[kSeasonSceneModelListImgList];
		NSMutableArray * imgListItems = [NSMutableArray array];
		for(NSDictionary * imgListDictionary in imgListDictionaries){
			ImgList * imgListItem = [[ImgList alloc] initWithDictionary:imgListDictionary];
			[imgListItems addObject:imgListItem];
		}
		self.imgList = imgListItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.imgList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ImgList * imgListElement in self.imgList){
			[dictionaryElements addObject:[imgListElement toDictionary]];
		}
		dictionary[kSeasonSceneModelListImgList] = dictionaryElements;
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
	if(self.imgList != nil){
		[aCoder encodeObject:self.imgList forKey:kSeasonSceneModelListImgList];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.imgList = [aDecoder decodeObjectForKey:kSeasonSceneModelListImgList];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	SeasonSceneModelList *copy = [SeasonSceneModelList new];

	copy.imgList = [self.imgList copy];

	return copy;
}
@end