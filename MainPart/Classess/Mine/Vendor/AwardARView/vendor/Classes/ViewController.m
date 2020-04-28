//=============================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights
// Reserved. EasyAR is the registered trademark or trademark of VisionStar Information Technology
// (Shanghai) Co., Ltd in China and other countries for the augmented reality technology developed
// by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================

#import "ViewController.h"

#import "ARScanSixView.h"
#import "OpenGLView.h"
#import "PopView.h"
#import <QMUIKit.h>
#import <easyar/camera.oc.h>
#import <easyar/cloud.oc.h>
#import <easyar/engine.oc.h>
#import <easyar/imagetracker.oc.h>

@interface ViewController () {
  OpenGLView *glView;
  BOOL isSuccess;
  float scale; //相机缩放倍数
  BOOL isZoom; //已经放大了
}
@property (nonatomic, strong) ARScanSixView *aniView;
@end

@implementation ViewController

/*
 * Steps to create the key for this sample:
 *  1. login www.easyar.com
 *  2. create app with
 *      Name: HelloARCloud
 *      Bundle ID: cn.easyar.samples.helloarcloud
 *  3. find the created item in the list and show key
 *  4. set key string bellow
 */
NSString *key =
@"h+I97oPxJfKbl+zqRjulz4MYz2YclIQTspIVlbfQC8WDwA3Yt80alfiBXIf2m1+E9ZtdhoLSH5mhzAOV7oED1rHXC8WJxhf+poFUhu6BAt6hxgDEp9BMjZnYTNW3zQrbp+oKxOCZNerugRjWsMoP2bbQTI2ZgQ3Yr84b2avXF5Wfj0zHrsIa0a3RA8TgmTWVtcoA063UHZXugQPWoYEzm+DOAdO3zwvE4Jk1lbHGAMSnjSfao8QL47DCDdyrzQmV7oEd0qzQC5mBzwHCpvEL1K3EAN62ygHZ4I9MxKfNHdLs8QvUrdEK3qzETJvg0AvZscZA+KDJC9S29xzWocgH2aWBQpWxxgDEp409wrDFD9Sn9xzWocgH2aWBQpWxxgDEp409x6PRHdKR0w/Dq8IC+qPTTJvg0AvZscZA+q3XB9is9xzWocgH2aWBQpWxxgDEp40q0qzQC+Sywhreo88j1rKBQpWxxgDEp40t9ob3HNahyAfZpYEzm+DGFser0Qvjq84L5LbCA8fgmQDCrs9ClavQItihwgKV+MUP27HGE5u5gQzCrMcC0ovHHZX4+EzUrc5A0afKCNKr2hvS7MsBw6fPD8eygTOb4NUPxavCAMOxgVTs4MAB2q/WAN622kzq7oEe26PXCNiwzh2V+PhM1qzHHNirx0zq7oED2KbWAtKxgVTs4NAL2bHGQP6vwgnSltEP1KnKANDgj0zEp80d0uzgAti3xzzSocwJ2avXB9isgUKVscYAxKeNPNKhzBzTq80Jle6BHdKs0AuZjcEE0qHXOsWjwAXerMRMm+DQC9mxxkDkt9EI1qHGOsWjwAXerMRMm+DQC9mxxkDkssIcxKfwHta2yg/bj8Iele6BHdKs0AuZj8wa3q3NOsWjwAXerMRMm+DQC9mxxkDzp80d0pHTD8OrwgL6o9NMm+DQC9mxxkD0g+c6xaPABd6sxEzq7oELz7LKHNKWygPSkdcP2rKBVNm3zwKb4Mod+63AD9vgmQjWrtALyu7YTNW3zQrbp+oKxOCZNZWhzAOZpMYH0afKF8KnjSPWq80+1rDXTOrugRjWsMoP2bbQTI2ZgQ3Yr84b2avXF5Wfj0zHrsIa0a3RA8TgmTWVq8wdlZ+PTNqtxxvbp9BMjZmBHdKs0AuZi84P0Kf3HNahyAfZpYFClbHGAMSnjS3brdYK5afAAdCsyhrerc1Mm+DQC9mxxkDlp8ABxabKANDgj0zEp80d0uzsDN2nwBrjsMIN3KvNCZXugR3SrNALmZHWHNGjwAvjsMIN3KvNCZXugR3SrNALmZHTD8Wxxj3Ho9cH1q7uD8fgj0zEp80d0uzuAcOrzADjsMIN3KvNCZXugR3SrNALmYbGAMSn8B7WtsoP24/CHpXugR3SrNALmYHiKuOwwg3cq80JlZ+PTNK60wfFp/cH2qfwGtav00yNrNYC2+6BB8SOzA3WroFU0aPPHdK//hOvl+MMTmpw6hAV+kbcbYBXthYDtr/HImWa1+Wa0/jEgwCFRA6+FVwLUxxUMML44ui/dMwzHw20Mz8EX/jatRPkvhWayC0COURY4FzNUuZRksf08jS2tGvwAGCRqqlVGqOZmIMny5JU863Vjjg1INJWm5UNEluEwYntf7VbegkjWFzBMQcFC9oMc9D3ys9SxgsK5p/fyhE9iKOv4pqoWIrLAmnsGbQiEGEHo/Uu49SKz1xxY/EiICMLbqba0WR7P+Vu2zPoQaZTVqHL9QfsZ8elwAPQh+M5hLdpnWCRUOsovUVccSiaTHYb8WgUf/vddvx2N+rszk8SlbtlAH7Co263";
NSString *cloudRecognitionServiceServerAddress =
@"d563ad7640837416c6ef3d1df96ac79c.cn1.crs.easyar.com:8080";
NSString *apiKey = @"625766bf58f1f645a8046ec7ae382ce0";
NSString *apiSecret = @"67be0329fbb0d09a9964489a6f1e210218808a0f62bf316f83bc7266015842e3";
NSString *cloudRecognitionServiceAppId = @"98d3ad6622d7dbdf319ce2550e410a38";

