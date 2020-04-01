#import <UIKit/UIKit.h>

@interface HotelAppreaiseModel : NSObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) CGFloat facilitiesGrade;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) CGFloat hygieneGrade;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * liveTime;
@property (nonatomic, assign) CGFloat locationGrade;
@property (nonatomic, strong) NSString * payNumber;
@property (nonatomic, assign) NSInteger roomtypeId;
@property (nonatomic, strong) NSString * roomtypeName;
@property (nonatomic, assign) CGFloat serviceGrade;
@property (nonatomic, strong) NSArray * urlList;
@property (nonatomic, assign) NSInteger userId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end