//
//  MineMeliedgeCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#define CIRCLEHEIGHT DEVICE_HEIGHT / 4
#import "MileageCircleProgressView.h"

@interface MineMeliedgeCell : QMUITableViewCell
@property (nonatomic, strong) MileageCircleProgressView *mileageView;
@property (nonatomic, strong) UILabel *mileTx;
@end
