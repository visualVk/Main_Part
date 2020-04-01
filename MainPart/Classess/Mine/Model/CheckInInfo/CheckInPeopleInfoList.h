#import <UIKit/UIKit.h>
#import "Info.h"

@interface CheckInPeopleInfoList : NSObject

@property (nonatomic, strong) NSArray * info;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end