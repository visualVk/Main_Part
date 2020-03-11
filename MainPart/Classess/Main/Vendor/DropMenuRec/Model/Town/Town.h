#import <UIKit/UIKit.h>

@interface Town : NSObject

@property (nonatomic, strong) NSArray * child;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end