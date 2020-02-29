//
//  ToolCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ToolCell.h"
#import "FaceController.h"
#import "MarkUtils.h"
#import "QRCodeScanController.h"
#import "SimpleImageTitleView.h"
#import "SimpleTitleView.h"

@interface ToolCell () <GenerateEntityDelegate>
@property (nonatomic, strong) SimpleTitleView *titleView;
@property (nonatomic, strong) QMUIGridView *toolGridView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIViewController *parentController;
@end

@implementation ToolCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.datas = @[
    @{ @"title" : @"爆炸",
       @"image" : @"emotion_04" },
    @{ @"title" : @"就是",
       @"image" : @"emotion_04" },
    @{ @"title" : @"艺术",
       @"image" : @"emotion_04" },
    @{ @"title" : @"咸鱼突",
       @"image" : @"emotion_04" },
    @{ @"title" : @"刺",
       @"image" : @"emotion_04" },
    @{ @"title" : @"派大星",
       @"image" : @"emotion_04" },
    @{ @"title" : @"蘑菇云",
       @"image" : @"emotion_04" },
    @{ @"title" : @"CNM",
       @"image" : @"emotion_04" }
  ];
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
  addView(superview, self.container);
  addView(self.container, self.titleView);
  addView(self.container, self.toolGridView);
  
  self.container.backgroundColor = UIColor.qmui_randomColor;
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  CGSize gridSize = [self.toolGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH - SPACE, MAXFLOAT)];
  [self.toolGridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.container);
    make.height.mas_equalTo(gridSize.height);
    make.bottom.equalTo(self.container);
  }];
}

- (SimpleTitleView *)titleView {
  if (!_titleView) {
    _titleView = [SimpleTitleView new];
    _titleView.qmui_borderColor = UIColor.qd_separatorColor;
    _titleView.qmui_borderPosition = QMUIViewBorderPositionBottom;
  }
  return _titleView;
}

- (QMUIGridView *)toolGridView {
  if (!_toolGridView) {
    _toolGridView = [[QMUIGridView alloc] initWithColumn:4 rowHeight:DEVICE_HEIGHT / 12];
    SimpleImageTitleView *view = nil;
    for (int i = 0; i < self.datas.count; i++) {
      view = [ToolCell generateToolGrid:self.datas[i]];
      [self addTap:view];
      addView(_toolGridView, view);
    }
  }
  return _toolGridView;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.layer.cornerRadius = 10;
    _container.layer.borderColor = UIColor.clearColor.CGColor;
    _container.layer.masksToBounds = YES;
  }
  return _container;
}

- (void)addTap:(SimpleImageTitleView *)view {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridClick:)];
  [view addGestureRecognizer:tap];
}

- (void)gridClick:(UITapGestureRecognizer *)gesture {
  SimpleImageTitleView *view = gesture.qmui_targetView;
  QMUILogInfo(@"tool cell", @"click:%@", view.title.text);
  if (!self.parentController) { self.parentController = [self qmui_viewController]; }
  if ([@"刺" isEqualToString:view.title.text]) {
    FaceController *faCon = [[FaceController alloc] initWithFaceType:RegisterFace];
    [self.parentController.navigationController pushViewController:faCon animated:YES];
  }
  QRCodeScanController *qrCon = [QRCodeScanController new];
  [self.parentController.navigationController pushViewController:qrCon animated:YES];
}

+ (SimpleImageTitleView *)generateToolGrid:(NSDictionary *)infoDict {
  SimpleImageTitleView *grid = [SimpleImageTitleView new];
  grid.title.text = infoDict[@"title"];
  grid.title.font = UIFontMake(13);
  grid.image.image = UIImageMake(infoDict[@"image"]);
  return grid;
}
@end
