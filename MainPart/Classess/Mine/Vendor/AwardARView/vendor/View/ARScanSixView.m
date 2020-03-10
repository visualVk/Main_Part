//
//  ARScanSixView.m
//  EasyerAR
//
//  Created by 栗子 on 2018/5/8.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights
//  reserved.
//

#import "ARScanSixView.h"
#import "TonePlayerSimple.h"

#import "RandomView.h"
#import <AudioToolbox/AudioToolbox.h>
#define Space 5.0 //圆角大小
#define Mx(viewWidth) (ScreenWidth - viewWidth) / 2.0
#define My(viewWidth) (ScreenHeight - viewWidth) / 2.0
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define RELOADRIPPLES 100

@interface ARScanSixView () {
  CGPoint _point0;
  CGPoint _point1;
  CGPoint _point2;
  CGPoint _point3;
  CGPoint _point4;
  CGPoint _point5;
  CGPoint _Point0;
  CGPoint _Point1;
  CGPoint _Point2;
  CGPoint _Point3;
  CGPoint _Point4;
  CGPoint _Point5;
  
  CGFloat _a01;
  CGFloat _b01;
  CGFloat _a12;
  CGFloat _b12;
  CGFloat _a34;
  CGFloat _b34;
  
  CGFloat _A01;
  CGFloat _B01;
  CGFloat _A12;
  CGFloat _B12;
  CGFloat _A34;
  CGFloat _B34;
  CGFloat _A45;
  CGFloat _B45;
  CGFloat ViewWidth0;
  CGFloat ViewWidth1;
  __block int timeout;
}
@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) UIBezierPath *animaPath;
@property (nonatomic, strong) UIView *ripplesBackView;
@property (nonatomic, strong) RandomView *showSuccessView;
@property (nonatomic, strong) CAAnimationGroup *showSuccessGroup;
@property (nonatomic, strong) CAAnimationGroup *aniRipples;

@end

@implementation ARScanSixView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    ViewWidth0 = 330;
    ViewWidth1 = 350;
    if (ScreenWidth == 320) {
      ViewWidth0 = 290;
      ViewWidth1 = 310;
    }
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    [self creatPoint];
    [self calculateSmall];
    [self drawRect:frame];
    [self ripplesRepeatCount];
    [self ripples:self.ripplesBackView];
  }
  return self;
}

#pragma mark - 绘制Layer层
- (void)drawRect:(CGRect)rect {
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
  
  UIBezierPath *bezierPath = [self creatPathViewWidth:ViewWidth0];
  [path appendPath:bezierPath];
  [path setUsesEvenOddFillRule:YES];
  
  //蒙版背景填充
  CAShapeLayer *fillLayer = [CAShapeLayer layer];
  fillLayer.path = path.CGPath;
  fillLayer.fillRule = kCAFillRuleEvenOdd;
  fillLayer.fillColor = [UIColor blackColor].CGColor;
  fillLayer.opacity = 0.3;
  [self.layer addSublayer:fillLayer];
  
  //六边形边框及镂空
  CAShapeLayer *shapLayer = [CAShapeLayer layer];
  shapLayer.lineWidth = 3;
  shapLayer.strokeColor = [UIColor redColor].CGColor;
  shapLayer.fillColor = [UIColor clearColor].CGColor;
  shapLayer.path = bezierPath.CGPath;
  [self.layer addSublayer:shapLayer];
  
  //动画路径
  _animaPath = [self creatPathViewWidth:ViewWidth1];
}

#pragma mark - 围着多边形环绕动画
- (void)starAnimation {
  
  for (CALayer *layer in self.layers) { [layer removeFromSuperlayer]; }
  for (int i = 0; i < 100; i++) { // 100个环绕动画🤣
    CFTimeInterval beginTime = CACurrentMediaTime() + (0.005 * i);
    [self pathAnimation:beginTime withIndex:i];
  }
}

- (void)stopAnimtion {
  //暂停layer上面的动画
  for (CALayer *layer in self.layers) {
    [layer removeFromSuperlayer];
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
  }
}

