#import <UIKit/UIKit.h>

@interface Title : NSObject

@property (nonatomic, strong) NSString * string;
@property (nonatomic, assign) NSInteger idField;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end