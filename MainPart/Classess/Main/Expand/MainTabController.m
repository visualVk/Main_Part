//
//  MainTabController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainTabController.h"
#import "CityController.h"
#import "DetailController.h"
#import "ListController.h"
#import "MainController.h"
#import "MineController.h"
#import "RecommondController.h"
#import "SearchListController.h"

@interface MainTabController () {
  NSArray *navArr;
}
@end

@implementation MainTabController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  MainController *main = [MainController new];
  QMUINavigationController *nav1 =
  [[QMUINavigationController alloc] initWithRootViewController:main];
  main.hidesBottomBarWhenPushed = false;
  nav1.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
                                              image:UIImageMake(@"icon_tabbar_uikit")
                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                tag:0];
  //  CityController *city = [CityController new];
  //  QMUINavigationController *nav2 =
  //  [[QMUINavigationController alloc] initWithRootViewController:city];
  //  city.hidesBottomBarWhenPushed = false;
  //  nav2.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
  //                                              image:UIImageMake(@"icon_tabbar_uikit")
  //                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
  //                                                tag:1];
  
  SearchListController *search = [SearchListController new];
  QMUINavigationController *nav2 =
  [[QMUINavigationController alloc] initWithRootViewController:search];
  search.hidesBottomBarWhenPushed = false;
  nav2.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
                                              image:UIImageMake(@"icon_tabbar_uikit")
                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                tag:1];
  
  ListController *list = [ListController new];
  QMUINavigationController *nav3 =
  [[QMUINavigationController alloc] initWithRootViewController:list];
  list.hidesBottomBarWhenPushed = false;
  nav3.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
                                              image:UIImageMake(@"icon_tabbar_uikit")
                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                tag:2];
  
  RecommondController *rec = [RecommondController new];
  QMUINavigationController *nav4 =
  [[QMUINavigationController alloc] initWithRootViewController:rec];
  rec.hidesBottomBarWhenPushed = false;
  nav4.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
                                              image:UIImageMake(@"icon_tabbar_uikit")
                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                tag:3];
  
  //  DetailController *detail = [DetailController new];
  //  QMUINavigationController *nav5 =
  //  [[QMUINavigationController alloc] initWithRootViewController:detail];
  //  detail.hidesBottomBarWhenPushed = false;
  //  nav5.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页"
  //                                              image:UIImageMake(@"icon_tabbar_uikit")
  //                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
  //                                                tag:4];
  MineController *mine = [MineController new];
  QMUINavigationController *nav5 =
  [[QMUINavigationController alloc] initWithRootViewController:mine];
  mine.hidesBottomBarWhenPushed = false;
  nav5.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的"
                                              image:UIImageMake(@"icon_tabbar_uikit")
                                      selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                tag:4];
  self.viewControllers = @[ nav1, nav2, nav3, nav4, nav5 ];
  self.selectedIndex = 0;
}

- (QMUINavigationController *)generateRootNavWithControllerName:(NSString *)name
                                                          title:(NSString *)title
                                                          image:(UIImage *)image {
  Class class = NSClassFromString(name);
  return class;
}

@end
