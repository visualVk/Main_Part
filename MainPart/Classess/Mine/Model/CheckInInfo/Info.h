#import <UIKit/UIKit.h>

@interface Info : NSObject

@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, assign) BOOL gender;
@property (nonatomic, strong) NSString * idCard;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phoneNum;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end