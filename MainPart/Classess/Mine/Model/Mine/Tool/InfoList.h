#import <UIKit/UIKit.h>
#import "Info.h"

@interface InfoList : NSObject

@property (nonatomic, strong) NSArray * info;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
