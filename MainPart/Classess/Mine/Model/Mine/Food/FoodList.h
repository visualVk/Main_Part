#import <UIKit/UIKit.h>
#import "Food.h"

@interface FoodList : NSObject

@property (nonatomic, strong) NSArray * food;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end