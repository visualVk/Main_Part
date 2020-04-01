//
//  SectionFoldView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/20.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelRoomModel.h"
#import <QMUIKit/QMUIKit.h>
typedef BOOL (^DidSelectSection)(BOOL isOpen);
@interface SectionFoldView : QMUITableViewHeaderFooterView
@property (nonatomic, strong) DidSelectSection didSelectBlock;
@property (nonatomic, weak) HotelRoomModel *model;
@end
