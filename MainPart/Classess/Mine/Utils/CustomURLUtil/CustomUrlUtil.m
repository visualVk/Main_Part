//
//  CustomUrlUtil.m
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CustomUrlUtil.h"

@implementation CustomUrlUtil
+ (NSDictionary *)getUrlParam:(NSString *)urlStr {
  NSString *utf8Str =
  [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
                                                              URLQueryAllowedCharacterSet]];
  NSURL *url = [NSURL URLWithString:utf8Str];
  NSURLComponents *urlComponents =
  [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
  NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
  for (NSURLQueryItem *item in urlComponents.queryItems) {
    [parameter setValue:item.value forKey:item.name];
  }
  return parameter;
}
@end
