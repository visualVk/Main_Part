#import <UIKit/UIKit.h>

@interface HotelRoomModel : NSObject

@property (nonatomic, assign) CGFloat avgGrade;
@property (nonatomic, strong) NSString *bedInfo;
@property (nonatomic, strong) NSString *breakfast;
@property (nonatomic, strong) NSString *castPolicy;
@property (nonatomic, strong) NSString *convenienceFacilities;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, assign) CGFloat facilitiesGrade;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) CGFloat hygieneGrade;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat locationGrade;
@property (nonatomic, strong) NSString *membershipInterests;
@property (nonatomic, strong) NSString *roomArea;
@property (nonatomic, assign) CGFloat roomCount;
@property (nonatomic, strong) NSString *roomDetails;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, assign) NSInteger roomOrgprice;
@property (nonatomic, assign) NSInteger roomPrice;
@property (nonatomic, assign) NSInteger roomSize;
@property (nonatomic, assign) NSInteger roomSpace;
@property (nonatomic, strong) NSString *roomType;
@property (nonatomic, assign) CGFloat serviceGrade;
@property (nonatomic, strong) NSArray *urlList;
@property (nonatomic, assign) NSInteger userIntegral;
@property (nonatomic, strong) NSString *washroomCollocation;
@property (nonatomic, strong) NSString *wifiInfo;
@property (nonatomic, strong) NSString *windows;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
