#import <UIKit/UIKit.h>
#import "Town.h"

@interface TownList : NSObject

@property (nonatomic, strong) NSArray * town;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end