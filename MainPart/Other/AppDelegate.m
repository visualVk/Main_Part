//
//  AppDelegate.m
//  MainPart
//
//  Created by blacksky on 2020/2/23.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AppDelegate.h"
#import "AMLocationUtils.h"
#import "LoginMainController.h"
#import "MainTabController.h"
#import "QMUIConfigurationTemplate.h"
#import "QMUIConfigurationTemplateDark.h"
#import "Users.h"
#import <AvoidCrash.h>
#define AMLOCATIONAPPID @"b794a47f8cc58d7845b3b16566172528"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  //防止出现array nil右fundation框架产生，并且没有详细报错内容的乱七八糟的错误
  [AvoidCrash makeAllEffective];
  NSArray *noneSelClassStrings =
  @[ @"NSNull", @"NSNumber", @"NSString", @"NSDictionary", @"NSArray" ];
  [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(dealwithCrashMessage:)
                                               name:AvoidCrashNotification
                                             object:nil];
  [self configurateQmuiTheme];
  //  [AMLocationUtils sharedInstance];
  
  [AMapServices sharedServices].apiKey = AMLOCATIONAPPID;
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  self.window.backgroundColor = UIColor.qd_backgroundColor;
  self.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  //  self.window.rootViewController = [[MainTabController alloc] init];
  UIViewController *con = nil;
  
  Users *users = [Users new];
  BOOL isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"];
  //  if (!users || !users.username || !users.password || [@"" isEqualToString:users.username] ||
  //      [@"" isEqualToString:users.password]) {
  //    con = [LoginMainController new];
  //    isLogined = true;
  //  }
  if (!isLogin) {
    con = [LoginMainController new];
  } else {
    [[RequestUtils shareManager] RequestPostWithUrl:UserLogin
                                          Parameter:@{
                                            @"logincode" : users.username,
                                            @"password" : users.password
                                          }
                                            Success:^(NSDictionary *_Nullable dict) {
      [[NSUserDefaults standardUserDefaults] setValue:@(true) forKey:@"islogin"];
      NSString *datas = dict[@"data"][@"token"];
      QMUILogInfo(@"login", @"%@", datas);
      dispatch_async(dispatch_get_main_queue(), ^{ Bearer = datas; });
      QMUILogInfo(@"login", @"login success,return value:{%@}", [dict description]);
    }
                                            Failure:^(NSError *_Nullable err){}];
    con = [MainTabController new];
  }
  self.window.rootViewController = con;
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
    if ([identifier isEqualToString:QDThemeIdentifierDark])
      return QMUIConfigurationTemplateDark.new;
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

- (void)dealwithCrashMessage:(NSNotification *)note {
  //注意:所有的信息都在userInfo中
  //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
  NSLog(@"%@", note.userInfo);
}
@end
