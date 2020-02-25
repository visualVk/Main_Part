//
//  DateUtils.m
//  MainPart
//
//  Created by blacksky on 2020/2/24.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils
+(NSString *)secondToHourMinSec:(NSInteger)second{
  NSMutableString *timeStr = [[NSMutableString alloc] initWithCapacity:8];
  NSInteger hour = second / 3600;
  NSInteger min = (second%3600)/60;
  NSInteger sec = second%60;
  if(hour != 0){
    [timeStr appendFormat:@"%li:",hour];
  }
  if(min !=0){
    [timeStr appendFormat:@"%li:",min ];
  }
  [timeStr appendFormat:@"%li",sec];
  return timeStr;
}
@end
