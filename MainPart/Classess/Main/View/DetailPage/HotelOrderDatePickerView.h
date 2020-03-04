//
//  HotelOrderDatePickerView.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelOrderDatePickerView : UIView
@property (nonatomic, strong) QMUILabel *stDate;
@property (nonatomic, strong) QMUILabel *edDate;
@property (nonatomic, strong) QMUILabel *days;
@property (nonatomic, strong) UILabel *configuration;
-(void)loadData:(NSDictionary*)infoDict;
@end
