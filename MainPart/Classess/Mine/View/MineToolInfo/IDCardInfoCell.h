//
//  IDCardInfoCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Info.h"
#import "QMUITableViewCell.h"
@interface IDCardInfoCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *infoAttr;
@property (nonatomic, strong) Info *model;
- (void)loadData:(Info *)info;
@end
