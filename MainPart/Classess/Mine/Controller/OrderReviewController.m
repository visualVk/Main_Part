//
//  OrderReviewController.m
//  MainPart
//
//  Created by blacksky on 2020/4/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderReviewController.h"
#import "FMLStarView.h"
#import "MarkUtils.h"
#import "MineReviewTextView.h"
#define HYIGENE 10000
#define LOCATION 10001
#define SERVICE 10002
#define FACILITY 10003

@interface OrderReviewController () <GenerateEntityDelegate, FMLStarViewDelegate,
QMUITextViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MineReviewTextView *reviewView;
@property (nonatomic, strong) QMUITextView *reviewTX;
@property (nonatomic, strong) QMUIButton *subBtn;
@end

@implementation OrderReviewController

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
  self.title = @"评价";
}

#pragma mark - GeneraterEntityDelegate
- (void)generateRootView {
  addView(self.view, self.scrollView);
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
  }];
}

#pragma mark - Lazy Init
- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = UIColor.clearColor;
    UIView *container = [UIView new];
    container.userInteractionEnabled = YES;
    addView(_scrollView, container);
    //    addView(container, self.reviewTX);
    addView(container, self.reviewView);
    addView(container, self.subBtn);
    //-----四个评分
    UIView *hiygene = [self generateStarView:@"卫生" tag:HYIGENE];
    UIView *location = [self generateStarView:@"位置" tag:LOCATION];
    UIView *service = [self generateStarView:@"服务" tag:SERVICE];
    UIView *facility = [self generateStarView:@"设施" tag:FACILITY];
    NSArray *reviewArr = @[ hiygene, location, service, facility ];
    for (UIView *view in reviewArr) { addView(container, view); }
    //------
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(_scrollView);
      make.width.equalTo(_scrollView);
      //      make.height.mas_equalTo(DEVICE_HEIGHT);
    }];
    
    [reviewArr mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.equalTo(container).with.inset(20);
    }];
    
    [hiygene mas_makeConstraints:^(MASConstraintMaker *make) { make.top.equalTo(container); }];
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(hiygene.mas_bottom).with.inset(15);
    }];
    
    [service mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(location.mas_bottom).with.inset(15);
    }];
    
    [facility mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(service.mas_bottom).with.inset(15);
    }];
    
    [self.reviewView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(facility.mas_bottom).with.inset(15);
      make.height.mas_equalTo(400);
      make.left.right.equalTo(facility);
    }];
    
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.reviewView.mas_bottom).with.inset(25);
      make.left.right.equalTo(self.reviewView);
      make.height.mas_equalTo(55);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.subBtn.mas_bottom);
    }];
  }
  return _scrollView;
}

- (MineReviewTextView *)reviewView {
  if (!_reviewView) {
    _reviewView = [MineReviewTextView new];
    __weak __typeof(self) weakSelf = self;
    _reviewView.reviewTX.qmui_keyboardWillShowNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf showKeyBoard:keyboardUserInfo]; };
    _reviewView.reviewTX.qmui_keyboardWillHideNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf hideKeyBoard:keyboardUserInfo]; };
  }
  return _reviewView;
}

- (UIView *)generateStarView:(NSString *)title tag:(NSInteger)tag {
  FMLStarView *starView = [[FMLStarView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)
                                               numberOfStars:5
                                                 isTouchable:YES
                                                       index:0];
  starView.tag = tag;
  starView.isFullStarLimited = YES;
  starView.totalScore = 5;
  starView.currentScore = 0;
  starView.delegate = self;
  UIView *container = [UIView new];
  UILabel *titleLB = [UILabel new];
  titleLB.text = title;
  titleLB.font = UIFontBoldMake(20);
  addView(container, titleLB);
  addView(container, starView);
  [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(container);
    make.centerY.equalTo(starView);
  }];
  
  [starView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(container);
    make.size.mas_equalTo(CGSizeMake(150, 35));
    make.centerY.equalTo(container);
    make.top.bottom.greaterThanOrEqualTo(container).with.inset(10);
  }];
  
  [container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.top.bottom.equalTo(starView); }];
  
  return container;
}

- (QMUIButton *)subBtn {
  if (!_subBtn) {
    _subBtn = [QDUIHelper generateDarkFilledButton];
    _subBtn.titleLabel.font = UIFontMake(20);
    [_subBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_subBtn addTarget:self
                action:@selector(submitTap)
      forControlEvents:UIControlEventTouchUpInside];
  }
  return _subBtn;
}

- (void)submitTap {
}

- (void)fml_didClickStarViewByScore:(CGFloat)score atIndex:(NSInteger)index {
}
#pragma mark - UIScrollViewDelegate

- (QMUITextView *)reviewTX {
  if (!_reviewTX) {
    _reviewTX = [[QMUITextView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 400)];
    _reviewTX.userInteractionEnabled = YES;
    _reviewTX.maximumHeight = 400;
    _reviewTX.delegate = self;
    _reviewTX.scrollEnabled = NO;
    _reviewTX.font = UIFontMake(18);
    _reviewTX.placeholder = @"撰写评论";
    _reviewTX.placeholderColor = UIColor.qd_placeholderColor;
    _reviewTX.editable = YES;
    _reviewTX.selectable = YES;
    _reviewTX.layer.cornerRadius = 6.0;
    _reviewTX.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _reviewTX.layer.borderWidth = 1 / ([UIScreen mainScreen].scale);
  }
  return _reviewTX;
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
  // 换行按钮点击
  //  if ([text isEqualToString:@"\n"] && self.returnBlock) {
  //    if (self.returnBlock) self.returnBlock(textView.text);
  //    return NO;
  //  }
  return YES;
}
#pragma mark - 键盘显示，table view content view的偏移
- (void)showKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf = self;
  CGRect keyBoardRect = [userInfo.originUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  weakSelf.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}

- (void)hideKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf = self;
  weakSelf.scrollView.contentInset = UIEdgeInsetsZero;
}
@end
