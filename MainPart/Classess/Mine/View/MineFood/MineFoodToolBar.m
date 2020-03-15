
//
//  MineFoodToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodToolBar.h"
#import "MarkUtils.h"
#import "MineFoodPayController.h"
#import "PopListController.h"

@interface MineFoodToolBar () <GenerateEntityDelegate, PopListDelegate> {
  NSInteger _tot;
  CGFloat _totPrice;
}
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *blackContainer;
@property (nonatomic, strong) UIImageView *foodShopImg;
@property (nonatomic, strong) QMUILabel *foodNumTag;
@property (nonatomic, strong) UILabel *foodTotPrice;
@property (nonatomic, strong) QMUIButton *foodBuyBtn;
@property (nonatomic, strong) PopListController *popListController;
@property (nonatomic, strong) NSMutableArray *buyFoodList;
@property (nonatomic, strong) UIView *topViewContainer;
@end

@implementation MineFoodToolBar

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.foodNumTag setNeedsLayout];
  [self.foodNumTag layoutIfNeeded];
  self.foodNumTag.layer.cornerRadius = self.foodNumTag.layer.frame.size.height / 2;
}

- (void)generateRootView {
  addView(self, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
}
#pragma mark - Lazy Init
- (UIView *)topViewContainer {
  if (!_topViewContainer) {
    _topViewContainer = [UIView new];
    _topViewContainer.backgroundColor = UIColor.systemYellowColor;
  }
  return _topViewContainer;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.topViewContainer);
    addView(_container, self.blackContainer);
    addView(_container, self.foodShopImg);
    addView(_container, self.foodTotPrice);
    addView(_container, self.foodNumTag);
    addView(_container, self.foodBuyBtn);
    
    [self.topViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(_container);
      make.bottom.equalTo(self.blackContainer.mas_top);
    }];
    
    [self.foodShopImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(_container).with.inset(SafeAreaInsetsConstantForDeviceWithNotch.bottom);
      make.left.equalTo(_container).with.inset(SPACE);
      make.top.equalTo(_container);
    }];
    
    [self.foodNumTag mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.foodShopImg.mas_right);
      make.top.equalTo(self.foodShopImg);
      make.width.equalTo(self.foodNumTag.mas_height);
    }];
    
    [self.foodTotPrice mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.foodShopImg.mas_centerY).with.inset(5);
      make.left.equalTo(self.foodShopImg.mas_right).with.inset(5);
    }];
    
    [self.blackContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.equalTo(_container);
      make.top.equalTo(self.foodShopImg.mas_centerY).with.inset(-10);
      //      make.top.equalTo(_container).with.inset(-10);
    }];
    
    [self.foodBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.right.equalTo(self.blackContainer).with.inset(3);
      make.bottom.equalTo(_container).with.inset(SafeAreaInsetsConstantForDeviceWithNotch.bottom);
      make.width.equalTo(_container).multipliedBy(0.25);
    }];
  }
  return _container;
}

- (UIView *)blackContainer {
  if (!_blackContainer) {
    _blackContainer = [UIView new];
    _blackContainer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    addView(_blackContainer, visualView);
    
    [visualView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_blackContainer); }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBuyList)];
    [_blackContainer addGestureRecognizer:tap];
  }
  return _blackContainer;
}

- (UIImageView *)foodShopImg {
  if (!_foodShopImg) {
    _foodShopImg = [UIImageView new];
    _foodShopImg.image = UIImageMake(@"food_shop");
  }
  return _foodShopImg;
}

- (QMUILabel *)foodNumTag {
  if (!_foodNumTag) {
    _foodNumTag = [QMUILabel new];
    _foodNumTag.highlightedBackgroundColor = nil;
    _foodNumTag.highlightedTextColor = nil;
    _foodNumTag.text = @"1";
    _foodNumTag.textAlignment = NSTextAlignmentCenter;
    _foodNumTag.backgroundColor = UIColor.orangeColor;
    _foodNumTag.layer.masksToBounds = YES;
    _foodNumTag.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    _foodNumTag.textColor = UIColor.qd_backgroundColor;
    _foodNumTag.font = UIFontMake(12);
    _foodNumTag.hidden = YES;
  }
  return _foodNumTag;
}

