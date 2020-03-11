#import <UIKit/UIKit.h>
#import "HotelParam.h"

@interface HotelParamList : NSObject

@property (nonatomic, strong) NSArray * hotelParam;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end