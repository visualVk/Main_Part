//
//  MineInfoCheckBoxCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "EditInfoCell.h"
#import "QMUITableViewCell.h"
#import <BEMCheckBox.h>
#import <BEMCheckBoxGroup.h>
@interface MineInfoCheckBoxCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) BEMCheckBoxGroup *checkGroup;
@property (nonatomic, strong) BEMCheckBox *femaleCheck;
@property (nonatomic, strong) BEMCheckBox *maleCheck;
@property (nonatomic, weak) id<EditInfoCellDelegate> delegate;
@end
