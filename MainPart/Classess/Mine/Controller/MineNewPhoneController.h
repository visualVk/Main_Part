//
//  MineNewPhoneController.h
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"

typedef enum { OlderPhone, NewPhone, NewPassword, NewPhonePassword } PhoneType;

@interface MineNewPhoneController : QMUICommonViewController
@property (nonatomic, assign) PhoneType phoneType;
@property (nonatomic, strong) UILabel *hintTitle;
@end
