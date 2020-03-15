//
//  MineFoodAddressCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import "OrderCheckInfo.h"
#import "QMUITableViewCell.h"
@interface MineFoodAddressCell : QMUITableViewCell
@property (nonatomic, strong) QMUILabel *sendLB;
@property (nonatomic, strong) QMUILabel *takeLB;
@property (nonatomic, strong) QMUILabel *addressLB;
@property (nonatomic, strong) NSArray<Food *> *foodList;
@property (nonatomic, assign) BOOL isAddressEnable;
@property (nonatomic, strong) OrderCheckInfo *model;
@end
