//
//  MineFoodCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFoodCell.h"
#import "MarkUtils.h"
const NSInteger FoodImageIndex = 10000;
@interface MineFoodCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *foodImg;
@property (nonatomic, strong) UILabel *foodTitle;
@property (nonatomic, strong) UILabel *foodDescription;
@property (nonatomic, strong) UILabel *foodPrice;
@property (nonatomic, strong) UIImageView *foodAddImg;
@property (nonatomic, strong) UIImageView *foodSubImg;
@property (nonatomic, strong) UILabel *foodNum;

@property (nonatomic, strong) UIView *foodNumContainer;

@property (nonatomic, strong) RACSignal *foodNumSignal;
@end

@implementation MineFoodCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.foodNumSignal = RACObserve(self.foodNum, text);
  if (self.model.foodNum) {
    self.foodSubImg.hidden = self.foodNum.hidden = false;
  } else {
    self.foodSubImg.hidden = self.foodNum.hidden = YES;
  }
}

- (void)prepareForReuse {
  self.foodNumSignal = nil;
  self.model = nil;
  self.foodSubImg.hidden = self.foodNum.hidden = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  
  addView(superview, self.foodImg);
  addView(superview, self.foodTitle);
  addView(superview, self.foodDescription);
  addView(superview, self.foodNum);
  addView(superview, self.foodPrice);
  addView(superview, self.foodNumContainer);
  
  [self.foodImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(superview);
    make.left.equalTo(superview).with.inset(5);
    make.width.equalTo(self.foodImg.mas_height);
  }];
  
  [self.foodTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview);
    make.left.equalTo(self.foodImg.mas_right).with.inset(5);
  }];
  
  [self.foodDescription mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.foodTitle.mas_bottom).with.inset(5);
    make.left.equalTo(self.foodTitle);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.foodPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.foodTitle);
    make.bottom.equalTo(superview);
  }];
  
  [self.foodNumContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
    make.bottom.equalTo(superview);
  }];
}

- (UIView *)foodNumContainer {
  if (!_foodNumContainer) {
    _foodNumContainer = [UIView new];
    addView(_foodNumContainer, self.foodSubImg);
    addView(_foodNumContainer, self.foodNum);
    addView(_foodNumContainer, self.foodAddImg);
    
    [self.foodSubImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_foodNumContainer);
    }];
    
    [self.foodNum mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(_foodNumContainer);
      make.left.equalTo(self.foodSubImg.mas_right);
      make.width.equalTo(self.foodAddImg).multipliedBy(2);
    }];
    
    [self.foodAddImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.right.equalTo(_foodNumContainer);
      make.left.equalTo(self.foodNum.mas_right);
    }];
  }
  return _foodNumContainer;
}

- (UIImageView *)foodImg {
  if (!_foodImg) {
    _foodImg = [UIImageView new];
    _foodImg.image = UIImageMake(@"pink_gradient");
    _foodImg.contentMode = QMUIImageResizingModeScaleAspectFill;
    _foodImg.layer.cornerRadius = 5;
    _foodImg.layer.masksToBounds = YES;
  }
  return _foodImg;
}

- (UILabel *)foodTitle {
  if (!_foodTitle) {
    _foodTitle = [UILabel new];
    _foodTitle.text = @"温水煮青蛙";
    _foodTitle.font = UIFontMake(18);
    _foodTitle.textColor = UIColor.blackColor;
  }
  return _foodTitle;
}

- (UILabel *)foodDescription {
  if (!_foodDescription) {
    _foodDescription = [UILabel new];
    _foodDescription.text = @"温水，没了，真的没了 原料：123123123";
    _foodDescription.lineBreakMode = NSLineBreakByTruncatingTail;
    _foodDescription.textColor = UIColor.qd_placeholderColor;
    _foodDescription.font = UIFontMake(16);
  }
  return _foodDescription;
}

- (UILabel *)foodPrice {
  if (!_foodPrice) {
    _foodPrice = [UILabel new];
    _foodPrice.textColor = UIColor.orangeColor;
    _foodPrice.text = @"¥29.9";
    _foodPrice.font = UIFontMake(18);
  }
  return _foodPrice;
}

- (UIImageView *)foodAddImg {
  if (!_foodAddImg) {
    _foodAddImg = [UIImageView new];
    _foodAddImg.image = UIImageMake(@"increase_eleme");
    _foodAddImg.tag = FoodImageIndex + 1;
    _foodAddImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foodClick:)];
    [_foodAddImg addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 0.5;
    [_foodAddImg addGestureRecognizer:longPress];
    
    [tap requireGestureRecognizerToFail:longPress];
  }
  return _foodAddImg;
}