- (UILabel *)foodTotPrice {
  if (!_foodTotPrice) {
    _foodTotPrice = [UILabel new];
    _foodTotPrice.text = @"¥54";
    _foodTotPrice.textColor = UIColor.qd_backgroundColor;
    _foodTotPrice.font = UIFontMake(18);
  }
  return _foodTotPrice;
}

- (QMUIButton *)foodBuyBtn {
  if (!_foodBuyBtn) {
    _foodBuyBtn = [QDUIHelper generateDarkFilledButton];
    [_foodBuyBtn setTitleColor:UIColor.qd_backgroundColor forState:UIControlStateNormal];
    [_foodBuyBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [_foodBuyBtn setBackgroundColor:UIColor.systemGreenColor];
    [_foodBuyBtn addTarget:self
                    action:@selector(foodBuyClick)
          forControlEvents:UIControlEventTouchUpInside];
    _foodBuyBtn.titleLabel.font = UIFontMake(17);
    [_foodBuyBtn
     setHighlightedBackgroundColor:[UIColor.systemGreenColor qmui_transitionToColor:UIColorBlack
                                                                           progress:.15]];
  }
  return _foodBuyBtn;
}

#pragma mark - Click Listener
- (void)foodBuyClick {
  QMUILogInfo(@"mine food tool bar", @"food buy click");
  if (!self.buyFoodList.count) return;
  MineFoodPayController *mfpCon = [MineFoodPayController new];
  mfpCon.foodList = self.buyFoodList;
  mfpCon.foodTotPrice = _totPrice;
  mfpCon.model = self.model;
  mfpCon.foodPayType = (self.addressEnable ? OrderPayType : QRCodePayType);
  mfpCon.title = [NSString stringWithFormat:@"%@-订餐", self.model.hotelName];
  [[self qmui_viewController].navigationController pushViewController:mfpCon animated:YES];
}

- (void)showBuyList {
  QMUILogInfo(@"mine food tool bar", @"show food list");
  if (!_tot) return;
  if (!self.popListController) {
    self.popListController = [PopListController new];
    self.popListController.delegate = self;
    CGFloat height =
    self.foodShopImg.frame.size.height + SafeAreaInsetsConstantForDeviceWithNotch.bottom;
    self.popListController.bottomView.frame =
    CGRectMake(0, DEVICE_HEIGHT - height, DEVICE_WIDTH, height);
    [self.popListController.bottomView setNeedsLayout];
    [self.popListController.bottomView layoutIfNeeded];
  }
  //  self.buyFoodList = [NSMutableArray new];
  //  for (Food *food in self.modelList) {
  //    if (food.foodNum) { [self.buyFoodList addObject:food]; }
  //  }
  self.popListController.foodList = self.buyFoodList;
  [self.popListController showPopListView];
}

- (void)setModelList:(NSMutableArray<Food *> *)modelList {
  _modelList = modelList;
  self.buyFoodList = [NSMutableArray new];
  _totPrice = 0;
  _tot = 0;
  for (Food *food in modelList) {
    if (food.foodNum) {
      [self.buyFoodList addObject:food];
      _totPrice += [food.foodPrice doubleValue] * food.foodNum;
      _tot += food.foodNum;
    }
  }
  self.foodTotPrice.text = [NSString stringWithFormat:@"¥%g", _totPrice];
  if (_tot != 0) {
    self.foodNumTag.hidden = false;
  } else {
    self.foodNumTag.hidden = YES;
  }
  self.foodNumTag.text = [NSString stringWithFormat:@"%li", _tot];
}

#pragma mark - PopListDelegate
- (void)foodNumberValueChanged:(NSInteger)currentNumber {
  if (self.foodNumChangeBlock) {
    self.foodNumChangeBlock();
    if (!currentNumber) {
      self.buyFoodList = [NSMutableArray new];
      for (Food *food in self.modelList) {
        if (food.foodNum) { [self.buyFoodList addObject:food]; }
      }
      self.popListController.foodList = self.buyFoodList;
    }
  }
}
@end
