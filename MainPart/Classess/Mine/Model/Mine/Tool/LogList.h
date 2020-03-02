#import <UIKit/UIKit.h>
#import "Log.h"

@interface LogList : NSObject

@property (nonatomic, strong) NSArray * log;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end