#import "ReplyEntity.h"
#import <UIKit/UIKit.h>

@interface HotelDisscussList : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray<ReplyEntity *> *replyEntities;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *username;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
