//
//  MineOrderInfoCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderInfoCell.h"
#import "MarkUtils.h"
#import "MineOrderInfoTBCell.h"
#define MINEORDERINFOTBCELLNONERIGHT @"mineorderinfotbcellnoneright"
#define MINEORDERINFOTBCELLHAVERIGHT @"mineorderinfotbcellhaveright"

@interface MineOrderInfoCell () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUILabel *title;
@property (nonatomic, strong) UIView *container;

@end

@implementation MineOrderInfoCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    //    self.contentView.qmui_borderColor = UIColor.qd_separatorColor;
    //    self.contentView.qmui_borderPosition = QMUIViewBorderPositionTop;
    //    self.contentView.qmui_borderWidth = 0.5;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.title);
    addView(_container, self.tableView);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(_container).with.inset(0.25 * SPACE);
      make.height.mas_equalTo(25);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.title.mas_bottom).with.inset(0.5 * SPACE);
      make.left.right.equalTo(_container).with.inset(0.5 * SPACE);
      make.bottom.equalTo(_container);
    }];
  }
  return _container;
}

- (QMUILabel *)title {
  if (!_title) {
    _title = [QMUILabel new];
    _title.contentEdgeInsets = UIEdgeInsetsMake(0, 0.25 * SPACE, 0, 0);
    _title.highlightedBackgroundColor = nil;
    _title.highlightedTextColor = nil;
    _title.qmui_borderColor = UIColor.orangeColor;
    _title.qmui_borderWidth = 2;
    _title.qmui_borderPosition = QMUIViewBorderPositionLeft;
    _title.text = @"订单信息";
  }
  return _title;
}

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:MineOrderInfoTBCell.class
       forCellReuseIdentifier:MINEORDERINFOTBCELLNONERIGHT];
    [_tableView registerClass:MineOrderInfoTBCell.class
       forCellReuseIdentifier:MINEORDERINFOTBCELLHAVERIGHT];
    _tableView.scrollEnabled = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  MineOrderInfoTBCell *moitbCell = nil;
  if (row == 0) {
    moitbCell = [tableView dequeueReusableCellWithIdentifier:MINEORDERINFOTBCELLHAVERIGHT
                                                forIndexPath:indexPath];
    moitbCell.detailL.text = @"87578949848948489489";
    moitbCell.rightL.text = @"复制";
  } else if (row == 1) {
    moitbCell = [tableView dequeueReusableCellWithIdentifier:MINEORDERINFOTBCELLHAVERIGHT
                                                forIndexPath:indexPath];
    moitbCell.titleL.text = @"交易号:";
    moitbCell.detailL.text = @"ysln";
  } else if (row == 2) {
    moitbCell = [tableView dequeueReusableCellWithIdentifier:MINEORDERINFOTBCELLHAVERIGHT
                                                forIndexPath:indexPath];
    moitbCell.titleL.text = @"创建时间:";
    moitbCell.detailL.text = @"2020-03-03 18:19:39";
  }
  moitbCell.selectionStyle = UITableViewCellSelectionStyleNone;
  return moitbCell;
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
