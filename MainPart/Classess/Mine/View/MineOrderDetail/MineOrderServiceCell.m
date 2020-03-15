//
//  MineOrderServiceCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOrderServiceCell.h"
#import "MarkUtils.h"
#import "MineFoodOrderController.h"
#import "MineSportController.h"

@interface MineOrderServiceCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *foodImg;
@property (nonatomic, strong) UIImageView *sportImg;
@property (nonatomic, strong) UILabel *foodTitle;
@property (nonatomic, strong) UILabel *sportTitle;
@property (nonatomic, strong) UILabel *serviceTitle;

@property (nonatomic, strong) UIView *foodContainer;
@property (nonatomic, strong) UIView *sportContainer;
@end

@implementation MineOrderServiceCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.foodContainer);
  addView(superview, self.sportContainer);
  
  [self.foodContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.left.equalTo(superview);
    make.width.equalTo(superview).multipliedBy(0.5);
  }];
  
  [self.sportContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.right.equalTo(superview);
    make.width.equalTo(superview).multipliedBy(0.5);
  }];
}

#pragma mark - food container view init & food contianer click lisener
- (UIView *)foodContainer {
  if (!_foodContainer) {
    _foodContainer = [UIView new];
    _foodContainer.backgroundColor = UIColor.clearColor;
    _foodContainer.clipsToBounds = YES;
    
    addView(_foodContainer, self.foodImg);
    addView(_foodContainer, self.foodTitle);
    
    [self.foodImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.centerX.equalTo(_foodContainer);
    }];
    
    [self.foodTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.foodImg.mas_bottom).with.inset(5);
      ;
      make.centerX.bottom.equalTo(_foodContainer);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foodClick)];
    [_foodContainer addGestureRecognizer:tap];
  }
  return _foodContainer;
}

- (UIImageView *)foodImg {
  if (!_foodImg) {
    _foodImg = [UIImageView new];
    _foodImg.image = UIImageMake(@"hotel_food");
  }
  return _foodImg;
}

- (UILabel *)foodTitle {
  if (!_foodTitle) {
    _foodTitle = [UILabel new];
    _foodTitle.text = @"订餐";
    _foodTitle.textColor = UIColorBlack;
    _foodTitle.font = UIFontLightMake(15);
  }
  return _foodTitle;
}

- (void)foodClick {
  QMUILogInfo(@"mine order service cell", @"food click");
  if (self.parentController) {
    MineFoodOrderController *mfoCon = [MineFoodOrderController new];
    mfoCon.foodOrderType = RoomOrderType;
    mfoCon.orderCheckInfo = self.model;
    [self.parentController.navigationController pushViewController:mfoCon animated:YES];
  }
}

#pragma mark - sport container view init & sport contianer click lisener
- (UIView *)sportContainer {
  if (!_sportContainer) {
    
    _sportContainer = [UIView new];
    _sportContainer.backgroundColor = UIColor.clearColor;
    _sportContainer.clipsToBounds = YES;
    
    _sportContainer.qmui_borderColor = UIColor.qd_separatorColor;
    _sportContainer.qmui_borderPosition = QMUIViewBorderPositionLeft;
    _sportContainer.qmui_borderWidth = 1;
    
    addView(_sportContainer, self.sportImg);
    addView(_sportContainer, self.sportTitle);
    
    [self.sportImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.top.equalTo(_sportContainer);
    }];
    
    [self.sportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.sportImg.mas_bottom).with.inset(5);
      make.centerX.bottom.equalTo(_sportContainer);
    }];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sportClick)];
    [_sportContainer addGestureRecognizer:tap];
  }
  return _sportContainer;
}

- (UIImageView *)sportImg {
  if (!_sportImg) {
    _sportImg = [UIImageView new];
    _sportImg.image = UIImageMake(@"hotel_sport");
  }
  return _sportImg;
}

- (UILabel *)sportTitle {
  if (!_sportTitle) {
    _sportTitle = [UILabel new];
    _sportTitle.text = @"健身";
    _sportTitle.textColor = UIColorBlack;
    _sportTitle.font = UIFontLightMake(15);
  }
  return _sportTitle;
}

- (void)sportClick {
  QMUILogInfo(@"mine order service cell", @"sport click");
  if (self.parentController) {
    //    [self.parentController.navigationController pushViewController:[MineFoodOrderController
    //    new]
    //                                                          animated:YES];
    MineSportController *msCon = [MineSportController new];
    [self.parentController.navigationController pushViewController:msCon animated:YES];
  }
}
@end
