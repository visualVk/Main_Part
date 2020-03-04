//
//  NumberCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import <PPNumberButton.h>
@interface HotelNumberCell : QMUITableViewCell
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) PPNumberButton *stepBtn;
@end
