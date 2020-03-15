#import <UIKit/UIKit.h>
#import "Device.h"

@interface HotelDevice : NSObject

@property (nonatomic, strong) NSArray * device;
@property (nonatomic, strong) NSString * deviceDescription;
@property (nonatomic, strong) NSString * edDate;
@property (nonatomic, assign) BOOL hotelId;
@property (nonatomic, strong) NSString * hotelName;
@property (nonatomic, strong) NSString * stDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end