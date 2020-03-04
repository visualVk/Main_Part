//
//  HotelComboCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface HotelComboCell : QMUITableViewCell
@property (nonatomic, strong) QMUILabel *stDate;
@property (nonatomic, strong) QMUILabel *edDate;
@property (nonatomic, strong) QMUILabel *days;
@property (nonatomic, strong) UILabel *hotelTitle;
@property (nonatomic, strong) UILabel *tags;
@property (nonatomic, strong) UILabel *showHotel;
@property(nonatomic, strong) UILabel *configuration;
- (void)loadData:(NSDictionary *)infoDict;
@end
