//
//  MineDiscountCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import <CSXMarkView.h>

@interface MineDiscountCell : QMUITableViewCell
@property(nonatomic, strong) UILabel *discountNum;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *brief;
@property(nonatomic, strong) UILabel *detail;
@property(nonatomic, strong) QMUIButton *useBtn;
@property (nonatomic, strong) UIView *detailView;
@end
