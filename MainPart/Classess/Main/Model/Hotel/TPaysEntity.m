//
//  TPaysEntity.m
//  MainPart
//
//  Created by blacksky on 2020/5/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TPaysEntity.h"

@implementation TPaysEntity
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{ @"idField" : @"id" };
}
@end
