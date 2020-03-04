//
//  HotelWarnCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

typedef void (^PresentWarn)(void);
@interface HotelWarnCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *orderWarn;
@property (nonatomic, strong) UILabel *showAll;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) PresentWarn presentWarn;
@property (nonatomic, strong) QMUITableView *tableView;
@end
