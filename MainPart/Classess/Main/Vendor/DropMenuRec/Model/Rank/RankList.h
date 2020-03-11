#import <UIKit/UIKit.h>
#import "Rank.h"

@interface RankList : NSObject

@property (nonatomic, strong) NSArray * rank;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end