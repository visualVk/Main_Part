//
//  FavorController.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "FavorController.h"
#import "HotelModelList.h"
#import "MarkUtils.h"
#import "MineFavorCell.h"
#define FAVORCELL @"favorcell"
#define CELLHEIGHT DEVICE_HEIGHT / 8
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588774467241&di="                                \
@"fb358dc0537c255c00aa2559bbd9197c&imgtype=0&src=http%3A%2F%2Fhotels.buytrip.cn%2Fhotelimg%"   \
@"2F2012922135236429.jpg",                                                                     \
@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/"                                    \
@"u=775827514,337286644&fm=26&gp=0.jpg"                                                        \
]
@interface FavorController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotelName;
@end

@implementation FavorController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.hotelName = [NSMutableArray new];
  [self.hotelName addObject:@"1"];
  [self.hotelName addObject:@"1"];
  [self.hotelName addObject:@"1"];
  [self findAllHotel];
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
  self.emptyView.backgroundColor = UIColor.whiteColor;
  [self showEmptyViewWithLoading];
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

- (void)dealloc {
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.view, self.tableView);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy Init
- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [QMUITableView new];
    [_tableView registerClass:MineFavorCell.class forCellReuseIdentifier:FAVORCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//  return 22;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"一周内";
      break;
    case 1:
      return @"一个月内";
    case 2:
      return @"一年内";
    default:
      return @"很久以前";
      break;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MineFavorCell *hotelCell =
  [tableView dequeueReusableCellWithIdentifier:FAVORCELL forIndexPath:indexPath];
  [hotelCell.imageview
   sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % imgList.count]]
   placeholderImage:UIImageMake(@"pink_gradient")];
  hotelCell.title.text = self.hotelName[indexPath.section];
  return hotelCell;
  //  static NSString *identifier = @"cell";
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  //  if (!cell) {
  //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
  //                                  reuseIdentifier:identifier];
  //  }
  //  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)findAllHotel {
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager] RequestPostWithUrl:FindAllHotel
                                           Object:nil
                                          Success:^(NSDictionary *_Nullable dict) {
    HotelModelList *list =
    [HotelModelList mj_objectWithKeyValues:dict];
    NSArray<HotelModel *> *arr = list.data;
    [weakSelf.hotelName removeAllObjects];
    for (HotelModel *md in arr) {
      [weakSelf.hotelName addObject:md.hotelName];
    }
    [weakSelf.tableView reloadData];
    [weakSelf hideEmptyView];
  }
                                          Failure:^(NSError *_Nullable err){
    
  }];
}
@end