#pragma mark - 动画
- (void)pathAnimation:(CFTimeInterval)beginTime withIndex:(NSInteger)index {
  
  CALayer *carLayer = [[CALayer alloc] init];
  carLayer.frame = CGRectMake(0, 0, 6, 3);
  
  float scale = 1 - (float)index / 100.f;
  carLayer.contents = (__bridge id _Nullable)(
                                              [self imageWithColor:[[UIColor redColor] colorWithAlphaComponent:scale]].CGImage);
  
  [self.layer addSublayer:carLayer];
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
  // 绘制路径（动画）
  animation.path = _animaPath.CGPath;
  
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  animation.duration = 2.5;
  animation.beginTime = beginTime;
  animation.repeatCount = MAXFLOAT;
  animation.autoreverses = NO;
  animation.calculationMode = kCAAnimationCubicPaced;
  animation.rotationMode = kCAAnimationRotateAuto;
  [carLayer addAnimation:animation forKey:@"carAnimation"];
  
  [self.layers addObject:carLayer];
}

#pragma mark - 绘制六边形
- (UIBezierPath *)creatPathViewWidth:(CGFloat)viewWidth {
  
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  if (viewWidth == ViewWidth0) {
    //内六边形
    CGPoint point0 = CGPointMake(_point0.x + 15, _a01 * (_point0.x + 15) + _b01);
    CGPoint point1 = CGPointMake(_point1.x - Space, _a01 * (_point1.x - Space) + _b01);
    CGPoint point2 = CGPointMake(_point1.x + Space, point1.y);
    CGPoint point3 = CGPointMake(_point2.x - Space, _a12 * (_point2.x - Space) + _b12);
    CGPoint point4 = CGPointMake(_point2.x, _point2.y + (Space / cos(M_1_PI / 180 * 60)));
    CGPoint point5 = CGPointMake(_point3.x, _point3.y - (Space / cos(M_1_PI / 180 * 60)));
    CGPoint point6 = CGPointMake(point3.x, _a34 * point3.x + _b34);
    CGPoint point7 = CGPointMake(point2.x, _a34 * point2.x + _b34);
    CGPoint point8 = CGPointMake(point1.x, point7.y);
    CGPoint point9 = CGPointMake(_point0.x + Space, point6.y);
    CGPoint point10 = CGPointMake(_point0.x, point5.y);
    CGPoint point11 = CGPointMake(_point0.x, point4.y);
    CGPoint point12 = CGPointMake(point9.x, point3.y);
    [bezierPath moveToPoint:point0];
    [bezierPath addLineToPoint:point1];
    [bezierPath addQuadCurveToPoint:point2 controlPoint:_point1];
    [bezierPath addLineToPoint:point3];
    [bezierPath addQuadCurveToPoint:point4 controlPoint:_point2];
    [bezierPath addLineToPoint:point5];
    [bezierPath addQuadCurveToPoint:point6 controlPoint:_point3];
    [bezierPath addLineToPoint:point7];
    [bezierPath addQuadCurveToPoint:point8 controlPoint:_point4];
    [bezierPath addLineToPoint:point9];
    [bezierPath addQuadCurveToPoint:point10 controlPoint:_point5];
    [bezierPath addLineToPoint:point11];
    [bezierPath addQuadCurveToPoint:point12 controlPoint:_point0];
    [bezierPath closePath];
  } else {
    //外六边形
    CGPoint point0 = CGPointMake(_Point0.x + 15, _A01 * (_Point0.x + 15) + _B01);
    CGPoint point1 = CGPointMake(_Point1.x - Space, _A01 * (_Point1.x - Space) + _B01);
    CGPoint point2 = CGPointMake(_Point1.x + Space, point1.y);
    CGPoint point3 = CGPointMake(_Point2.x - Space, _A12 * (_Point2.x - Space) + _B12);
    CGPoint point4 = CGPointMake(_Point2.x, _Point2.y + (Space / cos(M_1_PI / 180 * 60)));
    CGPoint point5 = CGPointMake(_Point3.x, _Point3.y - (Space / cos(M_1_PI / 180 * 60)));
    CGPoint point6 = CGPointMake(point3.x, _A34 * point3.x + _B34);
    CGPoint point7 = CGPointMake(point2.x, _A34 * point2.x + _B34);
    CGPoint point8 = CGPointMake(point1.x, point7.y);
    CGPoint point9 = CGPointMake(_Point0.x + Space, point6.y);
    CGPoint point10 = CGPointMake(_Point0.x, point5.y);
    CGPoint point11 = CGPointMake(_Point0.x, point4.y);
    CGPoint point12 = CGPointMake(point9.x, point3.y);
    [bezierPath moveToPoint:point0];
    [bezierPath addLineToPoint:point1];
    [bezierPath addQuadCurveToPoint:point2 controlPoint:_Point1];
    [bezierPath addLineToPoint:point3];
    [bezierPath addQuadCurveToPoint:point4 controlPoint:_Point2];
    [bezierPath addLineToPoint:point5];
    [bezierPath addQuadCurveToPoint:point6 controlPoint:_Point3];
    [bezierPath addLineToPoint:point7];
    [bezierPath addQuadCurveToPoint:point8 controlPoint:_Point4];
    [bezierPath addLineToPoint:point9];
    [bezierPath addQuadCurveToPoint:point10 controlPoint:_Point5];
    [bezierPath addLineToPoint:point11];
    [bezierPath addQuadCurveToPoint:point12 controlPoint:_Point0];
    [bezierPath closePath];
  }
  return bezierPath;
}

