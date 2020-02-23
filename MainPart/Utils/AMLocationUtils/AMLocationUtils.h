//
//  AMLocationUtils.h
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMLocationUtils : NSObject
@property (nonatomic, strong, readonly) AMapLocationReGeocode *reGeoCode;
@property (nonatomic, strong) void (^GeoCode)(AMapLocationReGeocode *reGeoCode);
+ (instancetype)sharedInstance;
+ (void)startReGeo;
+ (void)stopReGeo;
+ (MAMapView*)mapView:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
