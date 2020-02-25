//
//  AppDelegate.m
//  MainPart
//
//  Created by blacksky on 2020/2/23.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AppDelegate.h"
#import "AMLocationUtils.h"
#import "MainTabController.h"
#import "QMUIConfigurationTemplate.h"
#define AMLOCATIONAPPID @"b794a47f8cc58d7845b3b16566172528"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self configurateQmuiTheme];
  //  [AMLocationUtils sharedInstance];
  [AMapServices sharedServices].apiKey = AMLOCATIONAPPID;
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  self.window.backgroundColor = UIColor.qd_backgroundColor;
  self.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  self.window.rootViewController = [[MainTabController alloc] init];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - configurate qmui theme
- (void)configurateQmuiTheme {
  // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleThemeDidChangeNotification:)
                                               name:QMUIThemeDidChangeNotification
                                             object:nil];
  
  // 2. 然后设置主题的生成器
  QMUIThemeManagerCenter.defaultThemeManager.themeGenerator =
  ^__kindof NSObject *_Nonnull(NSString *_Nonnull identifier) {
    if ([identifier isEqualToString:QDThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
    return nil;
  };
  
  if (@available(iOS 13.0, *)) {
    if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) {
      QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait =
      ^__kindof NSObject<NSCopying> *_Nonnull(UITraitCollection *_Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) { return QDThemeIdentifierDark; }
        
        if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier
             isEqual:QDThemeIdentifierDark]) {
          return QDThemeIdentifierDefault;
        }
        
        return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
      };
      QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
    }
  }
  // QD自定义的全局样式渲染
  [QDCommonUI renderGlobalAppearances];
  // 预加载 QQ 表情，避免第一次使用时卡顿
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                 ^{ [QDUIHelper qmuiEmotions]; });
}

#pragma mark - handle change notification
- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
  QMUIThemeManager *manager = notification.object;
  if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;
  
  [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier
                                            forKey:QDSelectedThemeIdentifier];
  
  [QDThemeManager.currentTheme applyConfigurationTemplate];
  
  // 主题发生变化，在这里更新全局 UI 控件的 appearance
  [QDCommonUI renderGlobalAppearances];
  
  // 更新表情 icon 的颜色
  [QDUIHelper updateEmotionImages];
}
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application
// configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
// options:(UISceneConnectionOptions *)options {
//  // Called when a new scene session is being created.
//  // Use this method to select a configuration to create the new scene with.
//  return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
//  sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *>
//*)sceneSessions {
//  // Called when the user discards a scene session.
//  // If any sessions were discarded while the application was not running, this will be called
//  shortly after application:didFinishLaunchingWithOptions.
//  // Use this method to release any resources that were specific to the discarded scenes, as they
//  will not return.
//}

@end
