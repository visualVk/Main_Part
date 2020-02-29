//
//  QRCodeScanController.m
//  MainPart
//
//  Created by blacksky on 2020/2/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QRCodeScanController.h"
#import "LBXAlertAction.h"
#import "LBXPermission.h"
#import "MarkUtils.h"
#import "QDSingleImagePickerPreviewViewController.h"
#import "StyleDIY.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <LBXScanNative.h>
#import <LBXScanVideoZoomView.h>
#import <LBXScanView.h>
#import <LBXScanViewController.h>
#import <Photos/Photos.h>
#define MaxSelectedImageCount 9
#define NormalImagePickingTag 1045
#define ModifiedImagePickingTag 1046
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048

static QMUIAlbumContentType const kAlbumContentType = QMUIAlbumContentTypeAll;

@interface QRCodeScanController () <
GenerateEntityDelegate, LBXScanViewControllerDelegate, QMUINavigationControllerDelegate,
QMUIImagePickerViewControllerDelegate, QMUIAlbumViewControllerDelegate,
QMUIImagePickerPreviewViewControllerDelegate, QDSingleImagePickerPreviewViewControllerDelegate>
@property (nonatomic, strong) LBXScanView *qRScanView;
@property (nonatomic, strong) LBXScanNative *scanObj;
@property (nonatomic, strong) UIImage *scanImage;
@property (nonatomic, assign) SCANCODETYPE scanCodeType;
@property (nonatomic, assign) BOOL isNeedScanImage;
@property (nonatomic, assign) BOOL isOpenFlash;
@property (nonatomic, assign) BOOL isOpenInterestRect;
@property (nonatomic, copy) NSString *cameraInvokeMsg;
@property (nonatomic, strong) LBXScanViewStyle *style;
@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UIView *bottomItemsView;
@property (nonatomic, strong) QMUIButton *flashBtn;
@property (nonatomic, strong) QMUIButton *assetsBtn;
@end

@implementation QRCodeScanController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.style = [StyleDIY ZhiFuBaoStyle];
  self.scanCodeType = SCT_QRCode;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.view.backgroundColor = [UIColor blackColor];
  self.isNeedScanImage = YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self drawScanView];
  
  [self requestCameraPemissionWithResult:^(BOOL granted) {
    
    if (granted) {
      
      //不延时，可能会导致界面黑屏并卡住一会
      [self performSelector:@selector(startScan) withObject:nil afterDelay:0.3];
      
    } else {
      [_qRScanView stopDeviceReadying];
    }
  }];
  
  [self drawTitle];
  [self.view bringSubviewToFront:_topTitle];
  [self drawBottomItemsView];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  
  [self stopScan];
  [_qRScanView stopScanAnimation];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
}

- (void)generateRootView {
}

#pragma mark - 绘制扫描框
- (void)drawScanView {
  
  if (!_qRScanView) {
    CGRect rect = self.view.frame;
    rect.origin = CGPointMake(0, 0);
    
    self.qRScanView = [[LBXScanView alloc] initWithFrame:rect style:_style];
    
    [self.view addSubview:_qRScanView];
  }
  
  if (!_cameraInvokeMsg) {}
  
  [_qRScanView startDeviceReadyingWithText:_cameraInvokeMsg];
}

- (void)reStartDevice {
  [_scanObj startScan];
}

- (void)startScan {
  UIView *videoView =
  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),
                                           CGRectGetHeight(self.view.frame))];
  videoView.backgroundColor = [UIColor clearColor];
  [self.view insertSubview:videoView atIndex:0];
  __weak __typeof(self) weakSelf = self;
  
  if (!_scanObj) {
    CGRect cropRect = CGRectZero;
    //只识别扫描框中的
    if (_isOpenInterestRect) {
      cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
    }
    
    NSString *strCode = AVMetadataObjectTypeQRCode;
    if (_scanCodeType != SCT_BarCodeITF) { strCode = [self nativeCodeWithType:_scanCodeType]; }
    self.scanObj = [[LBXScanNative alloc] initWithPreView:videoView
                                               ObjectType:@[ strCode ]
                                                 cropRect:cropRect
                                                  success:^(NSArray<LBXScanResult *> *array) {
      
      [weakSelf scanResultWithArray:array];
    }];
    [_scanObj setNeedCaptureImage:_isNeedScanImage];
  }
  [_scanObj startScan];
  
  [_qRScanView stopDeviceReadying];
  [_qRScanView startScanAnimation];
  self.view.backgroundColor = [UIColor clearColor];
}

- (void)stopScan {
  [_scanObj stopScan];
}

#pragma mark -扫码结果处理

