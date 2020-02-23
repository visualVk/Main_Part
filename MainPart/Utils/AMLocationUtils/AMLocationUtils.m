//
//  AMLocationUtils.m
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AMLocationUtils.h"
#define AMUtil [AMLocationUtils sharedInstance]
#define AMLOCATIONAPPID @"b794a47f8cc58d7845b3b16566172528"
@interface AMLocationUtils () <AMapLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate> {
  AMapLocationReGeocode *code;
}
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong, readwrite) AMapLocationReGeocode *reGeocode;
@property (nonatomic, strong) MAMapView *map;
@end

@implementation AMLocationUtils
static AMLocationUtils *instance = nil;
+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ instance = [[AMLocationUtils alloc] init]; });
  return instance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [AMapServices sharedServices].apiKey = AMLOCATIONAPPID;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 200;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
  }
  return self;
}

- (void)amapLocationManager:(AMapLocationManager *)manager
          didUpdateLocation:(CLLocation *)location
                  reGeocode:(AMapLocationReGeocode *)reGeocode {
  NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude,
        location.coordinate.longitude, location.horizontalAccuracy);
  if (reGeocode) {
    self.reGeocode = reGeocode;
    if (self.GeoCode) { self.GeoCode(reGeocode); }
    NSLog(@"reGeocode:%@", reGeocode);
  }
}

+ (void)startReGeo {
  AMUtil.locationManager.locatingWithReGeocode = YES;
  [AMUtil.locationManager startUpdatingLocation];
}

+ (void)stopReGeo {
  [AMUtil.locationManager stopUpdatingLocation];
}

+ (MAMapView *)mapView:(CGRect)frame {
  if (!AMUtil.map) { AMUtil.map = [[MAMapView alloc] initWithFrame:frame]; }
  return AMUtil.map;
}

- (void)amapLocationManager:(AMapLocationManager *)manager
      doRequireLocationAuth:(CLLocationManager *)locationManager {
  [locationManager requestWhenInUseAuthorization];
}
@end
