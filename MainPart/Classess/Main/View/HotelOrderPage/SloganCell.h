//
//  SloganCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface SloganCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUIGridView *sloganGridView;
@end
