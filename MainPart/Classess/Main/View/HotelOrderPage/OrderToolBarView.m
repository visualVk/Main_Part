//
//  OrderToolBarView.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "OrderToolBarView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface OrderToolBarView () <GenerateEntityDelegate, QMUITableViewDelegate,
QMUITableViewDataSource>
@property (nonatomic, strong) UIView *leftContainer;
@property (nonatomic, strong) UIViewController *parentController;
@end

@implementation OrderToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.askSupplier);
  addView(self, self.askSupplierTitle);
  addView(self, self.leftContainer);
  
  [self.askSupplier mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self).with.inset(SPACE);
    make.centerX.equalTo(self.askSupplierTitle);
  }];
  
  [self.askSupplierTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.centerX.equalTo(self.askSupplier);
    make.leading.equalTo(self).with.inset(SPACE);
    make.top.equalTo(self.askSupplier.mas_bottom);
    make.width.equalTo(self).multipliedBy(0.15);
    make.bottom.equalTo(self);
  }];
  
  [self.leftContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.askSupplierTitle.mas_trailing);
    make.trailing.equalTo(self).with.inset(0.5 * SPACE);
    //    make.centerY.equalTo(self);
    make.top.equalTo(self.askSupplier);
    make.bottom.equalTo(self.askSupplierTitle);
  }];
}

- (UIView *)leftContainer {
  if (!_leftContainer) {
    _leftContainer = [UIView new];
    _leftContainer.qmui_borderColor = UIColor.qd_separatorColor;
    _leftContainer.qmui_borderPosition = QMUIViewBorderPositionLeft;
    addView(_leftContainer, self.price);
    addView(_leftContainer, self.consumeDetail);
    addView(_leftContainer, self.subBtn);
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_leftContainer);
      make.leading.equalTo(_leftContainer).with.inset(0.5 * SPACE);
    }];
    
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_leftContainer).with.inset(0.5 * SPACE);
      make.centerY.equalTo(_leftContainer);
      make.top.bottom.equalTo(_leftContainer);
    }];
    
    [self.consumeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_leftContainer);
      //      make.height.equalTo(_leftContainer);
      make.trailing.equalTo(self.subBtn.mas_leading).with.inset(0.25 * SPACE);
    }];
  }
  return _leftContainer;
}

- (UIImageView *)askSupplier {
  if (!_askSupplier) {
    _askSupplier = [UIImageView new];
    _askSupplier.image = UIImageMake(@"service");
    _askSupplier.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _askSupplier;
}

- (UILabel *)askSupplierTitle {
  if (!_askSupplierTitle) {
    _askSupplierTitle = [UILabel new];
    _askSupplierTitle.text = @"问问店家";
    _askSupplierTitle.font = UIFontMake(13);
    _askSupplierTitle.textAlignment = NSTextAlignmentCenter;
  }
  return _askSupplierTitle;
}

- (UILabel *)price {
  if (!_price) {
    _price = [UILabel new];
    _price.numberOfLines = 0;
    _price.attributedText = [self generatePrice:@{ @"sum" : @"123", @"reduce" : @"0" }];
  }
  return _price;
}

- (UILabel *)consumeDetail {
  if (!_consumeDetail) {
    _consumeDetail = [UILabel new];
    _consumeDetail.userInteractionEnabled = YES;
    _consumeDetail.text = @"每晚明细";
    _consumeDetail.textColor = UIColor.qd_tintColor;
    _consumeDetail.font = UIFontBoldMake(14);
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentDetail)];
    [_consumeDetail addGestureRecognizer:tap];
  }
  return _consumeDetail;
}

- (void)presentDetail {
  if (self.popOrderDetail) { self.popOrderDetail(); }
}

- (QMUIButton *)subBtn {
  if (!_subBtn) {
    _subBtn = [QDUIHelper generateDarkFilledButton];
    _subBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _subBtn.backgroundColor = UIColor.qmui_randomColor;
    [_subBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_subBtn setTitleColor:UIColor.qd_backgroundColor forState:UIControlStateNormal];
  }
  return _subBtn;
}

- (QMUITableView *)tableView {
  if (!_tableView) {
    _tableView =
    [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 4)
                                   style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.whiteColor;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (NSAttributedString *)generatePrice:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(@"需要支付: ").textColor(UIColor.qd_mainTextColor).font(UIFontMake(13));
    make.append(@"¥").textColor(UIColor.orangeColor).font(UIFontBoldMake(13));
    make.append(infoDict[@"sum"]).textColor(UIColor.orangeColor).font(UIFontBoldMake(18));
    make.append(@"\n已减").textColor(UIColor.qd_mainTextColor).font(UIFontMake(13));
    make.append([NSString stringWithFormat:@"¥%@", infoDict[@"reduce"]])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(13));
  }];
  return str;
}

#pragma mark - QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 4;
    case 1:
      return 2;
    default:
      break;
  }
  return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                             withStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:identifier];
  }
  NSInteger section = indexPath.section;
  NSInteger row = indexPath.row;
  NSString *str = @"";
  NSString *money = @"";
  if (section == 0) {
    if (row == 0) { str = @"总金额"; }
    if (row == 1) {
      str = @"03-03 无餐食";
      money = @"1 x ¥328";
    }
    if (row == 2) { str = @"03-04 2份早餐/间"; }
    if (row == 3) {
      str = @"健康守护";
      money = @"- ¥99";
    }
  }
  if (section == 1) {
    if (row == 0) { str = @"离店可获"; }
    if (row == 1) {
      str = @"积分";
      money = @"114分";
    }
  }
  cell.textLabel.text = str;
  cell.detailTextLabel.text = money;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  [cell updateCellAppearanceWithIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
