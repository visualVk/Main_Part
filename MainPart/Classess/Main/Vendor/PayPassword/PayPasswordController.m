//
//  PayPasswordController.m
//  PayPassword
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "PayPasswordController.h"
#import <Masonry.h>
#import <QMUIKit.h>
#define DotSize CGSizeMake(10, 10)
#define DotCount 6
#define PassWordHeight DEVICE_HEIGHT / 20
#define TopInfoHeight DEVICE_HEIGHT * 2 / 9
#define PassWordWidht DEVICE_WIDTH - 40
#define NumHeight DEVICE_HEIGHT / 15
#define BorderGray UIColorMakeWithHex(@"#DDDDDD")
const NSInteger btnIndex = 10000;
@interface PayPasswordController () <UITextFieldDelegate> {
  NSInteger curBtnIndex;
}
@property (nonatomic, strong) UIView *textContainer;
@property (nonatomic, strong) QMUIGridView *customNumKeyBoard;

@end

@implementation PayPasswordController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  curBtnIndex = btnIndex;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.45];
  [self.view addSubview:self.container];
  //  [self.textContainer addSubview:self.pswTextField];
  //  [self pswTextField];
  //  [self setupWithPswTextField];
  [self.pswTextField becomeFirstResponder];
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
  self.title = @"<##>";
}

- (NSMutableArray *)dotArr {
  if (!_dotArr) { _dotArr = [NSMutableArray array]; }
  return _dotArr;
}

- (UIView *)container {
  if (!_container) {
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH - 20, TopInfoHeight)];
    _container.center = CGPointMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT / 2 - DEVICE_HEIGHT / 10);
    //    _container.layer.borderColor = [BorderGray CGColor];
    //    _container.layer.borderWidth = 1;
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = YES;
    _container.backgroundColor = UIColor.whiteColor;
    [_container addSubview:self.hintTitle];
    [_container addSubview:self.closeImage];
    [_container addSubview:self.payMoney];
    [_container addSubview:self.textContainer];
    [self setupWithPswTextField];
    
    [self.closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(_container).with.inset(10);
    }];
    
    [self.hintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_container);
      make.top.equalTo(self.closeImage);
    }];
    
    [self.payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_container);
      make.centerY.equalTo(_container).multipliedBy(0.8);
    }];
  }
  return _container;
}

- (UILabel *)hintTitle {
  if (!_hintTitle) {
    _hintTitle = [UILabel new];
    _hintTitle.text = @"请输入支付密码";
    _hintTitle.textColor = UIColor.blackColor;
    _hintTitle.font = UIFontMake(18);
  }
  return _hintTitle;
}

- (UILabel *)payMoney {
  if (!_payMoney) {
    _payMoney = [UILabel new];
    _payMoney.text = @"200元";
    _payMoney.font = UIFontBoldMake(30);
    _payMoney.textColor = UIColor.blackColor;
  }
  return _payMoney;
}

- (UIImageView *)closeImage {
  if (!_closeImage) {
    _closeImage = [UIImageView new];
    _closeImage.userInteractionEnabled = YES;
    _closeImage.image = UIImageMake(@"close");
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeImageClick)];
    [_closeImage addGestureRecognizer:tap];
  }
  return _closeImage;
}

- (void)closeImageClick {
  QMUILogInfo(@"password view", @"click close");
  if ([self.payDelegate respondsToSelector:@selector(closePayPassword)]) {
    [self.payDelegate closePayPassword];
  }
}

#pragma mark - 支付密码框
- (UIView *)textContainer {
  if (!_textContainer) {
    _textContainer =
    [[UIView alloc] initWithFrame:CGRectMake(10, TopInfoHeight - 10 - PassWordHeight,
                                             PassWordWidht, PassWordHeight)];
    //    _textContainer.center = CGPointMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT / 3);
    _textContainer.layer.borderColor = [BorderGray CGColor];
    _textContainer.layer.borderWidth = 1;
  }
  return _textContainer;
}

- (void)setupWithPswTextField {
  CGFloat width = (PassWordWidht) / DotCount;
  
  //分割线
  for (int i = 0; i < DotCount - 1; i++) {
    UIView *lineView =
    [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width, 0, 1, PassWordHeight)];
    lineView.backgroundColor = BorderGray;
    [self.textContainer addSubview:lineView];
  }
  
  self.dotArr = [[NSMutableArray alloc] init];
  
  // 生成中间的黑点
  for (int i = 0; i < DotCount; i++) {
    UIView *dotView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, DotSize.width, DotSize.height)];
    dotView.center = CGPointMake(i * width + width / 2, PassWordHeight / 2);
    dotView.backgroundColor = [UIColor blackColor];
    dotView.layer.cornerRadius = DotSize.width / 2.0f;
    dotView.clipsToBounds = YES;
    dotView.hidden = YES; //先隐藏
    [self.textContainer addSubview:dotView];
    
    // 把创建的黑色点加入到存放数组中
    [self.dotArr addObject:dotView];
  }
}

