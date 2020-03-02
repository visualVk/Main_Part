//
//  DetailPresentNavBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailPresentNavBar.h"
#import "MarkUtils.h"

@interface DetailPresentNavBar () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *closeImage;
@property (nonatomic, strong) QMUIModalPresentationViewController *parentController;
@end

@implementation DetailPresentNavBar

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setAlpha:0];
    self.backgroundColor = UIColor.qd_backgroundColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.title);
  addView(self, self.closeImage);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(self); }];
  
  [self.closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self);
    make.trailing.equalTo(self).with.inset(SPACE);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"默认信息";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(18);
  }
  return _title;
}

- (UIImageView *)closeImage {
  if (!_closeImage) {
    _closeImage = [UIImageView new];
    _closeImage.image = UIImageMake(@"close");
    _closeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPresentCon)];
    [_closeImage addGestureRecognizer:tap];
  }
  return _closeImage;
}

- (void)dismissPresentCon {
  if (!self.parentController) { self.parentController = [self qmui_viewController]; }
  [self.parentController hideWithAnimated:YES completion:nil];
}

- (void)didScrollView:(CGPoint)offset {
  [self setAlpha:offset.y / NavigationContentTop];
  if (offset.y == NavigationContentTop) {
    [UIView transitionWithView:self.closeImage
                      duration:0.5
                       options:UIViewAnimationOptionBeginFromCurrentState
                    animations:^{ self.closeImage.tintColor = UIColor.qd_mainTextColor; }
                    completion:nil];
  }
}
@end
