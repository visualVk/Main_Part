#import <UIKit/UIKit.h>

@interface CheckInfo : NSObject

@property (nonatomic, strong) NSString * personCard;
@property (nonatomic, strong) NSString * personName;
@property (nonatomic, strong) NSString * roomAddress;
@property (nonatomic, assign) BOOL roomStatus;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end