- (UITextField *)pswTextField {
  if (!_pswTextField) {
    _pswTextField = [[UITextField alloc] initWithFrame:self.textContainer.bounds];
    _pswTextField.backgroundColor = [UIColor clearColor];
    // 输入的文字颜色为无色
    _pswTextField.textColor = [UIColor clearColor];
    // 输入框光标的颜色为无色
    _pswTextField.tintColor = [UIColor clearColor];
    _pswTextField.secureTextEntry = YES;
    _pswTextField.inputView = self.customNumKeyBoard;
    _pswTextField.delegate = self;
    _pswTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pswTextField.keyboardType = UIKeyboardTypeNumberPad;
    _pswTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    _pswTextField.layer.borderWidth = 1;
    [_pswTextField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    [self.textContainer addSubview:_pswTextField];
  }
  return _pswTextField;
}
#pragma mark - text field 输入监听
- (void)textFieldDidChange:(UITextField *)textField {
  
  QMUILogInfo(@"password view", @"目前输入显示:%@", textField.text);
  if (textField.text.length > DotCount) {
    textField.text = [textField.text substringToIndex:DotCount - 1];
    return;
  }
  for (UIView *dotView in self.dotArr) { dotView.hidden = YES; }
  for (int i = 0; i < textField.text.length; i++) {
    ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
  }
  if (textField.text.length == DotCount) {
    QMUILogInfo(@"password view", @"输入完毕");
    //    [self.pswTextField resignFirstResponder];
    if ([self.payDelegate respondsToSelector:@selector(didFinishInput:)]) {
      [self.payDelegate didFinishInput:textField.text];
    }
  }
  
  // 获取用户输入密码
  !self.passwordDidChangeBlock ?: self.passwordDidChangeBlock(textField.text);
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
  
  QMUILogInfo(@"password view", @"输入变化%@", string);
  if ([string isEqualToString:@"\n"]) { // 按回车关闭键盘
    [textField resignFirstResponder];
    return NO;
  } else if (string.length == 0) { // 判断是不是删除键
    return YES;
  } else if (textField.text.length >= DotCount) {
    // 输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
    QMUILogInfo(@"password view", @"输"
                @"入的字符个数大于6，后面禁止输入则忽略输入");
    return NO;
  } else {
    return YES;
  }
}

- (void)clearUpPassword {
  [self.pswTextField resignFirstResponder];
  self.pswTextField.text = nil;
  [self textFieldDidChange:self.pswTextField];
}

#pragma mark - 自定义数字键盘
- (QMUIGridView *)customNumKeyBoard {
  if (!_customNumKeyBoard) {
    //九宫格
    _customNumKeyBoard = [[QMUIGridView alloc] initWithColumn:3 rowHeight:NumHeight];
    _customNumKeyBoard.backgroundColor = UIColor.whiteColor;
    _customNumKeyBoard.separatorColor = BorderGray;
    _customNumKeyBoard.separatorWidth = 0.5;
    _customNumKeyBoard.qmui_borderColor = BorderGray;
    _customNumKeyBoard.qmui_borderPosition = QMUIViewBorderPositionTop;
    NSArray *array = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"取消", @"0", @"" ];
    QMUIButton *btn = nil;
    for (NSString *key in array) {
      //退格键
      if ([@"" isEqualToString:key]) {
        btn = [QMUIButton new];
        [btn setImage:UIImageMake(@"backspace") forState:UIControlStateNormal];
      } else { //数字键
        btn = [self generateKey:key];
      }
      btn.tag = curBtnIndex++;
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [_customNumKeyBoard addSubview:btn];
    }
    //高度自适应
    CGSize size = [_customNumKeyBoard sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
    _customNumKeyBoard.frame =
    CGRectMake(0, DEVICE_HEIGHT - SafeAreaInsetsConstantForDeviceWithNotch.bottom - size.height,
               size.width, size.height);
    QMUILogInfo(@"password view", @"safe bottom:%f",
                SafeAreaInsetsConstantForDeviceWithNotch.bottom);
  }
  return _customNumKeyBoard;
}

- (void)btnClick:(QMUIButton *)button {
  NSInteger index = button.tag;
  if (index == btnIndex + 11) {
    if (self.pswTextField.text.length) {
      self.pswTextField.text =
      [self.pswTextField.text substringToIndex:self.pswTextField.text.length - 1];
    }
  } else if (index == btnIndex + 9) {
    
  } else if (button.tag >= btnIndex && button.tag < curBtnIndex && index != btnIndex + 9 &&
             index != btnIndex + 11) {
    QMUILogInfo(@"password view", @"click:%@", button.titleLabel.text);
    self.pswTextField.text =
    [NSString stringWithFormat:@"%@%@", self.pswTextField.text, button.titleLabel.text];
  }
  [self textFieldDidChange:self.pswTextField];
}

- (QMUIButton *)generateKey:(NSString *)key {
  QMUIButton *keyBtn = [QMUIButton new];
  [keyBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
  [keyBtn setTitle:key forState:UIControlStateNormal];
  return keyBtn;
}

#pragma mark - 共有方法
- (void)finishPay {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)setPrice:(NSString *)price {
  _price = price;
  self.payMoney.text = [NSString stringWithFormat:@"%@元", price];
}
@end