#pragma mark - 六边形顶点坐标
- (void)creatPoint {
  //左上角为------point0-------
  _point0 = CGPointMake((sin(M_1_PI / 180 * 60)) * (ViewWidth0 / 2) + Mx(ViewWidth0),
                        (ViewWidth0 / 4) + My(ViewWidth0));
  _point1 = CGPointMake((ViewWidth0 / 2) + Mx(ViewWidth0), 0 + My(ViewWidth0));
  _point2 = CGPointMake(ViewWidth0 - ((sin(M_1_PI / 180 * 60)) * (ViewWidth0 / 2)) + Mx(ViewWidth0),
                        (ViewWidth0 / 4) + My(ViewWidth0));
  _point3 = CGPointMake(ViewWidth0 - ((sin(M_1_PI / 180 * 60)) * (ViewWidth0 / 2)) + Mx(ViewWidth0),
                        (ViewWidth0 / 2) + (ViewWidth0 / 4) + My(ViewWidth0));
  _point4 = CGPointMake((ViewWidth0 / 2) + Mx(ViewWidth0), ViewWidth0 + My(ViewWidth0));
  _point5 = CGPointMake((sin(M_1_PI / 180 * 60)) * (ViewWidth0 / 2) + Mx(ViewWidth0),
                        (ViewWidth0 / 2) + (ViewWidth0 / 4) + My(ViewWidth0));
  
  _Point0 = CGPointMake((sin(M_1_PI / 180 * 60)) * (ViewWidth1 / 2) + Mx(ViewWidth1),
                        (ViewWidth1 / 4) + My(ViewWidth1));
  _Point1 = CGPointMake((ViewWidth1 / 2) + Mx(ViewWidth1), 0 + My(ViewWidth1));
  _Point2 = CGPointMake(ViewWidth1 - ((sin(M_1_PI / 180 * 60)) * (ViewWidth1 / 2)) + Mx(ViewWidth1),
                        (ViewWidth1 / 4) + My(ViewWidth1));
  _Point3 = CGPointMake(ViewWidth1 - ((sin(M_1_PI / 180 * 60)) * (ViewWidth1 / 2)) + Mx(ViewWidth1),
                        (ViewWidth1 / 2) + (ViewWidth1 / 4) + My(ViewWidth1));
  _Point4 = CGPointMake((ViewWidth1 / 2) + Mx(ViewWidth1), ViewWidth1 + My(ViewWidth1));
  _Point5 = CGPointMake((sin(M_1_PI / 180 * 60)) * (ViewWidth1 / 2) + Mx(ViewWidth1),
                        (ViewWidth1 / 2) + (ViewWidth1 / 4) + My(ViewWidth1));
}