- (UIImageView *)foodSubImg {
  if (!_foodSubImg) {
    _foodSubImg = [UIImageView new];
    _foodSubImg.image = UIImageMake(@"decrease_eleme");
    _foodSubImg.hidden = YES;
    _foodSubImg.tag = FoodImageIndex;
    _foodSubImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foodClick:)];
    [_foodSubImg addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 0.5;
    [_foodSubImg addGestureRecognizer:longPress];
    
    [tap requireGestureRecognizerToFail:longPress];
  }
  return _foodSubImg;
}

- (UILabel *)foodNum {
  if (!_foodNum) {
    _foodNum = [UILabel new];
    _foodNum.text = @"0";
    _foodNum.textColor = UIColorBlack;
    _foodNum.font = UIFontMake(18);
    _foodNum.textAlignment = NSTextAlignmentCenter;
    _foodNum.hidden = YES;
  }
  return _foodNum;
}

- (void)foodClick:(UITapGestureRecognizer *)tap {
  UIView *view = tap.qmui_targetView;
  if (view.tag == FoodImageIndex) {
    self.foodNum.text =
    [NSString stringWithFormat:@"%li", self.model.foodNum - 1 < 0 ? 0 : (--self.model.foodNum)];
    __weak __typeof(self) weakSelf = self;
    [self.foodNumSignal subscribeNext:^(NSString *x) {
      if ([x isEqualToString:@"0"]) {
        weakSelf.foodNum.hidden = YES;
        weakSelf.foodSubImg.hidden = YES;
        weakSelf.foodSubImg.userInteractionEnabled = false;
      }
    }];
  } else if (view.tag == FoodImageIndex + 1) {
    self.foodNum.text = [NSString stringWithFormat:@"%li", (++self.model.foodNum)];
    __weak __typeof(self) weakSelf = self;
    [self.foodNumSignal subscribeNext:^(NSString *x) {
      weakSelf.foodNum.hidden = false;
      weakSelf.foodSubImg.hidden = false;
      weakSelf.foodSubImg.userInteractionEnabled = YES;
    }];
  }
  if (self.clickBlock) { self.clickBlock(self.model); }
}

- (void)handleLongPress:(UIGestureRecognizer *)recognizer {
  UIView *view = recognizer.qmui_targetView;
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    [view becomeFirstResponder];
  } else {
    [view resignFirstResponder];
  }
  if (view.tag == FoodImageIndex) {
    self.foodNum.text =
    [NSString stringWithFormat:@"%li", self.model.foodNum - 1 < 0 ? 0 : (--self.model.foodNum)];
    __weak __typeof(self) weakSelf = self;
    [self.foodNumSignal subscribeNext:^(NSString *x) {
      if ([x isEqualToString:@"0"]) {
        weakSelf.foodNum.hidden = YES;
        weakSelf.foodSubImg.hidden = YES;
        weakSelf.foodSubImg.userInteractionEnabled = false;
      }
    }];
  } else if (view.tag == FoodImageIndex + 1) {
    self.foodNum.text = [NSString stringWithFormat:@"%li", (++self.model.foodNum)];
    __weak __typeof(self) weakSelf = self;
    [self.foodNumSignal subscribeNext:^(NSString *x) {
      weakSelf.foodNum.hidden = false;
      weakSelf.foodSubImg.hidden = false;
      weakSelf.foodSubImg.userInteractionEnabled = YES;
    }];
  }
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
// shouldRecognizeSimultaneouslyWithGestureRecognizer:
//(UIGestureRecognizer *)otherGestureRecognizer {
//  return YES;
//}

- (void)setModel:(Food *)model {
  _model = model;
  self.foodTitle.text = model.foodName;
  self.foodNum.text = [NSString stringWithFormat:@"%li", model.foodNum];
  self.foodDescription.text = model.foodDescription;
  self.foodPrice.text = [NSString stringWithFormat:@"¥%@", model.foodPrice];
}

- (void)loadData:(Food *)model {
  self.model = model;
  self.foodTitle.text = model.foodName;
  self.foodNum.text = [NSString stringWithFormat:@"%li", model.foodNum];
  self.foodDescription.text = model.foodDescription;
  self.foodPrice.text = [NSString stringWithFormat:@"¥%@", model.foodPrice];
}
@end
