//
//  TPaysEntity.h
//  MainPart
//
//  Created by blacksky on 2020/5/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPaysEntity : NSObject
@property (nonatomic, strong) NSString *arriveTime;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString *liveEnd;
@property (nonatomic, strong) NSString *liveStart;
@property (nonatomic, strong) NSString *liverList;
@property (nonatomic, assign) CGFloat pay;
@property (nonatomic, assign) NSInteger roomtypeId;
@end

NS_ASSUME_NONNULL_END