#pragma mark - 计算两点所在直线方程
- (void)calculateSmall {
  CGPoint point01 = [self calculateWithPoint0:_point0 point:_point1];
  _a01 = point01.x;
  _b01 = point01.y;
  
  CGPoint point12 = [self calculateWithPoint0:_point1 point:_point2];
  _a12 = point12.x;
  _b12 = point12.y;
  
  CGPoint point34 = [self calculateWithPoint0:_point3 point:_point4];
  _a34 = point34.x;
  _b34 = point34.y;
  
  CGPoint Point01 = [self calculateWithPoint0:_Point0 point:_Point1];
  _A01 = Point01.x;
  _B01 = Point01.y;
  
  CGPoint Point12 = [self calculateWithPoint0:_Point1 point:_Point2];
  _A12 = Point12.x;
  _B12 = Point12.y;
  
  CGPoint Point34 = [self calculateWithPoint0:_Point3 point:_Point4];
  _A34 = Point34.x;
  _B34 = Point34.y;
  
  CGPoint Point45 = [self calculateWithPoint0:_Point4 point:_Point5];
  _A45 = Point45.x;
  _B45 = Point45.y;
}

- (CGPoint)calculateWithPoint0:(CGPoint)point0 point:(CGPoint)point1 {
  
  CGFloat x0 = point0.x;
  CGFloat y0 = point0.y;
  
  CGFloat x1 = point1.x;
  CGFloat y1 = point1.y;
  
  CGFloat a = (y0 - y1) / (x0 - x1);
  CGFloat b = y0 - (a * x0);
  
  CGPoint point = CGPointMake(a, b);
  return point;
}

- (NSMutableArray *)layers {
  if (!_layers) { _layers = [NSMutableArray array]; }
  return _layers;
}

#pragma mark - 涟漪动画
- (void)ripplesRepeatCount {
  timeout = RELOADRIPPLES;
  dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
  dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
  dispatch_source_set_event_handler(timer, ^{
    timeout--;
    if (timeout < 0) {
      dispatch_source_cancel(timer);
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{ [self ripplesArc4random]; });
      if (timeout == 0) { timeout = RELOADRIPPLES; }
    }
  });
  dispatch_resume(timer);
}

#pragma mark - 随机个数点动画
- (void)ripplesArc4random {
  NSInteger count = arc4random() % 6 + 1; // 1~5个
  for (int i = 0; i < count; i++) {
    float second = (float)i / (float)count;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{ [self ripples:self.ripplesBackView]; });
  }
}

#pragma mark - 单个涟漪点动画
- (void)ripples:(UIView *)superView {                   // y 0~w
  CGFloat scaley = (float)(arc4random() % 101) / 100.f; // 0~1 y方向随机一个坐标
  CGFloat scalex = (float)(arc4random() % 101) / 100.f; // 0~1 x方向随机一个坐标
  CGFloat height = ViewWidth0 - 20 - 6;                 //六边形高度
  CGFloat width = height / 2.f * tan(M_PI / 3.f) + 10;  //六边形横向的宽度
  CGFloat y = scaley * height;                          //随机出的y坐标
  CGFloat x = 0;
  
  //可以把六边形看成上中下三段 即y为x的分段函数
  superView.frame = CGRectMake(Mx(width), My(height), width, height);
  if (y <= height / 4.f) { //上部
    x = 2.f * y * tan(M_PI / 3.f);
    x = (width - x) / 2 + x * scalex;
  } else if (y >= height / 4.f && y <= 3 * height / 4.f) { //中部
    x = width * scalex;
  } else { //下部
    x = 2.f * (height - y) * tan(M_PI / 3.f);
    x = (width - x) / 2 + x * scalex;
  }
  //中心点
  UIView *viewPoint = [UIView new];
  viewPoint.clipsToBounds = YES;
  viewPoint.center = CGPointMake(x, y);
  viewPoint.bounds = CGRectMake(x, y, 2, 2);
  viewPoint.layer.cornerRadius = 1.f;
  viewPoint.backgroundColor = [UIColor whiteColor];
  [superView addSubview:viewPoint];
  
  //圈儿
  UIView *viewCicle = [UIView new];
  viewCicle.clipsToBounds = YES;
  viewCicle.center = CGPointMake(x, y);
  viewCicle.bounds = CGRectMake(x, y, 16, 16);
  viewCicle.layer.cornerRadius = 8;
  viewCicle.layer.borderWidth = 0.5;
  viewCicle.layer.borderColor = [UIColor whiteColor].CGColor;
  viewCicle.backgroundColor = [UIColor clearColor];
  [superView addSubview:viewCicle];
  viewCicle.transform = CGAffineTransformMakeScale(0, 0);
  [viewCicle.layer addAnimation:self.aniRipples forKey:@"aniRipples"];
  
  //延时1.5s消失
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
    [viewCicle.layer removeAllAnimations];
    [UIView animateWithDuration:0.3
                     animations:^{ viewPoint.alpha = 0; }
                     completion:^(BOOL finished) {
      [viewCicle removeFromSuperview];
      [viewPoint removeFromSuperview];
    }];
  });
}

