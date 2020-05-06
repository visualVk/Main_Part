//
//  PayController.h
//  MainPart
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
#import "TPaysEntity.h"

@interface PayMethodController : QMUICommonViewController
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) TPaysEntity *model;
@end
