//
//  MineNewPhoneController.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineNewPhoneController.h"
#import "MarkUtils.h"
#import "MineCodeController.h"
#import "PayFinishController.h"

@interface MineNewPhoneController () <GenerateEntityDelegate, QMUITextFieldDelegate>
@property (nonatomic, strong) QMUITextField *phoneText;
@property (nonatomic, strong) QMUIButton *nextBtn;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MineNewPhoneController

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
  //  self.title = @"绑定手机号";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.scrollView);
  self.scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT - NavigationContentTop);
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.bottom.equalTo(self.view);
  }];
}

#pragma mark - QMUITextFieldDelegate
- (void)textField:(QMUITextField *)textField
didPreventTextChangeInRange:(NSRange)range
replacementString:(NSString *)replacementString {
}

#pragma mark - Lazy Init
- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [UIScrollView new];
    addView(_scrollView, self.container);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_scrollView).with.inset(DEVICE_HEIGHT / 10);
      //      make.left.right.equalTo(_scrollView).with.inset(SPACE);
      
      make.centerX.equalTo(_scrollView);
      make.width.mas_equalTo(DEVICE_WIDTH - 2 * SPACE);
    }];
  }
  return _scrollView;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.clipsToBounds = YES;
    addView(_container, self.hintTitle);
    addView(_container, self.phoneText);
    addView(_container, self.nextBtn);
    
    [self.hintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.container);
      make.centerX.equalTo(self.container);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.hintTitle.mas_bottom).with.inset(2 * SPACE);
      make.left.right.equalTo(_container);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.phoneText.mas_bottom).with.inset(SPACE);
      make.left.right.equalTo(_container);
      make.bottom.equalTo(_container);
    }];
  }
  return _container;
}

- (UILabel *)hintTitle {
  if (!_hintTitle) {
    _hintTitle = [UILabel new];
    _hintTitle.textColor = UIColorBlack;
    if (self.phoneType == NewPassword) {
      _hintTitle.text = @"请输入新密码";
    } else {
      _hintTitle.text = @"请输入手机号码";
    }
    _hintTitle.font = UIFontMake(30);
  }
  return _hintTitle;
}

- (QMUITextField *)phoneText {
  if (!_phoneText) {
    _phoneText = [QMUITextField new];
    _phoneText.delegate = self;
    _phoneText.textInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    if (self.phoneType == NewPassword) {
      _phoneText.placeholder = @"请输入不超过15位的密码";
      _phoneText.maximumTextLength = 15;
      _phoneText.secureTextEntry = YES;
    } else {
      _phoneText.placeholder = @"11位手机号";
    }
    _phoneText.maximumTextLength = 11;
    _phoneText.qmui_borderColor = UIColor.qd_separatorColor;
    _phoneText.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _phoneText.clearButtonMode = UITextFieldViewModeAlways;
    
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    __weak __typeof(self) weakSelf = self;
    _phoneText.qmui_keyboardWillShowNotificationBlock = ^(QMUIKeyboardUserInfo *keyboardUserInfo) {
      if (keyboardUserInfo.height > DEVICE_HEIGHT / 2) {
        [weakSelf.scrollView setContentOffset:CGPointMake(0, DEVICE_HEIGHT / 10) animated:YES];
      }
    };
    _phoneText.qmui_keyboardWillHideNotificationBlock = ^(QMUIKeyboardUserInfo *keyboardUserInfo) {
      [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    };
  }
  return _phoneText;
}

- (QMUIButton *)nextBtn {
  if (!_nextBtn) {
    _nextBtn = [QDUIHelper generateDarkFilledButton];
    _nextBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    _nextBtn.titleLabel.font = UIFontMake(20);
    if (self.phoneType == NewPassword) {
      [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    } else {
      [_nextBtn setTitle:@"下一步，输入验证码" forState:UIControlStateNormal];
    }
    [_nextBtn addTarget:self
                 action:@selector(codeClick)
       forControlEvents:UIControlEventTouchUpInside];
  }
  return _nextBtn;
}

- (void)codeClick {
  if (self.phoneType == OlderPhone) {
    MineCodeController *mcCon = [MineCodeController new];
    mcCon.codeType = OldeCode;
    [self.navigationController pushViewController:mcCon animated:YES];
  } else if (self.phoneType == NewPhone) {
    MineCodeController *mcCon = [MineCodeController new];
    mcCon.codeType = NewCode;
    [self.navigationController pushViewController:mcCon animated:YES];
  } else if (self.phoneType == NewPassword) {
    PayFinishController *pfCon = [PayFinishController new];
    pfCon.title = @"修改密码成功";
    NSMutableArray *arr = [self.navigationController.viewControllers mutableCopy];
    [arr removeLastObject];
    [arr removeLastObject];
    [arr removeLastObject];
    [arr addObject:pfCon];
    self.navigationController.viewControllers = arr;
  } else if (self.phoneType == NewPhonePassword) {
    MineCodeController *mcCon = [MineCodeController new];
    mcCon.codeType = NewCodePassword;
    [self.navigationController pushViewController:mcCon animated:YES];
  }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.phoneText resignFirstResponder];
  [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
@end
