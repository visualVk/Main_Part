//
//  LinkageController.m
//  MainPart
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageController.h"
#import "LinkageListModel.h"
#import "LinkageMenuView.h"
#import "MarkUtils.h"
#import "NSDictionary+LoadJson.h"

@interface LinkageController () <GenerateEntityDelegate>
@property (nonatomic, strong) LinkageMenuView *linkageMenu;
@property (nonatomic, strong) LinkageListModel *linkModelList;
@end

@implementation LinkageController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  [self generateRootView];
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
  self.title = @"<##>";
}

- (void)generateRootView {
  addView(self.view, self.linkageMenu);
  
  [self.linkageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

- (LinkageMenuView *)linkageMenu {
  if (!_linkageMenu) {
    NSDictionary *dict = [NSDictionary readLocalFileWithName:@"LinkageListJSON"];
    //    [LinkageListModel mj_setupObjectClassInArray:^NSDictionary * {
    //      return @{ @"linkList" : [LinkageModel class] };
    //    }];
    [LinkageListModel mj_objectClassInArray];
    self.linkModelList = [LinkageListModel mj_objectWithKeyValues:dict];
    _linkageMenu = [[LinkageMenuView alloc] initWithDataSource:self.linkModelList.linkList];
  }
  return _linkageMenu;
}

#pragma mark - <QMUINavigationControllerAppearanceDelegate>

- (UIImage *)navigationBarBackgroundImage {
  return NavBarBackgroundImage;
}

- (UIImage *)navigationBarShadowImage {
  return NavBarShadowImage;
}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
//转场效果
- (NSString *)customNavigationBarTransitionKey {
  return @"LinkageController";
}
@end
