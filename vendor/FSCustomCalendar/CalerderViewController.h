//
//  CalerderViewController.h
//  FSCalendar
//
//  Created by zjc on 2020/2/26.
//  Copyright © 2020年 zjc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum { FullScreen, HalfScreen } PushType;
typedef void (^calendarBlock)(NSString *startTime, NSDate *startDate, NSString *endTime,
                              NSDate *endDate);
@interface CalerderViewController : UIViewController
@property (nonatomic, strong) NSDate *startDate; //住宿时间
@property (nonatomic, strong) NSDate *endDate;   //退宿时间
@property (nonatomic, assign) BOOL isEnd; // YES表示下次点击为endDate,否则为startDate
@property (nonatomic, copy) calendarBlock selectedCalendarBlock;
//导航条的背景色
@property (nonatomic, strong) UIColor *navigationBarTintColor;
//导航条文字的背景色
@property (nonatomic, strong) UIColor *navigationTintColor;
@property(nonatomic, assign) PushType type;
@end

NS_ASSUME_NONNULL_END
