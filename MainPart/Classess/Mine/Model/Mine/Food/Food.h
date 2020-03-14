#import <UIKit/UIKit.h>

@interface Food : NSObject

@property (nonatomic, strong) NSString * foodDescription;
@property (nonatomic, strong) NSString * foodName;
@property (nonatomic, assign) NSInteger foodNum;
@property (nonatomic, strong) NSString * foodPrice;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * typeName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end