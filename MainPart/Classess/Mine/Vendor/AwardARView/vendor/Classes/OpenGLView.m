//=============================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights
// Reserved. EasyAR is the registered trademark or trademark of VisionStar Information Technology
// (Shanghai) Co., Ltd in China and other countries for the augmented reality technology developed
// by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================

#import "OpenGLView.h"
#import "AppDelegate.h"

#import "helloar.h"

#import <easyar/callbackscheduler.oc.h>
#import <easyar/camera.oc.h>
#import <easyar/engine.oc.h>

#import "AwardView.h"

@interface OpenGLView ()
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation OpenGLView {
  BOOL initialized;
}

- (void)initialize {
  createScheduler();
  self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
  self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
  self.drawableStencilFormat = GLKViewDrawableStencilFormat8;
  [self bindDrawable];
  initialize();
  initialized = TRUE;
  self.isFirst = false;
}

- (void)dealloc {
  finalize();
}

- (void)start {
  if (!initialized) { return; }
  [easyar_CameraDevice requestPermissions:getScheduler()
                       permissionCallback:^(easyar_PermissionStatus status, NSString *value) {
    switch (status) {
      case easyar_PermissionStatus_Denied:
        NSLog(@"camera permission denied");
        break;
      case easyar_PermissionStatus_Granted:
        start();
        break;
      case easyar_PermissionStatus_Error:
        NSLog(@"camera permission error");
        break;
      default:
        break;
    }
  }];
}

- (void)stop {
  if (!initialized) { return; }
  stop();
}

- (void)drawRect:(CGRect)rect {
  if (!initialized) { return; }
  
  float scale;
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
    scale = [[UIScreen mainScreen] nativeScale];
#pragma clang diagnostic pop
  } else {
    scale = [[UIScreen mainScreen] scale];
  }
  
  BOOL result = render(rect.size.width * scale, rect.size.height * scale, _screenRotation);
  if (result) {
    [self stop];
    if (!self.isFirst) {
      self.isFirst = true;
      __weak __typeof(self) weakSelf = self;
      AwardView *awardView = [[AwardView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
      awardView.closeClickBlock = ^{
        weakSelf.isFirst = false;
        [weakSelf start];
      };
      [awardView showView];
    }
  }
}

- (void)setOrientation:(UIInterfaceOrientation)orientation {
  switch (orientation) {
    case UIInterfaceOrientationPortrait:
      _screenRotation = 0;
      break;
    case UIInterfaceOrientationLandscapeRight:
      _screenRotation = 90;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      _screenRotation = 180;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      _screenRotation = 270;
      break;
    default:
      break;
  }
}

@end
