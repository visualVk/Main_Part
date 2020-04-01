#import <UIKit/UIKit.h>

@interface RecList : NSObject

@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, assign) NSInteger recId;
@property (nonatomic, strong) NSString * subTitle;
@property (nonatomic, strong) NSString * titleName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end