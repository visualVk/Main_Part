//
//  BannerZoomView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>
#import <UIKit/UIKit.h>

@protocol BannerZoomDelegate <NSObject>

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView location:(CGPoint)location;
- (void)presentZoomView:(UIViewController *)subViewController;
@end

@interface BannerZoomView : UIView
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) id<BannerZoomDelegate> self_delegate;
- (void)loadData;
@end
