//
//  CityController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
typedef void (^CityBlock)(NSString *cityName);
@interface CityController : QMUICommonViewController
@property (nonatomic, strong) CityBlock cityBlock;
@end