#pragma mark - 扫描成功动画
- (void)sucessAnimtion {
  //提示音
  TonePlayerSimple *playerSimple = [TonePlayerSimple tonePlayer];
  NSURL *voiceURL = [[NSBundle mainBundle] URLForResource:@"wechat_scan" withExtension:@"wav"];
  [playerSimple playerUrl:voiceURL];
  //        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);// 震动
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
    timeout = -1;
    self.showSuccessView.hidden = NO;
    [self.showSuccessView starAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
      for (UIView *view in self.ripplesBackView.subviews) {
        [view.layer removeAllAnimations];
        [view removeFromSuperview];
      }
      [self stopAnimtion];
      [self.showSuccessView stopAnimation];
      self.showSuccessView.hidden = YES;
      if (self.success) { self.success(); }
    });
  });
}
- (UIView *)ripplesBackView {
  if (!_ripplesBackView) {
    _ripplesBackView = [UIView new];
    _ripplesBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:_ripplesBackView];
  }
  return _ripplesBackView;
}

- (RandomView *)showSuccessView {
  if (!_showSuccessView) {
    _showSuccessView = [[RandomView alloc] init];
    [self addSubview:_showSuccessView];
    _showSuccessView.frame = CGRectMake(0, 0, 50, 50);
    _showSuccessView.center = self.center;
    _showSuccessView.hidden = YES;
  }
  return _showSuccessView;
}

- (CAAnimationGroup *)showSuccessGroup {
  if (!_showSuccessGroup) {
    CAKeyframeAnimation *rectangleTransformAnim =
    [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    rectangleTransformAnim.values = @[
      [NSValue valueWithCATransform3D:CATransform3DIdentity],
      [NSValue valueWithCATransform3D:CATransform3DMakeScale(5, 5, 1)]
    ];
    rectangleTransformAnim.keyTimes = @[ @0, @0.79 ];
    rectangleTransformAnim.duration = 0.65;
    rectangleTransformAnim.repeatCount = 1;
    rectangleTransformAnim.removedOnCompletion = NO;
    rectangleTransformAnim.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *rectangleOpacityAnim =
    [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    rectangleOpacityAnim.values = @[ @1, @0 ];
    rectangleOpacityAnim.keyTimes = @[ @0, @0.8 ];
    rectangleOpacityAnim.duration = 0.65;
    rectangleOpacityAnim.repeatCount = 1;
    rectangleOpacityAnim.removedOnCompletion = NO;
    rectangleOpacityAnim.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations =
    [NSArray arrayWithObjects:rectangleTransformAnim, rectangleOpacityAnim, nil];
    animGroup.duration = 0.65;
    animGroup.repeatCount = 1;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    _showSuccessGroup = animGroup;
  }
  return _showSuccessGroup;
}

- (CAAnimationGroup *)aniRipples {
  if (!_aniRipples) {
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.duration = 1.5;
    alphaAnimation.values = @[
      [NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.f],
      [NSNumber numberWithFloat:0.0f]
    ];
    alphaAnimation.repeatCount = 1;
    
    // 给这个layer添加动画效果
    CAKeyframeAnimation *pathAnimation =
    [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    pathAnimation.duration = 1.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.values = @[ [NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1.2f] ];
    
    _aniRipples = [CAAnimationGroup animation];
    _aniRipples.animations = @[ alphaAnimation, pathAnimation ];
    _aniRipples.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _aniRipples.removedOnCompletion = NO;
    _aniRipples.fillMode = kCAFillModeForwards;
    _aniRipples.duration = 1.5f;
    _aniRipples.repeatCount = MAXFLOAT;
  }
  return _aniRipples;
}

- (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 18.0f, 9.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
