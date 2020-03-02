//
//  ToolList.m
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "ToolList.h"

NSString *const kToolListTool = @"tool";

@interface ToolList ()
@end
@implementation ToolList

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (dictionary[kToolListTool] != nil &&
      [dictionary[kToolListTool] isKindOfClass:[NSArray class]]) {
    NSArray *toolDictionaries = dictionary[kToolListTool];
    NSMutableArray *toolItems = [NSMutableArray array];
    for (NSDictionary *toolDictionary in toolDictionaries) {
      Tool *toolItem = [[Tool alloc] initWithDictionary:toolDictionary];
      [toolItems addObject:toolItem];
    }
    self.tool = toolItems;
  }
  return self;
}

+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"tool" : [Tool class] };
}
@end
