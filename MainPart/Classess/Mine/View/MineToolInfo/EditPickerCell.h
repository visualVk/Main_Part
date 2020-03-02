//
//  EditPickerCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import <BRPickerView.h>
@interface EditPickerCell : QMUITableViewCell
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, strong) BRDatePickerView *datePicker;
@end
