//
//  OrderCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderCell.h"
#import "MarkUtils.h"
#import "NSDictionary+LoadJson.h"
#import "NSObject+BlockSEL.h"
#import "OrderController.h"
#import "SimpleImageTitleView.h"
#import <SJAttributesFactory.h>
const NSInteger ORDERINDEX = 30000;
@interface OrderCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUIGridView *orderGridView;
@property (nonatomic, strong) UIViewController *parentController;
@end

@implementation OrderCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  //  self.datas = @[
  //    @{ @"image" : @"check_selected",
  //       @"title" : @"全部订单" },
  //    @{ @"image" : @"check_selected",
  //       @"title" : @"未付款" },
  //    @{ @"image" : @"check_selected",
  //       @"title" : @"爆炸" },
  //    @{ @"image" : @"check_selected",
  //       @"title" : @"就是艺术" }
  //  ];
  self.datas = [NSDictionary readLocalFileWithName:@"OrderModelListJSON"][@"order"];
  [self generateRootView];
  self.backgroundColor = UIColor.clearColor;
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
  addView(superview, self.orderGridView);
  
  CGSize girdSize = [self.orderGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.orderGridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(superview).with.inset(.5 * SPACE);
    make.centerY.equalTo(superview);
    make.height.mas_equalTo(girdSize.height);
  }];
  
  self.orderGridView.layer.cornerRadius = 10;
  self.orderGridView.layer.masksToBounds = YES;
  self.orderGridView.backgroundColor = UIColor.qd_backgroundColor;
}

- (QMUIGridView *)orderGridView {
  if (!_orderGridView) {
    _orderGridView = [[QMUIGridView alloc] initWithColumn:4 rowHeight:DEVICE_HEIGHT / 10];
    _orderGridView.clipsToBounds = YES;
    SimpleImageTitleView *view = nil;
    for (int i = 0; i < 4; i++) {
      view = [OrderCell generateOrderGird:self.datas[i]];
      view.tag = ORDERINDEX + i;
      [self addTap:view];
      [_orderGridView addSubview:view];
    }
  }
  return _orderGridView;
}

- (void)addTap:(SimpleImageTitleView *)view {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridClick:)];
  [view addGestureRecognizer:tap];
}

- (void)gridClick:(UITapGestureRecognizer *)gesture {
  SimpleImageTitleView *view = gesture.qmui_targetView;
  if (!self.parentController) { self.parentController = [self qmui_viewController]; }
  UIViewController *desCon = nil;
  switch (view.tag - ORDERINDEX) {
    case 0:
      desCon = [[OrderController alloc] initWithOrderType:AllOrder];
      break;
    case 1:
      desCon = [[OrderController alloc] initWithOrderType:NonPaymentOrder];
      break;
    case 2:
      desCon = [[OrderController alloc] initWithOrderType:FutureOrder];
      break;
    case 3:
      desCon = [[OrderController alloc] initWithOrderType:RemarkOrder];
      break;
    default:
      break;
  }
  [self.parentController.navigationController pushViewController:desCon animated:YES];
  QMUILogInfo(@"order cell", @"click:%@", view.title.text);
}

+ (SimpleImageTitleView *)generateOrderGird:(NSDictionary *)infoDict {
  SimpleImageTitleView *grid = [SimpleImageTitleView new];
  grid.image.image = UIImageMake(infoDict[@"image"]);
  grid.title.text = infoDict[@"title"];
  return grid;
}
@end