- (void)scanResultWithArray:(NSArray<LBXScanResult *> *)array {
  if (array.count < 1) {
    [self popAlertMsgWithScanResult:nil];
    return;
  }
  
  //  for (LBXScanResult *result in array) { NSLog(@"scanResult:%@", result.strScanned); }
  
  LBXScanResult *scanResult = array[0];
  
  NSString *strResult = scanResult.strScanned;
  
  self.scanImage = scanResult.imgScanned;
  
  if (!strResult) {
    
    [self popAlertMsgWithScanResult:nil];
    
    return;
  }
  /// 显示结果
  [self popAlertMsgWithScanResult:scanResult.strScanned];
}

//开关闪光灯
- (void)openOrCloseFlash {
  [_scanObj changeTorch];
  self.isOpenFlash = !self.isOpenFlash;
}

- (NSString *)nativeCodeWithType:(SCANCODETYPE)type {
  switch (type) {
    case SCT_QRCode:
      return AVMetadataObjectTypeQRCode;
      break;
    case SCT_BarCode93:
      return AVMetadataObjectTypeCode93Code;
      break;
    case SCT_BarCode128:
      return AVMetadataObjectTypeCode128Code;
      break;
    case SCT_BarCodeITF:
      return @"ITF条码:only ZXing支持";
      break;
    case SCT_BarEAN13:
      return AVMetadataObjectTypeEAN13Code;
      break;
      
    default:
      return AVMetadataObjectTypeQRCode;
      break;
  }
}

#pragma mark - 请求摄像头权限
- (void)requestCameraPemissionWithResult:(void (^)(BOOL granted))completion {
  if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
    AVAuthorizationStatus permission =
    [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (permission) {
      case AVAuthorizationStatusAuthorized:
        completion(YES);
        break;
      case AVAuthorizationStatusDenied:
      case AVAuthorizationStatusRestricted:
        completion(NO);
        break;
      case AVAuthorizationStatusNotDetermined: {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
              completion(true);
            } else {
              completion(false);
            }
          });
          
        }];
      } break;
    }
  }
}

#pragma mark - 获取摄像头权限子方法
+ (BOOL)photoPermission {
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == ALAuthorizationStatusDenied) { return NO; }
    return YES;
  }
  
  PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
  if (authorStatus == PHAuthorizationStatusDenied) { return NO; }
  return YES;
}

#pragma mark - 绘制标题
- (void)drawTitle {
  if (!_topTitle) {
    self.topTitle = [[UILabel alloc] init];
    _topTitle.bounds = CGRectMake(0, 0, 145, 60);
    _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, 50);
    
    if ([UIScreen mainScreen].bounds.size.height <= 568) {
      _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, 38);
      _topTitle.font = [UIFont systemFontOfSize:14];
    }
    
    _topTitle.textAlignment = NSTextAlignmentCenter;
    _topTitle.numberOfLines = 0;
    _topTitle.text = @"将取景框对准二维码即可自动扫描";
    _topTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:_topTitle];
  }
}

#pragma mark - 显示错误信息
- (void)showError:(NSString *)str {
  [LBXAlertAction showAlertWithTitle:@"提示"
                                 msg:str
                    buttonsStatement:@[ @"知道了" ]
                         chooseBlock:nil];
}

- (void)popAlertMsgWithScanResult:(NSString *)strResult {
  if (!strResult) { strResult = @"识别失败"; }
  
  __weak __typeof(self) weakSelf = self;
  [LBXAlertAction showAlertWithTitle:@"扫码内容"
                                 msg:strResult
                    buttonsStatement:@[ @"知道了" ]
                         chooseBlock:^(NSInteger buttonIdx) { [weakSelf reStartDevice]; }];
}

- (void)showNextVCWithScanResult:(LBXScanResult *)strResult {
  QMUILogInfo(@"qr code scan", @"code:%@", strResult.strScanned);
}

