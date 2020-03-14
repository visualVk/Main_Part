//
//  PopListItemCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import "QMUITableViewCell.h"
typedef void (^PopItemClickBlock)(NSInteger num);
@interface PopListItemCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *popItemName;
@property (nonatomic, strong) UILabel *popItemPrice;
@property (nonatomic, strong) UILabel *popItemNum;
@property (nonatomic, strong) PopItemClickBlock popItemClickBlock;

@property (nonatomic, strong) Food *model;
@end
