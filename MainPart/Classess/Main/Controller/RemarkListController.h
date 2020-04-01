//
//  RemarkListController.h
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
#import "HotelModel.h"
@interface RemarkListController : QMUICommonViewController
@property (nonatomic, assign) NSInteger hotelId;
@property(nonatomic, strong) HotelModel *model;
@end
