//
//  OrderDiscountCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import <BEMCheckBox.h>

@interface OrderDiscountCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *ticketBrief;
@property (nonatomic, strong) BEMCheckBox *ticketCheckBox;
@property (nonatomic, strong) UILabel *discountTitle;
@property (nonatomic, strong) UILabel *discount;
@property (nonatomic, strong) UILabel *creditTitle;
@property (nonatomic, strong) UILabel *credit;
@property (nonatomic, strong) UIImageView *detailImage;
@property (nonatomic, strong) QMUILabel *maxTag;
@end
