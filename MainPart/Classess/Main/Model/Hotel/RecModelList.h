#import <UIKit/UIKit.h>
#import "RecList.h"

@interface RecModelList : NSObject

@property (nonatomic, strong) NSArray * recList;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end