//
//  MineMeliedgeCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import <ZZCircleProgress.h>
#define CIRCLEHEIGHT DEVICE_HEIGHT / 4

@interface MineMeliedgeCell : QMUITableViewCell
@property(nonatomic, strong) ZZCircleProgress *mileageCircle;
@end
