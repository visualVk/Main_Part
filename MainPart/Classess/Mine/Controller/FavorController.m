//
//  FavorController.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "FavorController.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#define CELLHEIGHT DEVICE_HEIGHT / 8
@interface FavorController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, GHDropMenuDelegate>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) GHDropMenu *dropMenu;
@end

@implementation FavorController

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
  self.title = @"我的收藏";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (GHDropMenu *)dropMenu {
  if (!_dropMenu) {
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc] init];
    configuration.recordSeleted = NO;
    configuration.titles = [configuration creaDropMenuData];
    
    __weak __typeof(self) weakSelf = self;
    _dropMenu = [GHDropMenu creatDropMenuWithConfiguration:configuration
                                                     frame:CGRectMake(0, kGHSafeAreaTopHeight, kGHScreenWidth, 44)
                                        dropMenuTitleBlock:^(GHDropMenuModel *_Nonnull dropMenuModel) {
      
    }
                                     dropMenuTagArrayBlock:^(NSArray *_Nonnull tagArray) { [weakSelf getStrWith:tagArray]; }];
    _dropMenu.titleSeletedImageName = @"up_normal";
    _dropMenu.titleNormalImageName = @"down_normal";
    _dropMenu.delegate = self;
    _dropMenu.durationTime = 0.5;
  }
  return _dropMenu;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return CELLHEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return @"test";
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

#pragma mark - DropMenuDelegate
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
  self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@", dropMenuTitleModel.title];
}
- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
  [self getStrWith:tagArray];
}
- (void)getStrWith:(NSArray *)tagArray {
  NSMutableString *string = [NSMutableString string];
  if (tagArray.count) {
    for (GHDropMenuModel *dropMenuTagModel in tagArray) {
      if (dropMenuTagModel.tagSeleted) {
        if (dropMenuTagModel.tagName.length) {
          [string appendFormat:@"%@", dropMenuTagModel.tagName];
        }
      }
      if (dropMenuTagModel.maxPrice.length) {
        [string appendFormat:@"最大价格%@", dropMenuTagModel.maxPrice];
      }
      if (dropMenuTagModel.minPrice.length) {
        [string appendFormat:@"最小价格%@", dropMenuTagModel.minPrice];
      }
      if (dropMenuTagModel.singleInput.length) {
        [string appendFormat:@"%@", dropMenuTagModel.singleInput];
      }
    }
  }
  //  self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@", string];
}
@end
