//
//  RoomCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelRoomModel.h"
#import "QMUITableViewCell.h"
@interface RoomCell : QMUITableViewCell
@property (nonatomic, weak) HotelRoomModel *model;
@end
