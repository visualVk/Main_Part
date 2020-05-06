#import <UIKit/UIKit.h>

@interface ReplyEntity : NSObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger deleted;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger toId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * username;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end