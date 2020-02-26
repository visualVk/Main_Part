//
//  LinkageListModel.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageListModel.h"
@implementation LinkageListModel
+ (NSDictionary *)mj_objectClassInArray {
  return @{ @"linkList" : [LinkageModel class] };
}
@end
