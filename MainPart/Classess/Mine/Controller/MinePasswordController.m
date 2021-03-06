
//
//  MinePasswordController.m
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MinePasswordController.h"

@interface MinePasswordController ()<GenerateEntityDelegate,QMUITextFieldDelegate>
@property(nonatomic, strong) QMUITextField *pwdTx;
@property(nonatomic, strong) UILabel *hintTitle;
//@property(nonatomic, strong) UILabel *<#name#>;
@end

@implementation MinePasswordController

- (void)didInitialize {
    [super didInitialize];
    // init 时做的事情请写在这里
}

- (void)initSubviews {
    [super initSubviews];
    // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"输入新密码";
}

#pragma mark - GenerateEntityDelegate

@end
