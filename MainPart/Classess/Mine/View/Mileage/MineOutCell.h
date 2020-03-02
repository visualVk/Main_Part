//
//  MineOutCell.h
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface MineOutCell : QMUITableViewCell
@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, strong) UILabel *award;
@property(nonatomic, strong) QMUIGhostButton *seeBtn;
@end
