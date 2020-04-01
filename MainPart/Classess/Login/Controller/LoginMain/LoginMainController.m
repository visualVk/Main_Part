//
//  LoginMainController.m
//  LoginPart
//
//  Created by blacksky on 2020/4/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LoginMainController.h"
#import "LoginController.h"
#import "LoginMainButton.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
@interface LoginMainController () <GenerateEntityDelegate, LoginMainButtonDelegate>
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) LoginMainButton *wechatBtn;
@property (nonatomic, strong) LoginMainButton *accountBtn;
@end

@implementation LoginMainController

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
  //    self.title = @"<##>";
}

- (void)generateRootView {
  addView(self.view, self.bgImage);
  addView(self.view, self.logoView);
  addView(self.view, self.accountBtn);
  addView(self.view, self.wechatBtn);
  
  [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.view); }];
  
  [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).with.inset(200);
    make.centerX.equalTo(self.view);
  }];
  
  [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.wechatBtn.mas_top).with.inset(20);
    make.left.right.equalTo(self.view).with.inset(40);
    make.height.mas_equalTo(DEVICE_HEIGHT * 0.074);
  }];
  
  [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view).with.inset(110);
    make.left.right.equalTo(self.view).with.inset(40);
    make.height.mas_equalTo(DEVICE_HEIGHT * 0.074);
  }];
}

- (UIImageView *)bgImage {
  if (!_bgImage) {
    _bgImage = [UIImageView new];
    _bgImage.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _bgImage;
}

- (UIImageView *)logoView {
  if (!_logoView) {
    _logoView = [UIImageView new];
    _logoView.contentMode = QMUIImageResizingModeScaleAspectFill;
    _logoView.image = UIImageMake(@"energry");
  }
  return _logoView;
}

- (LoginMainButton *)accountBtn {
  if (!_accountBtn) {
    _accountBtn = [LoginMainButton new];
    _accountBtn.container.backgroundColor = UIColorMakeWithHex(@"#353434");
    _accountBtn.label.text = @"账户登录";
    _accountBtn.pic.image = UIImageMake(@"account");
    _accountBtn.delegate = self;
  }
  return _accountBtn;
}

- (LoginMainButton *)wechatBtn {
  if (!_wechatBtn) {
    _wechatBtn = [LoginMainButton new];
    _wechatBtn.container.backgroundColor = UIColorMakeWithHex(@"#1CD300");
    _wechatBtn.label.text = @"微信登录";
    _wechatBtn.delegate = self;
  }
  return _wechatBtn;
}

- (void)tap:(UIView *)view {
  if (view == self.wechatBtn) {
    QMUILogInfo(@"login main controller", @"wechat button clicked");
  } else {
    QMUILogInfo(@"login main controller", @"account button clicked");
    LoginController *lc = [LoginController new];
    QMUINavigationController *nav =
    [[QMUINavigationController alloc] initWithRootViewController:lc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    lc.navigationItem.leftBarButtonItem =
    [UIBarButtonItem qmui_backItemWithTarget:self
                                      action:[self selectorBlock:^(id _Nonnull args) {
      [nav dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:nav animated:YES completion:nil];
  }
}
@end
