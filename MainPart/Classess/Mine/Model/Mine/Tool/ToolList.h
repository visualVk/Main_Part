#import <UIKit/UIKit.h>
#import "Tool.h"

@interface ToolList : NSObject

@property (nonatomic, strong) NSArray<Tool*> * tool;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
