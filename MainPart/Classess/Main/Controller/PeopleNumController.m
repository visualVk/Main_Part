//
//  PeopleNumController.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PeopleNumController.h"
#import "HotelNumberCell.h"
#import "MarkUtils.h"
#define HOTELNUMBERCELL1 @"hotelnumbercell1"
#define HOTELNUMBERCELL2 @"hotelnumbercell2"
#define HOTELNUMBERCELL3 @"hotelnumbercell3"

@interface PeopleNumController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, PPNumberButtonDelegate> {
  CGFloat one;
  CGFloat two;
  CGFloat three;
}
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUIButton *confirmBtn;
@end

@implementation PeopleNumController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  one = two = three = 1;
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
  self.title = @"入住条件";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  addView(self.view, self.confirmBtn);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.confirmBtn.mas_top);
  }];
  
  [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view).with.inset(0.5 * SPACE);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:HotelNumberCell.class forCellReuseIdentifier:HOTELNUMBERCELL1];
    [_tableView registerClass:HotelNumberCell.class forCellReuseIdentifier:HOTELNUMBERCELL2];
    [_tableView registerClass:HotelNumberCell.class forCellReuseIdentifier:HOTELNUMBERCELL3];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (QMUIButton *)confirmBtn {
  if (!_confirmBtn) {
    _confirmBtn = [QDUIHelper generateDarkFilledButton];
    _confirmBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = UIFontBoldMake(18);
    [_confirmBtn addTarget:self
                    action:@selector(back2Prev)
          forControlEvents:UIControlEventTouchUpInside];
  }
  return _confirmBtn;
}

- (void)back2Prev {
  if (self.pepleSelectBlock) {
    NSInteger tot = one + two + three;
    self.pepleSelectBlock(tot);
  }
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HotelNumberCell *hnCell;
  if (indexPath.row == 0) {
    hnCell = [tableView dequeueReusableCellWithIdentifier:HOTELNUMBERCELL1 forIndexPath:indexPath];
    hnCell.title.text = @"普通间";
    hnCell.stepBtn.currentNumber = 1.0;
  } else if (indexPath.row == 1) {
    hnCell = [tableView dequeueReusableCellWithIdentifier:HOTELNUMBERCELL2 forIndexPath:indexPath];
    hnCell.stepBtn.currentNumber = 0;
    hnCell.title.text = @"儿童间";
  } else {
    hnCell = [tableView dequeueReusableCellWithIdentifier:HOTELNUMBERCELL3 forIndexPath:indexPath];
    hnCell.stepBtn.currentNumber = 0;
    hnCell.title.text = @"无障碍";
  }
  hnCell.stepBtn.minValue = 0;
  hnCell.stepBtn.tag = indexPath.row;
  hnCell.stepBtn.delegate = self;
  switch (indexPath.row) {
    case 0:
      hnCell.stepBtn.currentNumber = one;
      break;
    case 1:
      hnCell.stepBtn.currentNumber = two;
      break;
    case 2:
      hnCell.stepBtn.currentNumber = three;
    default:
      break;
  }
  return hnCell;
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

- (void)pp_numberButton:(PPNumberButton *)numberButton
                 number:(NSInteger)number
         increaseStatus:(BOOL)increaseStatus {
  if (numberButton.tag == 0) {
    one = number;
  } else if (numberButton.tag == 1) {
    two = number;
  } else {
    three = number;
  }
}
@end
