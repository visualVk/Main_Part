#import <UIKit/UIKit.h>

@interface Info : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString * idCard;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phone;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end