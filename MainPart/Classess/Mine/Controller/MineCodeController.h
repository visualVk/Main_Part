//
//  MineCodeController.h
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
typedef enum { OldeCode, NewCode,NewCodePassword } CodeType;
@interface MineCodeController : QMUICommonViewController
@property (nonatomic, assign) CodeType codeType;
@end
