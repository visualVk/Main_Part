#import <UIKit/UIKit.h>
#import "Title.h"

@interface HotelParam : NSObject

@property (nonatomic, assign) BOOL isMuti;
@property (nonatomic, strong) NSString * param;
@property (nonatomic, strong) NSArray * title;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end