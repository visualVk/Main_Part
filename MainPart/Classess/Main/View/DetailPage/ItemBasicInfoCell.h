//
//  ItemBasicInfoCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/20.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
typedef void (^Go2MapCon)(void);
@interface ItemBasicInfoCell : QMUITableViewCell
@property (nonatomic, strong) Go2MapCon go2MapCon;
@end
