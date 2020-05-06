#import "CheckInfo.h"
#import <UIKit/UIKit.h>

@interface OrderCheckInfo : NSObject

@property (nonatomic, strong) NSArray *checkInfo;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *dinnerAddress;
@property (nonatomic, strong) NSString *edDate;
@property (nonatomic, strong) NSString *hotelAddress;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, strong) NSString *roomCombo;
@property (nonatomic, strong) NSString *roomPrice;
@property (nonatomic, assign) NSInteger roomTypeId;
@property (nonatomic, strong) NSString *roomTypeName;
@property (nonatomic, strong) NSString *stDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
