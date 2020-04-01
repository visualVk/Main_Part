//
//  HotelRoomModelList.h
//  MainPart
//
//  Created by blacksky on 2020/3/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelRoomModel.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HotelRoomModelList : NSObject
@property (nonatomic, strong) NSArray<HotelRoomModel *> *data;
@end

NS_ASSUME_NONNULL_END
