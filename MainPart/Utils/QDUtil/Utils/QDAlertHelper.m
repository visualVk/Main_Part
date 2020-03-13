//
//  QDAlertHelper.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QDAlertHelper.h"

@implementation QDAlertHelper
+ (void)showChooseAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                  preferredStyle:(QMUIAlertControllerStyle)preferredStyle
                      chooseList:(NSArray<NSString *> *)chooseList
                     chooseBlock:(ChooseBlock)chooseBlock {
  QMUIAlertController *alertCon =
  [[QMUIAlertController alloc] initWithTitle:title
                                     message:message
                              preferredStyle:QMUIAlertControllerStyleAlert];
  QMUIAlertAction *yesAction =
  [QMUIAlertAction actionWithTitle:chooseList[0]
                             style:QMUIAlertActionStyleDefault
                           handler:^(__kindof QMUIAlertController *_Nonnull aAlertController,
                                     QMUIAlertAction *_Nonnull action) { chooseBlock(0); }];
  QMUIAlertAction *noAction =
  [QMUIAlertAction actionWithTitle:chooseList[1]
                             style:QMUIAlertActionStyleDestructive
                           handler:^(__kindof QMUIAlertController *_Nonnull aAlertController,
                                     QMUIAlertAction *_Nonnull action) { chooseBlock(1); }];
  [alertCon addAction:yesAction];
  [alertCon addAction:noAction];
  [alertCon showWithAnimated:YES];
}
@end
