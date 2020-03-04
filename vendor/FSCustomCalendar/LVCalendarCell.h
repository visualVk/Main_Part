//
//  LVCalendarCell.h
//  CalendarTest
//
//  Created by 吕亚斌 on 2018/4/8.
//  Copyright © 2018年 吕亚斌. All rights reserved.
//

#import "FSCalendarCell.h"

@interface LVCalendarCell : FSCalendarCell

enum SelectionType  {
    none = 1,
    single = 1<<1,
    leftBorder = 1<<2,
    middle = 1<<3,
    rightBorder = 1<<4,
};

//weak var selectionLayer: CALayer!
//weak var middleLayer: CALayer!
@property (nonatomic, weak) CALayer *selectionLayer;
@property (nonatomic, weak) CALayer *middleLayer;
@property (nonatomic, assign) enum SelectionType selectionType;
@end
