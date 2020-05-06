//
//  SearchListController.m
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SearchListController.h"
#import "DetailController.h"
#import "DropMenuController.h"
#import "HotelModel.h"
#import "HotelModelList.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "QDAlertHelper.h"
#import "ReMenuView.h"
#import "SearchItemCell.h"
#import <HMSegmentedControl.h>
#define ITEMSERACHCELL @"itemsearchcell"
#define ITEMCELLHEIGHT DEVICE_HEIGHT / 5;

@interface SearchListController () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource, DropMenuDelegate>
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) QMUISearchController *mySearchController;
@property (nonatomic, strong) HMSegmentedControl *segController;
@property (nonatomic, strong) DropMenuController *dropController;
@property (nonatomic, strong) QMUINavigationBarScrollingAnimator *navigationAnimator;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *monView;

@property (nonatomic, strong) NSArray<HotelModel *> *hotelList;
@end

@implementation SearchListController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
#ifdef Test_Hotel
  [self generateImgList];
#endif
  //  self.hotelList = @[ @"", @"", @"", @"" ];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  self.emptyView.backgroundColor = UIColor.qd_backgroundColor;
  [self showEmptyViewWithText:@"稍等"
                   detailText:@"正在加载中"
                  buttonTitle:@"点我试试？"
                 buttonAction:@selector(emptyBtn)];
  
  [self findAllHotel];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)emptyBtn {
  [QDAlertHelper showChooseAlertWithTitle:@"233"
                                  message:@"x1x1x"
                           preferredStyle:QMUIAlertControllerStyleAlert
                               chooseList:@[ @"xx", @"yy" ]
                              chooseBlock:nil];
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
}

- (void)dealloc {
}

#pragma mark - GenerateRooViewDelegate
- (void)generateRootView {
  //  ReMenuView *view = [ReMenuView new];
  self.dropController = [DropMenuController new];
  self.dropController.delegate = self;
  addView(self.view, self.tableView);
  addView(self.view, self.dropController.menu);
  //  addView(self.view, view);
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.dropController.menu.mas_bottom);
    make.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - QMUITablviewDataSource,QMUITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return ITEMCELLHEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    SearchItemCell *siCell =
    [tableView dequeueReusableCellWithIdentifier:ITEMSERACHCELL forIndexPath:indexPath];
    siCell.imgUrl = [self randomImage];
    siCell.model = self.hotelList[indexPath.row];
    return siCell;
  }
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  DetailController *detCon = [DetailController new];
  detCon.hotelModel = self.hotelList[indexPath.row];
  [self.navigationController qmui_pushViewController:detCon
                                            animated:YES
                                          completion:^{
    
  }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

//#pragma mark - Lazy init
//- (HMSegmentedControl *)segController {
//  if (!_segController) {
//    NSArray *titles = @[ @"测试1", @"测试2", @"测试3", @"测试4" ];
//    UIImage *image = UIImageMake(@"more_bottom");
//    NSArray *images = @[ image, image, image, image ];
//    _segController = [[HMSegmentedControl alloc] initWithSectionImages:images
//                                                 sectionSelectedImages:images
//                                                     titlesForSections:titles];
//    _segController.imagePosition = HMSegmentedControlImagePositionRightOfText;
//    _segController.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _segController.selectionIndicatorHeight = 0;
//    _segController.type = HMSegmentedControlTypeTextImages;
//    __weak __typeof(self) weakSelf = self;
//    _segController.selectedSegmentIndex = 3;
//    _segController.indexChangeBlock = ^(NSInteger index) {};
//  }
//  return _segController;
//}

- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:SearchItemCell.class forCellReuseIdentifier:ITEMSERACHCELL];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (void)reloadDataWithQuery:(HotelQueryModel *)queryModel {
  /// todo:联网修改
  queryModel.hotelRank = queryModel.hotelRankList.firstObject;
  [[RequestUtils shareManager] RequestPostWithUrl:FindAllHotel
                                           Object:queryModel
                                          Success:^(NSDictionary *_Nullable dict) {
    HotelModelList *tmpList = [HotelModelList mj_objectWithKeyValues:dict];
    self.hotelList = tmpList.data;
    //    [self.tableView reloadData];
  }
                                          Failure:^(NSError *_Nullable err) { QMUILogWarn(@"query model", @"query failed!"); }];
}

- (void)setHotelList:(NSArray<HotelModel *> *)hotelList {
  _hotelList = hotelList;
  [self.tableView reloadData];
}

#pragma mark - http api
- (void)findAllHotel {
  __weak __typeof(self) weakSelf = self;
  [[RequestUtils shareManager] RequestPostWithUrl:FindAllHotel
                                           Object:nil
                                          Success:^(NSDictionary *_Nullable dict) {
    QMUILogInfo(@"requestutil", @"%@", [dict description]);
    HotelModelList *list =
    [HotelModelList mj_objectWithKeyValues:dict];
    [weakSelf hideEmptyView];
    weakSelf.hotelList = list.data;
  }
                                          Failure:^(NSError *_Nullable err){}];
}

- (void)generateImgList {
  self.imageList = @[
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1588775747639&di="
    @"06e5f2376f3ba86d7a3770dd61af4bf3&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%"
    @"3D1654501700%2C2947179645%26fm%3D214%26gp%3D0.jpg",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1588775766817&di="
    @"44b41411380b65851c0d3f11ac389fe9&imgtype=0&src=http%3A%2F%2Fm.traveldaily.cn%2Fimages%"
    @"2F201705%2F7699a94520cf624f.jpg",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1588775770063&di="
    @"eee18221b67a8c1d35490785dd19071e&imgtype=0&src=http%3A%2F%2Fstatic-news.17house.com%2Fweb%"
    @"2Ftoutiao%2F201704%2F26%2F1493171703700191891.png",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1588775796910&di="
    @"d56868e886769b01434b16e64c6dc9f2&imgtype=0&src=http%3A%2F%2Fm.tuniucdn.com%2Ffilebroker%"
    @"2Fcdn%2Ffilebroker%2Fcdn%2Fprd%2Fa8%2F7a%2Fa87a80d66ededff68f3cd95a5a786973_w0_h600_c0_t0."
    @"jpeg",
    @"https://timgsa.baidu.com/"
    @"timg?image&quality=80&size=b9999_10000&sec=1588775793528&di="
    @"77dd7c5bcbcc37ca00b1b1963f2baaa4&imgtype=0&src=http%3A%2F%2Fs1.lvjs.com.cn%2Fuploads%2Fpc%"
    @"2Fplace2%2F2016-03-01%2Fa3a65e73-5de4-4067-b71f-4bfd5de54992.jpg"
  ];
}

- (NSString *)randomImage {
  return self.imageList[arc4random() % self.imageList.count];
}
@end
