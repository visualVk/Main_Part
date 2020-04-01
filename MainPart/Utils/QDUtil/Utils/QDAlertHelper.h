//
//  QDAlertHelper.h
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QMUIAlertController.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^ChooseBlock)(NSInteger selectedIndex);
@interface QDAlertHelper : NSObject
+ (void)showChooseAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                  preferredStyle:(QMUIAlertControllerStyle)preferredStyle
                      chooseList:(NSArray<NSString *> *)chooseList
                     chooseBlock:(_Nullable ChooseBlock)chooseBlock;
@end

NS_ASSUME_NONNULL_END