#pragma mark - 绘制底部工具视图
- (void)drawBottomItemsView {
  if (!_bottomItemsView) {
    self.bottomItemsView = [UIView new];
    self.bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.assetsBtn = [QMUIButton new];
    [self.assetsBtn setImage:UIImageMake(@"qrcode_scan_btn_photo_nor")
                    forState:UIControlStateNormal];
    [self.assetsBtn setImage:UIImageMake(@"qrcode_scan_btn_photo_down")
                    forState:UIControlStateHighlighted];
    [self.assetsBtn addTarget:self
                       action:@selector(authorizationPresentAlbumViewControllerWithTitle)
             forControlEvents:UIControlEventTouchUpInside];
    addView(self.view, self.bottomItemsView);
    addView(self.bottomItemsView, self.assetsBtn);
    [self.bottomItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
      //      make.right.left.equalTo(self.view).with.inset(SPACE);
      make.centerX.equalTo(self.view);
      make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.assetsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.leading.bottom.equalTo(self.bottomItemsView);
    }];
    
    self.flashBtn = [QMUIButton new];
    addView(self.bottomItemsView, self.flashBtn);
    [self.flashBtn setImage:UIImageMake(@"qrcode_scan_btn_flash_nor")
                   forState:UIControlStateNormal];
    [self.flashBtn addTarget:self
                      action:@selector(openOrCloseFlash)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.equalTo(self.assetsBtn.mas_trailing).with.inset(SPACE);
      make.top.trailing.bottom.equalTo(self.bottomItemsView);
    }];
  }
}

- (void)authorizationPresentAlbumViewControllerWithTitle {
  if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusNotDetermined) {
    [QMUIAssetsManager requestAuthorization:^(QMUIAssetAuthorizationStatus status) {
      dispatch_async(dispatch_get_main_queue(),
                     ^{ [self presentAlbumViewControllerWithTitle:@"选择一张图片"]; });
    }];
  } else {
    [self presentAlbumViewControllerWithTitle:@"选择一张图片"];
  }
}
- (void)presentAlbumViewControllerWithTitle:(NSString *)title {
  
  // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
  QMUIAlbumViewController *albumViewController = [[QMUIAlbumViewController alloc] init];
  albumViewController.albumViewControllerDelegate = self;
  albumViewController.contentType = kAlbumContentType;
  albumViewController.title = title;
  albumViewController.view.tag = SingleImagePickingTag;
  //    }
  
  QMUINavigationController *navigationController =
  [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
  
  // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
  [albumViewController pickLastAlbumGroupDirectlyIfCan];
  
  [self presentViewController:navigationController animated:YES completion:NULL];
}
//}
#pragma mark - <QMUIAlbumViewControllerDelegate>
- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:
(QMUIAlbumViewController *)albumViewController {
  QMUIImagePickerViewController *imagePickerViewController =
  [[QMUIImagePickerViewController alloc] init];
  imagePickerViewController.imagePickerViewControllerDelegate = self;
  imagePickerViewController.maximumSelectImageCount = 1;
  imagePickerViewController.view.tag = albumViewController.view.tag;
  if (albumViewController.view.tag == SingleImagePickingTag) {
    imagePickerViewController.allowsMultipleSelection = NO;
  }
  return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>

- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController
didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
  // 储存最近选择了图片的相册，方便下次直接进入该相册
  [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerViewController.assetsGroup
                                          ablumContentType:kAlbumContentType
                                              userIdentify:nil];
}

- (QMUIImagePickerPreviewViewController *)
imagePickerPreviewViewControllerForImagePickerViewController:
(QMUIImagePickerViewController *)imagePickerViewController {
  QDSingleImagePickerPreviewViewController *imagePickerPreviewViewController =
  [[QDSingleImagePickerPreviewViewController alloc] init];
  imagePickerPreviewViewController.delegate = self;
  imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
  imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
  return imagePickerPreviewViewController;
}

#pragma mark - <QDSingleImagePickerPreviewViewControllerDelegate>
- (void)imagePickerPreviewViewController:
(QDSingleImagePickerPreviewViewController *)imagePickerPreviewViewController
           didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset {
  // 储存最近选择了图片的相册，方便下次直接进入该相册
  [QMUIImagePickerHelper
   updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup
   ablumContentType:kAlbumContentType
   userIdentify:nil];
  [imageAsset requestImageData:^(NSData *imageData, NSDictionary<NSString *, id> *info, BOOL isGif,
                                 BOOL isHEIC) {
    UIImage *targetImage = nil;
    if (isGif) {
      targetImage = [UIImage qmui_animatedImageWithData:imageData];
    } else {
      targetImage = [UIImage imageWithData:imageData];
      if (isHEIC) {
        targetImage = [UIImage imageWithData:UIImageJPEGRepresentation(targetImage, 1)];
      }
    }
    [self performSelector:@selector(setPhoto:) withObject:targetImage afterDelay:1.8];
  }];
}

- (void)setPhoto:(UIImage *)qrCodeImage {
  __weak __typeof(self) weakSelf = self;
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    [LBXScanNative recognizeImage:qrCodeImage
                          success:^(NSArray<LBXScanResult *> *array) {
      [weakSelf scanResultWithArray:array];
    }];
  } else {
    [self showError:@"native低于ios8.0系统不支持识别图片条码"];
  }
}
@end
