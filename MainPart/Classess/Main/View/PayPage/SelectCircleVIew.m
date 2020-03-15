//
//  SelectCircleVIew.m
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SelectCircleVIew.h"
#import "MarkUtils.h"

@interface SelectCircleVIew () <GenerateEntityDelegate>

@end

@implementation SelectCircleVIew

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.outer.layer.cornerRadius = self.outer.frame.size.height / 2;
  self.inner.layer.cornerRadius = (self.outer.frame.size.height - 6) / 2;
}

- (void)generateRootView {
  addView(self, self.outer);
  addView(self.outer, self.inner);
  
  [self.outer
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self).with.inset(1); }];
  
  [self.inner mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.outer).with.inset(3);
  }];
}

- (UIView *)outer {
  if (!_outer) {
    _outer = [UIView new];
    _outer.backgroundColor = UIColor.clearColor;
    _outer.layer.borderColor = UIColor.grayColor.CGColor;
    _outer.layer.borderWidth = 2;
  }
  return _outer;
}

- (UIView *)inner {
  if (!_inner) {
    _inner = [UIView new];
    _inner.backgroundColor = UIColor.qd_tintColor;
    _inner.layer.borderColor = UIColor.clearColor.CGColor;
    _inner.hidden = YES;
  }
  return _inner;
}

- (void)selectCheckBox:(BOOL)selected {
  [self.inner.layer pop_removeAnimationForKey:@"selectLayer"];
  self.inner.hidden = !selected;
  POPSpringAnimation *selectSpring =
  [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  selectSpring.springSpeed = 10;
  selectSpring.springBounciness = 10;
  if (selected) {
    selectSpring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    selectSpring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
  } else {
    selectSpring.fromValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    selectSpring.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
  }
  [self.inner.layer pop_addAnimation:selectSpring forKey:@"selectLayer"];
}
@end
