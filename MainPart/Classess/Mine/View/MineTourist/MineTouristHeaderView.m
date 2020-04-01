//
//  MineTouristHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineTouristHeaderView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineTouristHeaderView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *avatorImage;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *abstract;
@property (nonatomic, strong) UIView *tourPathContainer;
@property (nonatomic, strong) UIView *container;
@end

@implementation MineTouristHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    //    self.clipsToBounds = YES;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  UIBezierPath *path =
  [UIBezierPath bezierPathWithRoundedRect:self.container.bounds
                        byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                              cornerRadii:CGSizeMake(10, 10)];
  CAShapeLayer *mask = [[CAShapeLayer alloc] init];
  mask.path = path.CGPath;
  mask.fillColor = UIColor.qd_backgroundColor.CGColor;
  [self.container.layer addSublayer:mask];
}

- (void)generateRootView {
  addView(self, self.bgImage);
  addView(self, self.container);
  addView(self, self.avatorImage);
  addView(self, self.nickName);
  addView(self, self.abstract);
  addView(self, self.tourPathContainer);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.bgImage.mas_bottom).offset(-10);
    make.left.right.equalTo(self);
    make.bottom.equalTo(self);
  }];
  
  [self.avatorImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(2 * SPACE);
    make.centerY.equalTo(self.container.mas_top);
  }];
  
  [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatorImage);
    make.right.equalTo(self).with.inset(SPACE);
    make.top.equalTo(self.avatorImage.mas_bottom).with.inset(SPACE);
  }];
  
  [self.abstract mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.nickName);
    make.top.equalTo(self.nickName.mas_bottom).with.inset(0.5 * SPACE);
    make.right.equalTo(self).with.inset(SPACE);
  }];
  
  [self.tourPathContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self).with.inset(SPACE);
    make.bottom.equalTo(self).with.inset(5);
    make.height.mas_equalTo(DEVICE_HEIGHT / 8);
  }];
}

- (UIImageView *)bgImage {
  if (!_bgImage) {
    _bgImage = [UIImageView new];
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/"
                                  @"70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/"
                                  @"u=3141609041,395643134&fm=15&gp=0.jpg"]
                placeholderImage:UIImageMake(@"launch_background")];
    _bgImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _bgImage.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 7);
    _bgImage.clipsToBounds = YES;
  }
  return _bgImage;
}

- (UIImageView *)avatorImage {
  if (!_avatorImage) {
    _avatorImage = [UIImageView new];
    _avatorImage.image = UIImageMake(@"power");
  }
  return _avatorImage;
}

- (UILabel *)nickName {
  if (!_nickName) {
    _nickName = [UILabel new];
    _nickName.userInteractionEnabled = YES;
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append(@"shadowburn").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(22));
      make.appendImage(
                       ^(id<SJUTImageAttachment> _Nonnull make) { make.image = UIImageMake(@"edit"); })
      .baseLineOffset(-5);
    }];
    _nickName.attributedText = str;
  }
  return _nickName;
}

- (UILabel *)abstract {
  if (!_abstract) {
    _abstract = [UILabel new];
    _abstract.userInteractionEnabled = YES;
    NSAttributedString *str = [NSAttributedString sj_UIKitText:^(
                                                                 id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append(@"i'm coming back!").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(15));
      make.appendImage(
                       ^(id<SJUTImageAttachment> _Nonnull make) { make.image = UIImageMake(@"edit"); })
      .baseLineOffset(-5);
    }];
    _abstract.attributedText = str;
  }
  return _abstract;
}

- (UIView *)tourPathContainer {
  if (!_tourPathContainer) {
    _tourPathContainer = [UIView new];
    _tourPathContainer.backgroundColor = UIColor.clearColor;
    UIImageView *image = [UIImageView new];
    image.contentMode = QMUIImageResizingModeScaleAspectFill;
    [image sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/"
                               @"70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/"
                               @"u=3141609041,395643134&fm=15&gp=0.jpg"]
             placeholderImage:UIImageMake(@"launch_background")];
    addView(_tourPathContainer, image);
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(_tourPathContainer);
    }];
    
    _tourPathContainer.layer.cornerRadius = 10;
    _tourPathContainer.layer.masksToBounds = YES;
  }
  return _tourPathContainer;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    //    _container.backgroundColor = UIColor.qmui_randomColor;
  }
  return _container;
}

- (void)scrollViewDidScroll:(CGPoint)offset {
  if (offset.y < 0) {
    self.bgImage.frame =
    CGRectMake(offset.y, offset.y, DEVICE_WIDTH - 2 * offset.y, DEVICE_HEIGHT / 7 - offset.y);
  } else {
    self.bgImage.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT / 7);
  }
}

@end
