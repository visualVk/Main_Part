//
//  HotelModelList.h
//  MainPart
//
//  Created by blacksky on 2020/3/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelModel.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HotelModelList : NSObject
@property (nonatomic, strong) NSArray<HotelModel *> *data;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
