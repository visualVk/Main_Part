//
//  RemarkStaticCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "HotelModel.h"
@interface RemarkStaticCell : QMUITableViewCell
@property(nonatomic, weak) HotelModel *model;
@end
