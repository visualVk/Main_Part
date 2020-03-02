#import <UIKit/UIKit.h>

@interface Tool : NSObject

@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end