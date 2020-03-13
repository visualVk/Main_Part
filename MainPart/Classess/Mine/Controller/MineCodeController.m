//
//  MineCodeController.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineCodeController.h"
#import "AppDelegate.h"
#import "MarkUtils.h"
#import "MineNewPhoneController.h"
#import "PayFinishController.h"
#import <CRBoxInputCellProperty.h>
#import <CRBoxInputView.h>

@interface MineCodeController () <GenerateEntityDelegate>
@property (nonatomic, strong) CRBoxInputCellProperty *cellProperty;
@property (nonatomic, strong) CRBoxInputView *boxInputView;
@property (nonatomic, strong) UILabel *hintTitle;
@property (nonatomic, strong) UIView *container;
@end

@implementation MineCodeController

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
  [self generateRootView];
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
  self.title = @"输入验证码";
}

- (void)generateRootView {
  addView(self.view, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.width.mas_equalTo(DEVICE_WIDTH - 2 * SPACE);
    make.centerX.equalTo(self.view);
    //    make.bottom.equalTo(self.view);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.boxInputView);
    addView(_container, self.hintTitle);
    
    [self.hintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_container);
      make.top.equalTo(_container).with.inset(DEVICE_HEIGHT / 10);
    }];
    
    [self.boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.hintTitle.mas_bottom).with.inset(2 * SPACE);
      make.left.right.equalTo(_container).with.inset(SPACE);
      make.height.mas_equalTo(DEVICE_HEIGHT / 15);
      make.bottom.equalTo(_container);
    }];
  }
  return _container;
}

- (UILabel *)hintTitle {
  if (!_hintTitle) {
    _hintTitle = [UILabel new];
    _hintTitle.text = @"请输入验证码";
    _hintTitle.textColor = UIColor.blackColor;
    _hintTitle.font = UIFontMake(30);
  }
  return _hintTitle;
}

- (CRBoxInputView *)boxInputView {
  if (!_boxInputView) {
    // cell属性
    self.cellProperty = [CRBoxInputCellProperty new];
    self.cellProperty.cellCursorColor = UIColor.qd_tintColor;
    self.cellProperty.cellCursorWidth = 1;
    //    self.cellProperty.cellCursorHeight = DEVICE_HEIGHT / 15 - 10;
    self.cellProperty.cornerRadius = 0;
    self.cellProperty.borderWidth = 0;
    self.cellProperty.cellFont = UIFontLightMake(24);
    self.cellProperty.cellTextColor = UIColorBlack;
    self.cellProperty.showLine = YES;
    self.cellProperty.customLineViewBlock = ^CRLineView *_Nonnull {
      CRLineView *lineView = [CRLineView new];
      lineView.underlineColorNormal = [UIColorBlack colorWithAlphaComponent:0.3];
      lineView.underlineColorSelected = [UIColorBlack colorWithAlphaComponent:0.7];
      lineView.underlineColorFilled = UIColorBlack;
      [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.left.right.bottom.offset(0);
      }];
      
      return lineView;
    };
    
    _boxInputView = [CRBoxInputView new];
    _boxInputView.customCellProperty = self.cellProperty;
    [_boxInputView loadAndPrepareViewWithBeginEdit:YES];
    __weak __typeof(self) weakSelf = self;
    _boxInputView.textEditStatusChangeblock = ^(CRTextEditStatus editStatus) {
      if (editStatus == CRTextEditStatus_EndEdit) {
        QMUILogInfo(@"mine code controller", @"code:%@", weakSelf.boxInputView.textValue);
        AppDelegate *delegate = (AppDelegate *)[UIApplication.sharedApplication delegate];
        [QMUITips showLoadingInView:delegate.window];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(),
                       ^{ [weakSelf compareCode:weakSelf.boxInputView.textValue]; });
      }
    };
  }
  return _boxInputView;
}

- (void)compareCode:(NSString *)codeStr {
  [QMUITips hideAllTips];
  if (self.codeType == NewCode) {
    NSMutableArray *arr = [self.navigationController.viewControllers mutableCopy];
    [arr removeLastObject];
    [arr removeLastObject];
    PayFinishController *pfCon = [PayFinishController new];
    pfCon.title = @"绑定成功";
    [pfCon.tableView reloadData];
    [arr addObject:pfCon];
    self.navigationController.viewControllers = arr;
  } else if (self.codeType == OldeCode) {
    MineNewPhoneController *mnpCon = [MineNewPhoneController new];
    mnpCon.phoneType = NewPhone;
    mnpCon.title = @"绑定手机号";
    __weak __typeof(self) weakSelf = self;
    [self.navigationController
     qmui_pushViewController:mnpCon
     animated:YES
     completion:^{
      NSMutableArray *arr =
      [weakSelf.navigationController.viewControllers mutableCopy];
      [arr removeObjectsInRange:NSMakeRange(arr.count - 3, 2)];
      weakSelf.navigationController.viewControllers = arr;
    }];
  } else if (self.codeType == NewCodePassword) {
    MineNewPhoneController *mnpCon = [MineNewPhoneController new];
    mnpCon.phoneType = NewPassword;
    mnpCon.title = @"输入新密码";
    [self.navigationController qmui_pushViewController:mnpCon animated:YES completion:^{}];
  }
}
@end
