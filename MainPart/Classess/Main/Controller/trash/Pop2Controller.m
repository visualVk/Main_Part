//
//  Pop2Controller.m
//  MainPart
//
//  Created by blacksky on 2020/2/24.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Pop2Controller.h"
#import "DetailHeaderPartCell.h"
#import "MarkUtils.h"
#import <BTCoverVerticalTransition.h>
#import <JQCollectionViewAlignLayout.h>
#define DETAILHEADERCELL @"detailheadercell"

@interface Pop2Controller () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, GenerateEntityDelegate>
@property (nonatomic, strong) BTCoverVerticalTransition *animation;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSArray *imageList;
@end

@implementation Pop2Controller

- (instancetype)init {
  self = [super init];
  if (self) {
    
    self.imageList = @[ @"pink_gradient" ];
    _animation = [[BTCoverVerticalTransition alloc] initPresentViewController:self
                                                        withRragDismissEnabal:YES];
    self.transitioningDelegate = _animation;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:1];
  [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection {
  // 适配屏幕，横竖屏
  //    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width,
  //    traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
  //
  //    self.slider.maximumValue = self.preferredContentSize.height;
  //    self.slider.minimumValue = 220.f;
  //    self.slider.value = self.slider.maximumValue;
}

/// 屏幕旋转时调用的方法
/// @param newCollection 新的方向
/// @param coordinator 动画协调器
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
  [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)dealloc {
  NSLog(@"!!~~");
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before
 navigation - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
