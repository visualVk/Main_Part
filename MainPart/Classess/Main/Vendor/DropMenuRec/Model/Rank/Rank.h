#import <UIKit/UIKit.h>

@interface Rank : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
