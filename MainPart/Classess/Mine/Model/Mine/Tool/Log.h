#import <UIKit/UIKit.h>

@interface Log : NSObject

@property (nonatomic, strong) NSArray * imageList;
@property (nonatomic, strong) NSString * log;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end