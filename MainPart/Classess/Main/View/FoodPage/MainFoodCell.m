//
//  MainFoodCell.m
//  MainPart
//
//  Created by blacksky on 2020/4/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainFoodCell.h"
#import "MarkUtils.h"

@interface MainFoodCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *foodImg;
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UIVisualEffectView *backEffectView;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) QMUIButton *gainBtn;
@end

@implementation MainFoodCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
  self.userImg.layer.masksToBounds = true;
  self.foodImg.layer.cornerRadius = 5;
  self.foodImg.layer.masksToBounds = true;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.bgImg);
    addView(_container, self.backEffectView);
    addView(_container, self.foodImg);
    addView(_container, self.userImg);
    addView(_container, self.gainBtn);
    
    [self.bgImg
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
    
    [self.backEffectView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.bgImg); }];
    
    [self.foodImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.bottom.equalTo(_container).with.inset(5);
      make.right.equalTo(self.userImg.mas_left).with.inset(10);
    }];
    
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(90, 90));
      make.top.equalTo(self.foodImg);
      make.right.equalTo(_container).with.inset(20);
    }];
    
    [self.gainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.mas_equalTo(90);
      make.bottom.equalTo(self.foodImg);
      make.right.equalTo(self.userImg);
    }];
    
    [self.foodImg setNeedsLayout];
    [self.foodImg layoutIfNeeded];
    [self.userImg setNeedsLayout];
    [self.userImg layoutIfNeeded];
  }
  return _container;
}

- (UIImageView *)foodImg {
  if (!_foodImg) { _foodImg = [self generateImg]; }
  return _foodImg;
}

- (UIImageView *)userImg {
  if (!_userImg) {
    _userImg = [self generateImg];
#ifdef Test_Hotel
    [self randomUserImg];
#endif
  }
  return _userImg;
}

- (UIVisualEffectView *)backEffectView {
  if (!_backEffectView) {
    _backEffectView = [[UIVisualEffectView alloc]
                       initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
  }
  return _backEffectView;
}

- (UIImageView *)bgImg {
  if (!_bgImg) {
    _bgImg = [self generateImg];
    [_bgImg sd_setImageWithURL:[NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/"
                                @"u=1604788653,2230088750&fm=26&gp=0.jpg"]
              placeholderImage:UIImageMake(@"lanuch_background")];
  }
  return _bgImg;
}

- (QMUIButton *)gainBtn {
  if (!_gainBtn) {
    _gainBtn = [QDUIHelper generateDarkFilledButton];
    _gainBtn.titleLabel.font = UIFontMake(20);
    [_gainBtn setTitle:@"立即领取" forState:UIControlStateNormal];
  }
  return _gainBtn;
}

- (UIImageView *)generateImg {
  UIImageView *img = [UIImageView new];
  img.contentMode = QMUIImageResizingModeScaleAspectFill;
  return img;
}

- (void)setModel:(NSDictionary *)dict {
  [self.foodImg sd_setImageWithURL:dict[@"food"] placeholderImage:UIImageMake(@"pink_gradient")];
  self.gainBtn.titleLabel.text = dict[@"title"];
  [self.gainBtn setTitle:dict[@"title"] forState:UIControlStateNormal];
  //  self.userImg sd_setImageWithURL:dict[@""] placeholderImage:<#(nullable UIImage *)#>
}

- (void)randomUserImg {
  NSArray *imgList = @[
    @"http://img0.imgtn.bdimg.com/it/u=3521319392,1160740190&fm=26&gp=0.jpg",
    @"http://img2.imgtn.bdimg.com/it/u=3744215463,383557679&fm=26&gp=0.jpg",
    @"http://img5.imgtn.bdimg.com/it/u=1037378912,2840208243&fm=26&gp=0.jpg"
  ];
  [self.userImg sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % 3]]
                  placeholderImage:UIImageMake(@"pink_gradient")];
}
@end