- (void)viewDidLoad {
  [super viewDidLoad];
  if (![easyar_Engine initialize:key]) {
    NSLog(@"Initialization Failed.");
    [ViewController displayToastWithMessage:[easyar_Engine errorMessage]];
    return;
  }
  if ([cloudRecognitionServiceServerAddress
       isEqual:
       @"===PLEASE ENTER YOUR EASYAR CLOUD RECOGNITION SERVICE SERVER ADDRESS HERE==="]) {
    [ViewController displayToastWithMessage:@"Please enter your cloud server address"];
    return;
  }
  if (![easyar_CameraDevice isAvailable]) {
    [ViewController displayToastWithMessage:@"CameraDevice not available."];
    return;
  }
  if (![easyar_ImageTracker isAvailable]) {
    [ViewController displayToastWithMessage:@"ImageTracker not available."];
    return;
  }
  if (![easyar_CloudRecognizer isAvailable]) {
    [ViewController displayToastWithMessage:@"CloudRecognizer not available."];
    return;
  }
  OpenGLView *view = (OpenGLView *)(self.view);
  [view initialize];
  [view setOrientation:self.interfaceOrientation];
  [self ceateUI];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  OpenGLView *view = (OpenGLView *)(self.view);
  [view start];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  OpenGLView *view = (OpenGLView *)(self.view);
  [view stop];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
  [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
  OpenGLView *view = (OpenGLView *)(self.view);
  [view setOrientation:toInterfaceOrientation];
}

+ (void)displayToastWithMessage:(NSString *)toastMessage {
  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UILabel *toastView = [[UILabel alloc] init];
    toastView.text = toastMessage;
    toastView.textAlignment = NSTextAlignmentCenter;
    toastView.textColor = [UIColor whiteColor];
    toastView.lineBreakMode = NSLineBreakByWordWrapping;
    toastView.numberOfLines = 0;
    toastView.frame = CGRectMake(0.0, 0.0, keyWindow.frame.size.width / 2.0, 200.0);
    toastView.layer.cornerRadius = 10;
    toastView.layer.masksToBounds = YES;
    toastView.center = keyWindow.center;
    
    [keyWindow addSubview:toastView];
    
    [UIView animateWithDuration:0.5f
                          delay:3.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{ toastView.alpha = 0.0f; }
                     completion:^(BOOL finished) { [toastView removeFromSuperview]; }];
  }];
}

- (void)ceateUI {
  
  self.aniView =
  [[ARScanSixView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
  [self.view addSubview:self.aniView];
  [self.view bringSubviewToFront:self.aniView];
  [self.aniView starAnimation];
  __weak __typeof(self) weakSelf = self;
  self.aniView.success = ^{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
      PopView *pop = [[PopView alloc]
                      initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2,
                                               (SCREEN_HEIGHT - 300) / 2, 300, 300)];
      [weakSelf.view addSubview:pop];
      [pop show:YES];
      pop.popBlock =
      ^{ [weakSelf.navigationController popViewControllerAnimated:NO]; };
    });
  };
}

@end
