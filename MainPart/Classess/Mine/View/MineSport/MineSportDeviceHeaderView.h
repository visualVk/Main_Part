//
//  MineSportDeviceHeaderView.h
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelDevice.h"
#import <UIKit/UIKit.h>

@protocol MineSportHeaderDelegate <NSObject>

- (void)zoomView:(UIView *)view;

@end

@interface MineSportDeviceHeaderView : UICollectionReusableView
@property (nonatomic, strong) HotelDevice *model;
@property (nonatomic, strong) UIImageView *sportImg;
@property (nonatomic, weak) id<MineSportHeaderDelegate> delegate;

@end
