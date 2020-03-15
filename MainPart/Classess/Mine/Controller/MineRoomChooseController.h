//
//  MineRoomChooseController.h
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
typedef void (^RoomChooseBlock)(NSString *roomAddress);
@interface MineRoomChooseController : QMUICommonViewController
@property (nonatomic, strong) RoomChooseBlock roomChooseBlock;
@end
