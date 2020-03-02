//
//  IDCardInfoCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "Info.h"
@interface IDCardInfoCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *infoAttr;
-(void)loadData:(Info*)info;
@end
