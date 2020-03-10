//
//  AwardView.m
//  AwardView
//
//  Created by blacksky on 2020/3/8.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AwardView.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <POP.h>
#import <QMUIKit.h>

@interface AwardView ()
@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, strong) UIView *awardContainer;
@property (nonatomic, strong) UILabel *congratulation;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *awardImage;
@property (nonatomic, strong) UILabel *awardLabel;
@property (nonatomic, strong) UILabel *awardDetail;
@property (nonatomic, strong) QMUILabel *useBtn;
@property (nonatomic, strong) UIImageView *closeImage;
@end

@implementation AwardView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    //    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
    self.frame = UIScreen.mainScreen.bounds;
    [self bgImage];
    [self awardImage];
    [self closeImage];
  }
  
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)showView {
  [self showViewAnimate];
  AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
  [delegate.window addSubview:self];
}

- (void)hideView {
  [self.emitter removeFromSuperlayer];
  [self removeFromSuperview];
}

#pragma mark - Lazy init
- (UIView *)awardContainer {
  if (!_awardContainer) { _awardContainer = [UIView new]; }
  return _awardContainer;
}

- (QMUILabel *)useBtn {
  if (!_useBtn) {
    _useBtn = [QMUILabel new];
    _useBtn.highlightedBackgroundColor = nil;
    _useBtn.highlightedTextColor = nil;
    _useBtn.backgroundColor = UIColor.systemYellowColor;
    _useBtn.textColor = UIColor.redColor;
    _useBtn.text = @"立即使用";
    _useBtn.font = UIFontMake(20);
    _useBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _useBtn.layer.cornerRadius = 5;
    _useBtn.layer.masksToBounds = YES;
    _useBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useClick)];
    [_useBtn addGestureRecognizer:tap];
    
    [self.awardImage addSubview:_useBtn];
    
    [_useBtn
     mas_makeConstraints:^(MASConstraintMaker *make) { make.centerX.equalTo(self.awardImage); }];
  }
  return _useBtn;
}

- (UIImageView *)closeImage {
  if (!_closeImage) {
    _closeImage = [UIImageView new];
    _closeImage.image = UIImageMake(@"close");
    [self addSubview:_closeImage];
    [_closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.awardImage.mas_top).with.inset(5);
      make.left.equalTo(self.awardImage.mas_right).with.inset(5);
    }];
    
    _closeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeClick)];
    [_closeImage addGestureRecognizer:tap];
  }
  return _closeImage;
}

- (UIImageView *)bgImage {
  if (!_bgImage) {
    _bgImage = [UIImageView new];
    _bgImage.image = UIImageMake(@"congratulation");
    _bgImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _bgImage.backgroundColor = UIColor.clearColor;
    [self addSubview:_bgImage];
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
  }
  return _bgImage;
}

- (UIImageView *)awardImage {
  if (!_awardImage) {
    _awardImage = [UIImageView new];
    _awardImage.image = UIImageMake(@"award");
    _awardImage.userInteractionEnabled = YES;
    [self addSubview:_awardImage];
    [_awardImage addSubview:self.awardDetail];
    [_awardImage addSubview:self.awardLabel];
    [_awardImage addSubview:self.useBtn];
    [_awardImage mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(self); }];
    
    [self.awardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_awardImage);
      make.top.equalTo(_awardImage).with.inset(20);
    }];
    
    [self.awardDetail mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_awardImage);
      make.top.equalTo(self.awardLabel.mas_bottom).with.inset(5);
    }];
    
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(_awardImage).with.inset(10);
    }];
  }
  return _awardImage;
}

- (UILabel *)awardLabel {
  if (!_awardLabel) {
    _awardLabel = [UILabel new];
    _awardLabel.text = @"¥30";
    _awardLabel.font = UIFontBoldMake(40);
    _awardLabel.textColor = UIColor.redColor;
  }
  return _awardLabel;
}

- (UILabel *)awardDetail {
  if (!_awardDetail) {
    _awardDetail = [UILabel new];
    _awardDetail.numberOfLines = 0;
    _awardDetail.preferredMaxLayoutWidth = DEVICE_WIDTH / 3 - 10;
    _awardDetail.text = @"满300元可以用(限单身狗使用)";
    _awardDetail.textColor = UIColor.blackColor;
    _awardDetail.font = UIFontLightMake(25);
  }
  return _awardDetail;
}

#pragma mark - private method
- (void)showViewAnimate {
  __weak __typeof(self) weakSelf = self;
  AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
  
  POPSpringAnimation *positionY =
  [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
  positionY.springBounciness = 6;
  positionY.springSpeed = 10;
  positionY.fromValue = @-200;
  positionY.toValue = @(delegate.window.center.y);
  positionY.animationDidStartBlock = ^(POPAnimation *anim) { [weakSelf setMultipleEmitterCell]; };
  
  POPBasicAnimation *opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  opacity.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  opacity.duration = 0.25;
  opacity.toValue = @1.0;
  
  POPBasicAnimation *rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
  rotation.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  rotation.beginTime = CACurrentMediaTime() + 0.1;
  rotation.duration = 0.3;
  rotation.fromValue = @(M_PI / 7);
  rotation.toValue = @(0);
  
  rotation.completionBlock =
  ^(POPAnimation *anim, BOOL finished) { [weakSelf.awardImage.layer removeAllAnimations]; };
  
  [self.awardImage.layer pop_addAnimation:positionY forKey:@"positionY"];
  [self.awardImage.layer pop_addAnimation:opacity forKey:@"opacity"];
  [self.awardImage.layer pop_addAnimation:rotation forKey:@"rotation"];
}

- (void)hideViewAnimate {
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//  AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
//  UITouch *touch = [touches anyObject];
//  CGPoint point = [touch locationInView:self];
//  if (CGRectContainsPoint(self.bounds, point)) { [self hideView]; }
//}

- (void)setMultipleEmitterCell {
  AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
  [delegate.window.layer addSublayer:self.emitter];
}

- (CAEmitterLayer *)emitter {
  if (!_emitter) {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    
    _emitter = [CAEmitterLayer layer];
    _emitter.emitterSize = delegate.window.bounds.size;
    _emitter.emitterPosition = CGPointMake(delegate.window.bounds.size.width / 2, DEVICE_HEIGHT);
    _emitter.emitterMode = kCAEmitterLayerSurface;
    _emitter.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell *point = nil;
    
    NSMutableArray<CAEmitterCell *> *arr = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; i++) {
      point = [CAEmitterCell emitterCell];
      point.name = [NSString stringWithFormat:@"cell%d", i];
      
      if (i == 0) {
        point.contents = (id)[UIImageMake(@"blue_rect") CGImage];
      } else if (i == 1) {
        point.contents = (id)[UIImageMake(@"yellow_rect") CGImage];
      } else {
        point.contents = (id)[UIImageMake(@"pink_rect") CGImage];
      }
      point.birthRate = 3.0;
      point.lifetime = 4;
      point.velocity = -50.0;
      point.velocityRange = -100;
      point.yAcceleration = -100;
      point.emissionRange = 0.5 * M_PI;
      point.spinRange = 0.25 * M_PI;
      point.scaleRange = 0.5f;
      point.scale = 1.0f;
      
      [arr addObject:point];
    }
    _emitter.emitterCells = arr;
  }
  return _emitter;
}

- (void)useClick {
  QMUILogInfo(@"award view", @"clcik");
}

- (void)closeClick {
  QMUILogInfo(@"award view", @"close click");
  [self hideView];
  if (self.closeClickBlock) self.closeClickBlock();
}
@end
