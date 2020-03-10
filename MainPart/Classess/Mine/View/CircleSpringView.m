//
//  CircleSpringView.m
//  MainPart
//
//  Created by blacksky on 2020/3/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CircleSpringView.h"
#import "MarkUtils.h"
#import <POP.h>

@interface CircleSpringView () <GenerateEntityDelegate> {
  BOOL isScale;
}
@property (nonatomic, strong) UILabel *tagLB;
@end

@implementation CircleSpringView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.height / 2;
    self.layer.borderColor = UIColor.clearColor.CGColor;
    self.backgroundColor = UIColor.qd_tintColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self addSpringAnimate:self];
}

- (void)generateRootView {
  addView(self, self.tagLB);
  [self.tagLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
    make.size.lessThanOrEqualTo(self);
  }];
}

- (UILabel *)tagLB {
  if (!_tagLB) {
    _tagLB = [UILabel new];
    _tagLB.textColor = UIColor.whiteColor;
    _tagLB.text = @"+5";
    _tagLB.textAlignment = NSTextAlignmentCenter;
    _tagLB.font = UIFontBoldMake(15);
  }
  return _tagLB;
}
- (void)addSpringAnimate:(UIView *)view {
  __weak __typeof(self) weakSelf = self;
  POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  spring.duration = 1.5;
  spring.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  if (isScale) {
    spring.fromValue = @(CGPointMake(0.8, 0.8));
    spring.toValue = @(CGPointMake(1, 1));
  } else {
    spring.toValue = @(CGPointMake(0.8, 0.8));
    spring.fromValue = @(CGPointMake(1, 1));
  }
  isScale = !isScale;
  spring.completionBlock =
  ^(POPAnimation *anim, BOOL finished) { [weakSelf addSpringAnimate:weakSelf]; };
  [view.layer pop_addAnimation:spring forKey:@"spring"];
  //  [view.layer pop_addAnimation:springBack forKey:@"springback"];
  //  POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
  //  spring.timingFunction = [CAMediaTimingFunction
  //  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; spring.
}

- (void)addDismissAnimate {
  POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  spring.toValue = @(CGPointMake(0, 0));
  spring.springSpeed = 0.15;
  
  [self.layer pop_addAnimation:spring forKey:@"dimissspring"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.layer pop_removeAllAnimations];
  [self addDismissAnimate];
  [self removeFromSuperview];
}
@end
