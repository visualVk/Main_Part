//
//  PeopleNumController.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
typedef void (^PeopleSelectBlock)(NSInteger num);
@interface PeopleNumController : QMUICommonViewController
@property (nonatomic, strong) PeopleSelectBlock pepleSelectBlock;
@end
