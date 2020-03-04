//
//  CheckInTextFieldCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface CheckInTextFieldCell : QMUITableViewCell
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) QMUITextField *inputText;
@property(nonatomic, strong) UIImageView *markImage;
@end
