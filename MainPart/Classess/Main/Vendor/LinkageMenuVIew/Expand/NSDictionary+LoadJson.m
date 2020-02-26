//
//  NSDictionary+LoadJson.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "NSDictionary+LoadJson.h"


@implementation NSDictionary (LoadJson)
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
  NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
  NSData *data = [[NSData alloc] initWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end
