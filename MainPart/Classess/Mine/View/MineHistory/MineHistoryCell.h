//
//  MineHistoryCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
typedef enum { HotelType, SpotType } HistoryType;
@interface MineHistoryCell : QMUITableViewCell
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *remark;
- (void)loadDataWithType:(HistoryType)type;
@end
