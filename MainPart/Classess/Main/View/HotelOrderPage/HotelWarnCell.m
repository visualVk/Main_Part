//
//  HotelWarnCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelWarnCell.h"
#import "DetailPresentNavBar.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>
@interface HotelWarnCell () <GenerateEntityDelegate, QMUITableViewDelegate, QMUITableViewDataSource>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSArray *warnInfo;
@end

@implementation HotelWarnCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.warnInfo = @[
    @{ @"title" : @"·行李",
       @"content" : @"·如果要行李提前送达，请提前通知" },
    @{
      @"title" : @"·携带物品",
      @"content" :
        @"·不允许携带管制刀具\n·不允许携带质量过大的物品\n·禁止携带易"
      @"燃"
      @"易"
      @"暴"
      @"物"
      @"品"
    },
    @{ @"title" : @"·宠物",
       @"content" : @"·如有宠物请提前通知，房间内不予许方宠物" },
    @{ @"title" : @"·签证问题",
       @"content" : @"·如果需要办理签证，可以提前联系前台，代办" },
    @{
      @"title" : @"·停车问题",
      @"content" :
        @"·本酒店提供住宿期间免费停车服务\n·本酒店只允许登记过的酒店"
      @"入"
      @"库"
    }
  ];
  self.backgroundColor = UIColor.clearColor;
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
  //  addView(superview, self.container);
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
  
  [self.orderWarn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [self.showAll mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.trailing.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.orderWarn.mas_bottom).with.inset(0.5 * SPACE);
    make.right.left.equalTo(self.container).with.inset(0.5 * SPACE);
    make.bottom.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.orderWarn);
    addView(_container, self.showAll);
    addView(_container, self.content);
    _container.backgroundColor = UIColor.qd_backgroundColor;
    _container.layer.cornerRadius = 8;
    _container.layer.masksToBounds = YES;
    addView(self.contentView, _container);
    
    UIView *shadowView = [UIView new];
    shadowView.layer.shadowRadius = 8;
    shadowView.backgroundColor = UIColor.qd_backgroundColor;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowOpacity = 0.25;
    shadowView.layer.borderColor = UIColor.clearColor.CGColor;
    [self.contentView insertSubview:shadowView belowSubview:_container];
    [shadowView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
  }
  return _container;
}

- (UILabel *)orderWarn {
  if (!_orderWarn) {
    _orderWarn = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"warn");
        make.alignment = SJUTVerticalAlignmentCenter;
      });
      make.append(@"订房必读");
    }];
    _orderWarn.attributedText = str;
  }
  return _orderWarn;
}

- (UILabel *)showAll {
  if (!_showAll) {
    _showAll = [UILabel new];
    _showAll.userInteractionEnabled = YES;
    _showAll.text = @"查看全部";
    _showAll.textColor = UIColor.qd_tintColor;
    _showAll.font = UIFontMake(14);
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWarn)];
    [_showAll addGestureRecognizer:tap];
  }
  return _showAll;
}

- (UILabel *)content {
  if (!_content) {
    _content = [UILabel new];
    _content.numberOfLines = 0;
    _content.attributedText = [self generateWarn:@[
      @"·如有宠物请提前通知，房间内不予许方宠物",
      @"·如果要行李提前送达，请提前通知", @"·不允许携带管制刀具"
    ]];
  }
  return _content;
}

- (NSAttributedString *)generatePresentWarn:(NSDictionary *)warns {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.grayColor).font(UIFontMake(16));
    for (NSString *key in warns.allKeys) {
      make.append([NSString stringWithFormat:@"·%@", key])
      .textColor(UIColor.qd_mainTextColor)
      .font(UIFontBoldMake(18));
      make.append([NSString stringWithFormat:@"\n%@\n", warns[key]]);
    }
  }];
  return str;
}

- (NSAttributedString *)generateWarn:(NSArray *)warns {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.blackColor).font(UIFontBoldMake(14));
    for (NSString *warnStr in warns) {
      make.append(warnStr);
      make.append(@"\n");
    }
  }];
  return str;
}

- (void)showWarn {
  //  if (!self.presentWarn) [self presentWarn];
  QMUIModalPresentationViewController *modalViewController =
  [[QMUIModalPresentationViewController alloc] init];
  modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
  modalViewController.contentView = self.tableView;
  modalViewController.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
  __weak __typeof(self) weakSelf = self;
  modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight,
                                      CGRect contentViewDefaultFrame) {
    weakSelf.tableView.qmui_frameApplyTransform = CGRectSetXY(
                                                              weakSelf.tableView.frame,
                                                              CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(weakSelf.tableView.frame)),
                                                              CGRectGetHeight(containerBounds) - CGRectGetHeight(weakSelf.tableView.bounds));
  };
  [modalViewController showWithAnimated:YES completion:^(BOOL finished){}];
}

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView =
    [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT * 2 / 3)];
    UIBezierPath *path =
    [UIBezierPath bezierPathWithRoundedRect:_tableView.frame
                          byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    maskLayer.frame = _tableView.frame;
    _tableView.layer.mask = maskLayer;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.bounces = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.warnInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                             withStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier];
  }
  NSDictionary *dict = self.warnInfo[indexPath.row];
  cell.textLabel.attributedText = [self generatePresentWarn:@{
    dict[@"title"] : dict[@"content"],
  }];
  cell.textLabel.numberOfLines = 0;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
