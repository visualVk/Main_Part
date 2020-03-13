//
//  MineAvatarPickerController.m
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineAvatarPickerController.h"
#import "AppDelegate.h"
#import "QDSingleImagePickerPreviewViewController.h"
#import <HQImageEditViewController.h>
#define MaxSelectedImageCount 9
#define NormalImagePickingTag 1045
#define ModifiedImagePickingTag 1046
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048

static QMUIAlbumContentType const kAlbumContentType = QMUIAlbumContentTypeAll;
@interface MineAvatarPickerController () <
QMUIImagePickerViewControllerDelegate, QMUIAlbumViewControllerDelegate,
QMUIImagePickerPreviewViewControllerDelegate, QDSingleImagePickerPreviewViewControllerDelegate,
HQImageEditViewControllerDelegate>
@property (nonatomic, strong) QMUINavigationController *imageNavigationController;
@end

@implementation MineAvatarPickerController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  //  self.title = @"";
}
#pragma mark - 展示相册
- (void)authorizationPresentAlbumViewControllerWithTitle:(NSString *)title {
  if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusNotDetermined) {
    [QMUIAssetsManager requestAuthorization:^(QMUIAssetAuthorizationStatus status) {
      dispatch_async(dispatch_get_main_queue(),
                     ^{ [self presentAlbumViewControllerWithTitle:title]; });
    }];
  } else {
    [self presentAlbumViewControllerWithTitle:title];
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
  
  self.imageNavigationController =
  [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
  
  self.imageNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
  // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
  [albumViewController pickLastAlbumGroupDirectlyIfCan];
  
  [self.parentController presentViewController:self.imageNavigationController
                                      animated:YES
                                    completion:NULL];
}

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
  imagePickerPreviewViewController.imagePickerType = ImagePickerFull;
  imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
  imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
  return imagePickerPreviewViewController;
}

#pragma mark - <QDSingleImagePickerPreviewViewControllerDelegate>
- (void)imagePickerPreviewViewController:
(QDSingleImagePickerPreviewViewController *)imagePickerPreviewViewController
           didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset {
  // 储存最近选择了图片的相册，方便下次直接进入该相册
  __weak __typeof(self) weakSelf = self;
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
    AppDelegate *delegate = (AppDelegate *)[UIApplication.sharedApplication delegate];
    //    [QMUITips showLoading:@"识别中" inView:delegate.window];
    HQImageEditViewController *vc = [[HQImageEditViewController alloc] init];
    vc.originImage = targetImage;
    vc.delegate = self;
    [weakSelf.imageNavigationController pushViewController:vc animated:YES];
  }];
}

- (void)editController:(HQImageEditViewController *)vc
  finishiEditShotImage:(UIImage *)image
       originSizeImage:(UIImage *)originSizeImage {
  [self performSelector:@selector(setPhoto:) withObject:image afterDelay:1.8];
}

- (void)editControllerDidClickCancel:(HQImageEditViewController *)vc {
  [self.imageNavigationController popViewControllerAnimated:YES];
}

- (void)setPhoto:(UIImage *)avatarImg {
  if ([self.delegate respondsToSelector:@selector(installAvatar:)]) {
    [self.delegate installAvatar:avatarImg];
    [self.imageNavigationController dismissViewControllerAnimated:YES completion:^{}];
  }
}
@end
