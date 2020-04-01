#import <UIKit/UIKit.h>

@interface HotelModel : NSObject

@property (nonatomic, assign) NSInteger hotelComment;
@property (nonatomic, assign) NSInteger hotelCountpay;
@property (nonatomic, strong) NSString *hotelDetail;
@property (nonatomic, strong) NSString *hotelLocation;
@property (nonatomic, assign) CGFloat hotelMaxprice;
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSString *hotelPic;
@property (nonatomic, strong) NSString *hotelRank;
@property (nonatomic, assign) CGFloat hotelSource;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray *logoList;
@property (nonatomic, assign) CGFloat lowPrice;
@property (nonatomic, assign) CGFloat orgPrice;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
