//
//  DetailController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelModel.h"
#import <QMUIKit/QMUIKit.h>
@interface DetailController : QMUICommonViewController
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) HotelModel *hotelModel;
@end
