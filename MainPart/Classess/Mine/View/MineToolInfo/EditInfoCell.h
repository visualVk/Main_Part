//
//  EditInfoCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@protocol EditInfoCellDelegate <NSObject>

- (void)contentValueChange:(NSString *)titleText content:(NSString *)content;

@end

@interface EditInfoCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUITextField *content;
@property (nonatomic, weak) id<EditInfoCellDelegate> editDelegate;
@end
