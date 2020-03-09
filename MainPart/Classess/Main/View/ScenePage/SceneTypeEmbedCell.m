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
    make.height.mas_equalTo(DEVICE_HEIGHT/20);
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
    for (int i = 0; i < 4; i++) { addView(_typeFloatView, [self generateCustomBtn:@"一日游"]); }
  }
  return _typeFloatView;
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
