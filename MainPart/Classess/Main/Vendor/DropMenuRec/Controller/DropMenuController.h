//
//  DropMenuController.h
//  DropMenuRe
//
//  Created by blacksky on 2020/3/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelQueryModel.h"
#import "QMUICommonViewController.h"
#import "WMZDropDownMenu.h"

@protocol DropMenuDelegate <NSObject>

- (void)reloadDataWithQuery:(HotelQueryModel *)queryModel;

@end

@interface DropMenuController : QMUICommonViewController
@property (nonatomic, strong) WMZDropDownMenu *menu;
@property (nonatomic, weak) id<DropMenuDelegate> delegate;
@end
