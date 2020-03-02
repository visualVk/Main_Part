//
//  MineOrderCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
typedef enum { NonPayment, Paid, Remark } OrderType;
@interface MineOrderCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UIImageView *itemImage;
@property (nonatomic, strong) UILabel *itemName;
@property (nonatomic, strong) UILabel *itemCombo;
@property (nonatomic, strong) UILabel *buyInfo;
@property (nonatomic, strong) UILabel *perPrice;
@property (nonatomic, strong) QMUIGhostButton *payBtn;
@property (nonatomic, strong) QMUIGhostButton *deleteBtn;
@property (nonatomic, strong) NSDictionary *infoDict;
-(void)loadData;
@end
