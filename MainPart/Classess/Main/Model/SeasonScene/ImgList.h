#import <UIKit/UIKit.h>

@interface ImgList : NSObject

@property (nonatomic, assign) NSInteger imgId;
@property (nonatomic, strong) NSString * imgName;
@property (nonatomic, strong) NSString * imgUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end