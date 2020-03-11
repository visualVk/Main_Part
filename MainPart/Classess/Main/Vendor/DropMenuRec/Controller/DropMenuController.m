//
//  DropMenuController.m
//  DropMenuRe
//
//  Created by blacksky on 2020/3/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DropMenuController.h"
#import "HotelParamList.h"
#import "RankList.h"
#import "TownList.h"
#import <QMUIKit.h>
@interface DropMenuController () <WMZDropMenuDelegate>
@property (nonatomic, strong) NSMutableDictionary *cityDict;
@property (nonatomic, strong) TownList *townList;
@property (nonatomic, strong) RankList *rankList;
@property (nonatomic, strong) NSMutableDictionary *rankDict;
@property (nonatomic, strong) NSMutableArray *rankKeyList;
@property (nonatomic, strong) HotelQueryModel *hotelQueryModel;
@property (nonatomic, strong) NSArray *hotelParamList;
@property (nonatomic, strong) NSMutableArray *hotelParamTitleList;
@property (nonatomic, strong) NSMutableArray *hotelTypeList;
@end

@implementation DropMenuController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  //初始化查询对象
  self.hotelQueryModel = [[HotelQueryModel alloc] init];
  
  //加载town数据
  NSString *path = [[NSBundle mainBundle] pathForResource:@"TownListJSON" ofType:@"json"];
  NSData *data = [[NSData alloc] initWithContentsOfFile:path];
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  self.townList = [[TownList alloc] initWithDictionary:dict];
  self.cityDict = [[NSMutableDictionary alloc] init];
  for (Town *town in self.townList.town) { [self.cityDict setValue:town.child forKey:town.name]; }
  
  //加载rank数据
  path = [[NSBundle mainBundle] pathForResource:@"RankModelListJSON" ofType:@"json"];
  data = [[NSData alloc] initWithContentsOfFile:path];
  dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  self.rankList = [[RankList alloc] initWithDictionary:dict];
  self.rankDict = [[NSMutableDictionary alloc] init];
  self.rankKeyList = [[NSMutableArray alloc] initWithCapacity:self.rankList.rank.count];
  for (Rank *myrank in self.rankList.rank) {
    [self.rankDict setValue:[[NSNumber numberWithInteger:myrank.type] stringValue]
                     forKey:myrank.title];
    [self.rankKeyList addObject:myrank.title];
  }
  
  //加载hotel param数据
  path = [[NSBundle mainBundle] pathForResource:@"HotelParamListJSON" ofType:@"json"];
  data = [[NSData alloc] initWithContentsOfFile:path];
  dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  self.hotelParamTitleList = [[NSMutableArray alloc] init];
  self.hotelTypeList = [[NSMutableArray alloc] init];
  HotelParamList *hotelParamList = [[HotelParamList alloc] initWithDictionary:dict];
  self.hotelParamList = hotelParamList.hotelParam;
  NSMutableArray *tmpArr = nil;
  for (HotelParam *hotelParam in self.hotelParamList) {
    tmpArr = [NSMutableArray arrayWithCapacity:hotelParam.title.count];
    for (Title *title in hotelParam.title) { [tmpArr addObject:title.string]; }
    [self.hotelParamTitleList addObject:tmpArr];
    [self.hotelTypeList addObject:hotelParam.type];
  }
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  //  [self.view addSubview:self.menu];
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
  self.title = @"菜单";
}

- (void)generateRootView {
}

- (NSArray *)titleArrInMenu:(WMZDropDownMenu *)menu {
  return @[
    @{
      @"name" : @"综合排序",
      @"normalImage" : @"menu_dowm",
      @"selectImage" : @"menu_up",
      @"selectColor" : UIColor.systemBlueColor
    },
    @{
      @"name" : @"地理位置",
      @"normalImage" : @"menu_dowm",
      @"selectImage" : @"menu_up",
      @"selectColor" : UIColor.systemBlueColor
    },
    @{
      @"name" : @"酒店星级",
      @"normalImage" : @"menu_dowm",
      @"selectImage" : @"menu_up",
      @"selectColor" : UIColor.systemBlueColor
    },
    @{
      @"name" : @"筛选",
      @"normalImage" : @"menu_dowm",
      @"selectImage" : @"menu_up",
      @"selectColor" : UIColor.systemBlueColor
    },
  ];
}

