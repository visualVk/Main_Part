#import "ImgList.h"
#import <UIKit/UIKit.h>

@interface SeasonSceneModelList : NSObject

@property (nonatomic, strong) NSArray<ImgList *> *imgList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
