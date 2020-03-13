//
//  MineInfoSetController.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineInfoSetController.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineInfoSetController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, QMUITextFieldDelegate>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) UILabel *warnLB;
@property (nonatomic, strong) NSArray *warnList;
@end

@implementation MineInfoSetController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.warnList =
  @[ @"*长度不超过15个字符", @"*不能输入表情", @"*不能输入特殊符号如：&，…", @"*不能携带空格" ];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  self.view.backgroundColor = UIColor.qd_customBackgroundColor;
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
  self.navigationItem.leftBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(cancelTab)];
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(submitTab)];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (QMUITextField *)nameTextField {
  if (!_nameTextField) {
    _nameTextField = [QMUITextField new];
    _nameTextField.textInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _nameTextField.placeholder = @"名字不能超过15个字符，不能携带表情";
    _nameTextField.maximumTextLength = 15;
    _nameTextField.font = UIFontMake(18);
    _nameTextField.backgroundColor = UIColor.qd_backgroundColor;
    _nameTextField.qmui_borderColor = UIColor.qd_separatorColor;
    _nameTextField.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    _nameTextField.qmui_borderWidth = 1;
    _nameTextField.delegate = self;
  }
  return _nameTextField;
}

- (UILabel *)warnLB {
  if (!_warnLB) {
    _warnLB = [UILabel new];
    _warnLB.numberOfLines = 0;
    __weak __typeof(self) weakSelf = self;
    _warnLB.attributedText = [NSAttributedString sj_UIKitText:^(
                                                                id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.lineSpacing(5);
      make.append(@"·命名注意事项\n ").textColor(UIColor.qd_titleTextColor).font(UIFontMake(17));
      for (NSString *warnStr in weakSelf.warnList) {
        make.append(warnStr).textColor(UIColor.qmui_randomColor).font(UIFontLightMake(15));
        make.append(@"\n ");
      }
    }];
  }
  return _warnLB;
}

#pragma mark -  GenerateEntityDelegate
- (void)generateRootView {
  
  addView(self.view, self.nameTextField);
  addView(self.view, self.warnLB);
  
  [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.inset(20);
    make.height.mas_equalTo(DEVICE_HEIGHT / 15);
    make.left.right.equalTo(self.view);
  }];
  
  [self.warnLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.nameTextField.mas_bottom).with.inset(0.25 * SPACE);
    make.left.right.equalTo(self.view).with.inset(0.25 * SPACE);
  }];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)cancelTab {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitTab {
  [QMUITips showLoadingInView:self.view];
  __weak __typeof(self) weakSelf = self;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
    [QMUITips hideAllTipsInView:self.view];
    [weakSelf.navigationController popViewControllerAnimated:YES];
  });
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)forceEnableInteractivePopGestureRecognizer {
  return YES;
}

#pragma mark - QMUITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
  NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if (range.length == 1 && text.length == 0) { return YES; }
  if ([text length] == 0) { return NO; }
  return YES;
}
@end
