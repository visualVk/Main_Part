#import <UIKit/UIKit.h>

@interface Device : NSObject

@property (nonatomic, assign) NSInteger deviceID;
@property (nonatomic, strong) NSString * deviceName;
@property (nonatomic, assign) NSInteger deviceNum;
@property (nonatomic, assign) NSInteger deviceUsedNum;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end