- (NSInteger)menu:(WMZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section {
  if (section == 1) {
    return 2;
  } else if (section == 3) {
    return self.hotelParamList.count;
  }
  
  return 1;
}

- (NSArray *)menu:(WMZDropDownMenu *)menu
dataForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 0) {
    //    return @[
    //      @"综合排名", @"价格低到高", @"价格高到低", @"距离近到远", @"距离远到近", @"评分高到低",
    //      @"评分低到高"
    //    ];
    return self.rankKeyList;
  } else if (dropIndexPath.section == 1) {
    if (dropIndexPath.row == 0)
      //      return @[ @"瓯海", @"鹿城", @"龙湾", @"平阳", @"永强", @"泰顺", @"不知道了" ];
      return self.cityDict.allKeys;
    if (dropIndexPath.row == 1) return @[];
  } else if (dropIndexPath.section == 2) {
    return @[ @"一星", @"二星", @"三星", @"四星", @"五星" ];
  } else if (dropIndexPath.section == 3) {
    if (dropIndexPath.row == 0)
      return @[ @{ @"config" : @{@"lowPlaceholder" : @"起步价", @"highPlaceholder" : @"最高价"} } ];
    
    return self.hotelParamTitleList[dropIndexPath.row];
    //    if (dropIndexPath.row == 1) {
    //      return @[ @"美团专送", @"到店自取" ];
    //    }
    //    if (dropIndexPath.row == 2)
    //      return @[
    //        @"优惠商家", @"满减优惠", @"近端领券", @"折扣商品", @"优惠商家", @"满减优惠",
    //        @"近端领券", @"折扣商品", @"优惠商家", @"满减优惠", @"近端领券", @"折扣商品"
    //      ];
    //    if (dropIndexPath.row == 3)
    //      return @[
    //        @"跨天预定", @"开发票",
    //        @{ @"name" : @"赠准时宝",
    //           @"image" : @"menu_xinyong" },
    //        @{ @"name" : @"极速退款",
    //           @"image" : @"menu_xinyong" }
    //      ];
    //    if (dropIndexPath.row == 4)
    //      return @[
    //        @"30分钟内", @"40分钟内", @"50分钟内", @"60分钟内", @"30km内", @"40km内", @"50km内",
    //        @"60km内"
    //      ];
  }
  return @[];
}

- (NSInteger)menu:(WMZDropDownMenu *)menu
countForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) {
    if (dropIndexPath.row == 0) return 1;
    return 3;
  }
  return 2;
}

#define titleArr2 @[ @"酒店价格", @"酒店星级", @"酒店类型", @"当地特色酒店", @"优惠活动" ]
- (NSString *)menu:(WMZDropDownMenu *)menu
titleForHeadViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) {
    //    return titleArr2[dropIndexPath.row];
    return self.hotelTypeList[dropIndexPath.row];
  }
  return nil;
}

- (CGFloat)menu:(WMZDropDownMenu *)menu
heightAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath
    AtIndexPath:(NSIndexPath *)indexpath {
  if (dropIndexPath.section == 0 || dropIndexPath.section == 1) { return 40; }
  return 35;
}
- (CGFloat)menu:(WMZDropDownMenu *)menu
heightForFootViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) { return 20; }
  return 0;
}

- (CGFloat)menu:(WMZDropDownMenu *)menu
heightForHeadViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) { return 35; }
  return 0;
}

- (MenuShowAnimalStyle)menu:(WMZDropDownMenu *)menu
showAnimalStyleForRowInSection:(NSInteger)section {
  return MenuShowAnimalBottom;
}
- (MenuHideAnimalStyle)menu:(WMZDropDownMenu *)menu
hideAnimalStyleForRowInSection:(NSInteger)section {
  return MenuHideAnimalTop;
}

- (MenuUIStyle)menu:(WMZDropDownMenu *)menu
uiStyleForRowIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 2 || dropIndexPath.section == 3) {
    if (dropIndexPath.row == 0 && dropIndexPath.section == 3) return MenuUICollectionRangeTextField;
    return MenuUICollectionView;
  }
  return MenuUITableView;
}

- (BOOL)menu:(WMZDropDownMenu *)menu showExpandAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) {
    NSArray *arr = self.hotelParamTitleList[dropIndexPath.row];
    if (arr.count > 6) return YES;
  }
  return NO;
}

