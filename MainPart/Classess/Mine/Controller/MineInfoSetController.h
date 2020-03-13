//
//  MineInfoSetController.h
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"
#import <JVFloatLabeledTextField.h>

@interface MineInfoSetController : QMUICommonViewController
@property (nonatomic, readonly) QMUITableView *tableView;
@property (nonatomic, strong) QMUITextField *nameTextField;
@end
