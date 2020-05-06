//
//  SceneTypeEmbedCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneTypeEmbedCell.h"
#import "MarkUtils.h"
#import "SceneSpotCell.h"
#define SCENESPOTCELL @"scenespotcell"
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"c689c6e6b3ea4aa16719a5dad5b93d36&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%"          \
@"2Fupload%2F19779%2F19778120.JPG",                                                            \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"ded22c5d5202213bfdc3aaeb2f2ecf09&imgtype=0&src=http%3A%2F%2Fwww.bizhidaquan.com%2Fd%"        \
@"2Ffile%2F1%2F1159829.jpg",                                                                   \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"829f7b9b0ba4222a9bab2282e2b239bd&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201310%2F19%2F235356fyjkkugokokczyo0.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"557632a98119862074f6306c6b269a9d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F2017-10-13%2F59e0270c6ba4e.jpg",                                                           \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"8db59485be71f14b5a70286128d1aec1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"4d4057e96f0b47cb8cb04575ba744ef1&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F1%2F53a15a1343174.jpg",                                                                    \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783660279&di="                                \
@"3c9f7da2c66bd25d350e03656e746696&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%"  \
@"3D2155983538%2C3860699715%26fm%3D214%26gp%3D0.jpg",                                          \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513022&di="                                \
@"f8308055cabe18057cb07d55193f547f&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201408%2F05%2F222353wu5y5mzv6mprxvhn.jpg"                                                  \
]
const NSInteger BTNINDEX = 30000;
@interface SceneTypeEmbedCell () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource> {
  NSInteger btnIndex;
  NSInteger preIndex;
  NSInteger count;
}
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIScrollView *topScrollContainer;
@property (nonatomic, strong) QMUIFloatLayoutView *typeFloatView;
@end

@implementation SceneTypeEmbedCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  count = btnIndex = 0;
  preIndex = BTNINDEX;
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.topScrollContainer);
  addView(superview, self.tableview);
  
  [self.topScrollContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(superview);
    make.top.equalTo(superview).with.inset(0.5 * SPACE);
    //    make.bottom.equalTo(self.tableview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(DEVICE_HEIGHT / 20);
  }];
  
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.topScrollContainer.mas_bottom);
    make.left.right.equalTo(superview);
    make.height.mas_equalTo(DEVICE_HEIGHT * 3 / 10);
    make.bottom.lessThanOrEqualTo(superview).with.inset(0.25 * SPACE);
  }];
}

- (UIScrollView *)topScrollContainer {
  if (!_topScrollContainer) {
    _topScrollContainer = [UIScrollView new];
    _topScrollContainer.showsVerticalScrollIndicator = false;
    addView(_topScrollContainer, self.typeFloatView);
    CGSize size = [self.typeFloatView sizeThatFits:CGSizeMake(DEVICE_WIDTH + SPACE, MAXFLOAT)];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, SPACE, 0, 0);
    [self.typeFloatView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(size);
      make.edges.equalTo(_topScrollContainer).with.insets(padding);
    }];
  }
  return _topScrollContainer;
}

- (QMUITableView *)tableview {
  if (!_tableview) {
    _tableview = [QMUITableView new];
    [_tableview registerClass:SceneSpotCell.class forCellReuseIdentifier:SCENESPOTCELL];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
  }
  return _tableview;
}

- (QMUIFloatLayoutView *)typeFloatView {
  if (!_typeFloatView) {
    _typeFloatView = [[QMUIFloatLayoutView alloc] initWithFrame:CGRectZero];
    _typeFloatView.itemMargins = UIEdgeInsetsMake(0, 5, 0, 5);
    for (int i = 0; i < 4; i++) {
      addView(_typeFloatView, [self generateCustomBtn:[self testTitle:i]]);
    }
  }
  return _typeFloatView;
}

- (NSString *)testTitle:(NSInteger)index {
  switch (index) {
    case 0:
      return @"一日游";
      break;
    case 1:
      return @"高端游";
      break;
    case 2:
      return @"跟团游";
      break;
      
    default:
      return @"自助游";
      break;
  }
}

- (QMUIGhostButton *)generateCustomBtn:(NSString *)title {
  QMUIGhostButton *btn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
  btn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
  btn.tag = BTNINDEX + count;
  count++;
  [btn setTitle:title forState:UIControlStateNormal];
  [btn addTarget:self action:@selector(scrollTo:) forControlEvents:UIControlEventTouchUpInside];
  return btn;
}

- (void)scrollTo:(QMUIGhostButton *)button {
  [button setBackgroundColor:UIColor.qd_tintColor];
  [button setGhostColor:GhostButtonColorWhite];
  QMUIGhostButton *preBtn = [self.typeFloatView viewWithTag:preIndex];
  //  preBtn.selected = false;
  if (preIndex != button.tag) {
    preIndex = button.tag;
    [preBtn setBackgroundColor:UIColor.whiteColor];
    [preBtn setGhostColor:GhostButtonColorGray];
  }
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return DEVICE_HEIGHT / 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SceneSpotCell *ssCell =
  [tableView dequeueReusableCellWithIdentifier:SCENESPOTCELL forIndexPath:indexPath];
  [ssCell.sceneImg sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % imgList.count]]
                     placeholderImage:UIImageMake(@"pink-gradient")];
  //  @property(nonatomic, strong) UIImageView *sceneImg;
  //  @property(nonatomic, strong) UILabel *title;
  //  @property(nonatomic, strong) UILabel *score;
  //  @property(nonatomic, strong) QMUILabel *special;
  //  @property(nonatomic, strong) QMUILabel *stars;
  switch (indexPath.row) {
    case 0:
      ssCell.title.text = @"四川";
      break;
    case 1:
      ssCell.title.text = @"草原";
      break;
    case 2:
      ssCell.title.text = @"瀑布";
      break;
    default:
      break;
  }
  return ssCell;
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

@end