- (BOOL)menu:(WMZDropDownMenu *)menu closeWithTapAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 1 && dropIndexPath.row == 1)
    return YES;
  else if (dropIndexPath.section == 0)
    return YES;
  return NO;
}

- (BOOL)menu:(WMZDropDownMenu *)menu dropIndexPathConnectInSection:(NSInteger)section {
  return NO;
}

- (void)menu:(WMZDropDownMenu *)menu
didSelectRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath
dataIndexPath:(NSIndexPath *)indexpath
        data:(WMZDropTree *)data {
  //更新地区
  if (dropIndexPath.section == 1) {
    if (dropIndexPath.row == 0) {
      //      [menu updateData:self.dataDic[data.name] ForRowAtDropIndexPath:dropIndexPath];
      [menu updateData:self.cityDict[data.name] ForRowAtDropIndexPath:dropIndexPath];
    } else {
      QMUILogInfo(@"drop menu controller", @"select:%@", data.name);
      self.hotelQueryModel.hotelDistance = data.name;
    }
  } else if (dropIndexPath.section == 0) {
    QMUILogInfo(@"drop menu controller", @"select:%@", data.name);
    self.hotelQueryModel.hotelQueryOrder = dropIndexPath.row;
  }
  if (dropIndexPath.section == 1 || dropIndexPath.section == 0) {
    if ([self.delegate respondsToSelector:@selector(reloadDataWithQuery:)]) {
      [self.delegate reloadDataWithQuery:self.hotelQueryModel];
    }
  }
}

- (void)menu:(WMZDropDownMenu *)menu
customDefauultCollectionFootView:(WMZDropConfirmView *)confirmView {
  confirmView.showBorder = YES;
  confirmView.confirmBtn.backgroundColor = UIColor.systemBlueColor;
  [confirmView.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)menu:(WMZDropDownMenu *)menu
didConfirmAtSection:(NSInteger)section
selectNoramelData:(NSMutableArray *)selectNoramalData
selectStringData:(NSMutableArray *)selectData {
  QMUILogInfo(@"drop menu controller", @"%@", [selectData description]);
  if (section == 2) {
    self.hotelQueryModel.hotelRankList = selectData;
  } else if (section == 3) {
    for (WMZDropTree *tree in selectNoramalData) {
      if (tree.depth == 0) {
        self.hotelQueryModel.lowPrice = [tree.rangeArr[0] floatValue];
        self.hotelQueryModel.highPrice = [tree.rangeArr[1] floatValue];
      } else if (tree.depth == 1) {
        [self.hotelQueryModel.roomComboList addObject:tree.name];
      } else if (tree.depth == 2) {
        self.hotelQueryModel.hotelComment = 100;
      } else if (tree.depth == 3) {
        [self.hotelQueryModel.discountList addObject:tree.name];
      } else if (tree.depth == 4) {
        [self.hotelQueryModel.brandList addObject:tree.name];
      }
    }
  }
  if ([self.delegate respondsToSelector:@selector(reloadDataWithQuery:)]) {
    [self.delegate reloadDataWithQuery:self.hotelQueryModel];
  }
}

- (void)menu:(WMZDropDownMenu *)menu getAllSelectData:(NSArray *)selectData {
  QMUILogInfo(@"drop menu controller", @"%@", [selectData description]);
}

- (WMZDropDownMenu *)menu {
  if (!_menu) {
    WMZDropMenuParam *param = MenuParam()
    .wCollectionViewCellSelectTitleColorSet([UIColor whiteColor])
    .wCollectionViewSectionRecycleCountSet(8)
    .wMaxHeightScaleSet(0.5)
    .wMainRadiusSet(10)
    .wCollectionViewCellSelectBgColorSet(UIColor.systemBlueColor)
    .wCollectionViewSectionRecycleCountSet(6);
    
    _menu = [[WMZDropDownMenu alloc]
             initWithFrame:CGRectMake(0, Menu_NavigationBar, Menu_Width, DEVICE_HEIGHT / 20)
             withParam:param];
    _menu.delegate = self;
  }
  return _menu;
}

- (MenuEditStyle)menu:(WMZDropDownMenu *)menu
editStyleForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath {
  if (dropIndexPath.section == 3) {
    if (dropIndexPath.row && dropIndexPath.row != 2) return MenuEditMoreCheck;
  }
  if (dropIndexPath.section == 2) return MenuEditMoreCheck;
  return MenuEditOneCheck;
}
@end
