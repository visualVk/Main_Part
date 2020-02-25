//
//  MapController.m
//  MainPart
//
//  Created by blacksky on 2020/2/23.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MapController.h"
#import "CommonUtility.h"
#import "DateUtils.h"
#import "MANaviRoute.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <HMSegmentedControl.h>
#import <MAMapKit/MAMapKit.h>
#import <TYAttributedLabel.h>

@interface MapController () <GenerateEntityDelegate, AMapSearchDelegate, MAMapViewDelegate,
UIScrollViewDelegate> {
  CLLocation *startLocation;
  CLLocation *endLocation;
  int curIndex;
  MANaviAnnotationType currtentType;
  CGFloat _viewWidth;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIView *dragView;
@property (nonatomic, strong) UIImageView *touchView;
@property (nonatomic, strong) UIScrollView *wayScrollView;
@property (nonatomic, strong) TYAttributedLabel *walkLabel;
@property (nonatomic, strong) TYAttributedLabel *busLabel;
@property (nonatomic, strong) TYAttributedLabel *carLabel;
@property (nonatomic, strong) TYAttributedLabel *taxiLabel;
@property (nonatomic, strong) HMSegmentedControl *waySegCon;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic) MANaviRoute *naviRoute;
@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, strong) AMapRoute *carRoute;
@property (nonatomic, strong) AMapRoute *busRoute;
@property (nonatomic, strong) QMUIButton *button;

@property (nonatomic) NSInteger currentCourse;
@property (nonatomic) NSInteger carCurrentCourse;
@property (nonatomic) NSInteger busCurrentCourse;

@property (nonatomic) NSInteger totalCourse;
@property (nonatomic) NSInteger carTotalCourse;
@property (nonatomic) NSInteger busTotalCourse;

@end

@implementation MapController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  currtentType = MANaviAnnotationTypeWalking;
  _viewWidth = DEVICE_WIDTH;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  [self searchAimInfo:@"xxx" aimType:@"sss"];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"<##>";
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self.dragView, self.touchView);
  //  addView(self.dragView, self.button);
  addView(self.dragView, self.waySegCon);
  addView(self.dragView, self.wayScrollView);
  
  [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.height.mas_equalTo(500);
  }];
  
  [self.dragView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.mapView.mas_bottom);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    make.right.left.equalTo(self.mapView);
  }];
  
  [self.touchView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.right.left.equalTo(self.dragView);
    //    make.height.mas_equalTo(20);
  }];
  
  [self.waySegCon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.dragView);
    make.top.equalTo(self.touchView.mas_bottom);
    make.height.mas_equalTo(40);
  }];
  
  [self.wayScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.dragView);
    make.top.equalTo(self.waySegCon.mas_bottom);
    make.height.mas_equalTo(DEVICE_HEIGHT * 2 / 3);
    //        make.width.mas_equalTo(DEVICE_WIDTH * 3);
  }];
  
  [self.wayScrollView layoutIfNeeded];
  self.wayScrollView.contentSize = CGSizeMake(_viewWidth * 4, self.wayScrollView.frame.size.height);
}
#pragma mark - Search Aim address
- (void)searchAimInfo:(NSString *)aimAddress aimType:(NSString *)aimType {
  AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
  geo.address = @"温州市瓯海区温州大道东建大厦";
  [self.search AMapGeocodeSearch:geo];
}

#pragma mark - Search Way
- (void)searchWay:(CLLocation *)startDes endDes:(CLLocation *)endDes {
  AMapWalkingRouteSearchRequest *request = [[AMapWalkingRouteSearchRequest alloc] init];
  request.origin = [AMapGeoPoint locationWithLatitude:startDes.coordinate.latitude
                                            longitude:startDes.coordinate.longitude];
  request.destination = [AMapGeoPoint locationWithLatitude:endDes.coordinate.latitude
                                                 longitude:endDes.coordinate.longitude];
  
  [self.search AMapWalkingRouteSearch:request];
  
  AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
  navi.requireExtension = YES;
  navi.city = @"wenzhou";
  navi.origin = [AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                         longitude:startLocation.coordinate.longitude];
  navi.destination = [AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                              longitude:endLocation.coordinate.longitude];
  [self.search AMapTransitRouteSearch:navi];
  
  AMapDrivingRouteSearchRequest *driveRequest = [[AMapDrivingRouteSearchRequest alloc] init];
  driveRequest.requireExtension = YES;
  driveRequest.strategy = 10;
  driveRequest.origin = [AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                                 longitude:startLocation.coordinate.longitude];
  driveRequest.destination = [AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                                      longitude:endLocation.coordinate.longitude];
  
  [self.search AMapDrivingRouteSearch:driveRequest];
}

#pragma mark - Lazy Init MapView
- (MAMapView *)mapView {
  if (!_mapView) {
    _mapView = [[MAMapView alloc] initWithFrame:CGRectZero];
    _mapView.delegate = self;
    addView(self.view, _mapView);
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
  }
  return _mapView;
}

- (UIView *)dragView {
  if (!_dragView) {
    _dragView = [UIView new];
    _dragView.userInteractionEnabled = YES;
    addView(self.view, _dragView);
  }
  return _dragView;
}

- (UIImageView *)touchView {
  if (!_touchView) {
    _touchView = [UIImageView new];
    _touchView.image = UIImageMake(@"drag_bar");
    _touchView.userInteractionEnabled = YES;
    __weak __typeof(self) weakSelf = self;
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:[self selectorBlock:^(id _Nonnull args) {
      UIPanGestureRecognizer *sender = (UIPanGestureRecognizer *)args;
      if (sender.state == UIGestureRecognizerStateChanged ||
          sender.state == UIGestureRecognizerStateEnded) {
        CGPoint offset = [sender translationInView:weakSelf.touchView];
        CGFloat height = CGRectGetHeight(weakSelf.mapView.frame);
        [UIView transitionWithView:weakSelf.mapView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
          [weakSelf.mapView
           mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height + offset.y);
          }];
        }
                        completion:^(BOOL finished){
          
        }];
        [sender setTranslation:CGPointZero inView:weakSelf.touchView];
      }
    }]];
    drag.maximumNumberOfTouches = 1;
    drag.minimumNumberOfTouches = 1;
    [_touchView addGestureRecognizer:drag];
  }
  return _touchView;
}

- (HMSegmentedControl *)waySegCon {
  if (!_waySegCon) {
    _waySegCon = [HMSegmentedControl new];
    _waySegCon.sectionTitles = @[ @"步行", @"公交", @"驾车", @"打车" ];
    _waySegCon.selectedSegmentIndex = 0;
    _waySegCon.backgroundColor = UIColor.qd_backgroundColor;
    _waySegCon.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.qd_titleTextColor};
    _waySegCon.selectedTitleTextAttributes =
    @{NSForegroundColorAttributeName : UIColor.qd_mainTextColor};
    _waySegCon.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    _waySegCon.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _waySegCon.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _waySegCon.selectionIndicatorHeight = 3.0f;
    _waySegCon.tag = 1;
    __weak __typeof(self) weakSelf = self;
    [_waySegCon setIndexChangeBlock:^(NSInteger index) {
      [weakSelf.wayScrollView
       setContentOffset:CGPointMake(_viewWidth * index, weakSelf.wayScrollView.contentOffset.y)
       animated:YES];
      [weakSelf clear];
      if (index == 0) {
        currtentType = MANaviAnnotationTypeWalking;
        [weakSelf presentCurrentCourse:MANaviAnnotationTypeWalking
                          currentIndex:weakSelf.currentCourse];
      }
      if (index == 1) {
        currtentType = MANaviAnnotationTypeBus;
        [weakSelf presentCurrentCourse:MANaviAnnotationTypeBus
                          currentIndex:weakSelf.busCurrentCourse];
      }
      if (index == 2 || index == 3) {
        currtentType = MANaviAnnotationTypeDrive;
        [weakSelf presentCurrentCourse:MANaviAnnotationTypeDrive
                          currentIndex:weakSelf.carCurrentCourse];
      }
    }];
  }
  return _waySegCon;
}

- (UIScrollView *)wayScrollView {
  if (!_wayScrollView) {
    _wayScrollView = [UIScrollView new];
    _wayScrollView.pagingEnabled = YES;
    _wayScrollView.delegate = self;
    _wayScrollView.showsHorizontalScrollIndicator = NO;
  }
  return _wayScrollView;
}

#pragma mark - Label
- (TYAttributedLabel *)walkLabel {
  if (!_walkLabel) {
    _walkLabel = [[TYAttributedLabel alloc] init];
    _walkLabel.preferredMaxLayoutWidth = DEVICE_WIDTH - 2 * SPACE;
    _walkLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *text = @"路线说明:\n";
    [_walkLabel appendText:text];
    AMapPath *path = self.route.paths[self.currentCourse];
    for (AMapStep *step in path.steps) {
      NSString *title = [NSString stringWithFormat:@"·%@\n", step.instruction];
      [_walkLabel appendText:title];
    }
    //    [_walkLabel appendText:@"xkxkxkxkx"];
  }
  return _walkLabel;
}

- (TYAttributedLabel *)busLabel {
  if (!_busLabel) {
    _busLabel = [[TYAttributedLabel alloc] init];
    _busLabel.preferredMaxLayoutWidth = DEVICE_WIDTH - 2 * SPACE;
    NSString *text = @"路线说明:\n";
    [_busLabel appendText:text];
    AMapTransit *transit = self.busRoute.transits[self.busCurrentCourse];
    NSString *title = nil;
    for (AMapSegment *segment in transit.segments) {
      AMapRailway *railway = segment.railway;
      //      AMapTaxi *taxi = segment.taxi;
      AMapBusLine *busline = [segment.buslines firstObject];
      if (railway.uid) {
        title = railway.name;
      } else if (busline) {
        title = [NSString stringWithFormat:@"·公交车:%@\n%@==>%@\n", busline.name,
                 busline.departureStop.name, busline.arrivalStop.name];
      } else {
        title = @"步行\n";
        [_busLabel appendText:title];
        for (AMapStep *step in segment.walking.steps) {
          [_busLabel appendText:[NSString stringWithFormat:@"·%@", step.instruction]];
        }
        continue;
      }
      [_busLabel appendText:title];
    }
  }
  return _busLabel;
}

- (TYAttributedLabel *)carLabel {
  if (!_carLabel) {
    _carLabel = [[TYAttributedLabel alloc] init];
    _carLabel.preferredMaxLayoutWidth = DEVICE_WIDTH - 2 * SPACE;
    NSString *text = @"路线说明:\n";
    [_carLabel appendText:text];
    AMapPath *path = self.carRoute.paths[self.carCurrentCourse];
    for (AMapStep *step in path.steps) {
      [_carLabel appendText:[NSString stringWithFormat:@"·%@\n", step.instruction]];
    }
  }
  return _carLabel;
}

- (TYAttributedLabel *)taxiLabel {
  if (!_taxiLabel) {
    _taxiLabel = [[TYAttributedLabel alloc] init];
    _taxiLabel.preferredMaxLayoutWidth = DEVICE_WIDTH - 2 * SPACE;
    NSString *text = @"打车说明:\n";
    [_taxiLabel appendText:text];
    for (int i = 0; i < 3; ++i) {
      UIImageView *imageview = [UIImageView new];
      imageview.frame =
      CGRectMake(0, 0, (DEVICE_WIDTH - SPACE - 10) / 3, (DEVICE_WIDTH - SPACE - 10) / 5);
      imageview.image = UIImageMake(@"car");
      imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
      UILabel *label = [UILabel new];
      label.text = @"普通:¥22";
      label.textAlignment = NSTextAlignmentCenter;
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (DEVICE_WIDTH - SPACE - 10) / 3,
                                                              (DEVICE_WIDTH - SPACE - 10) / 3)];
      addView(view, imageview);
      addView(view, label);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageview);
        make.top.equalTo(imageview.mas_bottom);
      }];
      [_taxiLabel appendView:view];
    }
  }
  return _taxiLabel;
}

- (AMapSearchAPI *)search {
  if (!_search) {
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
  }
  return _search;
}

#pragma mark - AMapSearchDelegate
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request
                   response:(AMapGeocodeSearchResponse *)response {
  if (response.geocodes.count == 0) { return; }
  
  //解析response获取地理信息，具体解析见 Demo
  for (AMapGeocode *geocode in response.geocodes) {
    endLocation = [[CLLocation alloc] initWithLatitude:geocode.location.latitude
                                             longitude:geocode.location.longitude];
  }
  [self addDefaultAnnotations];
  [self searchWay:startLocation endDes:endLocation];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView
didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation {
  startLocation = _mapView.userLocation.location;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
  if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
    static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
    
    MAAnnotationView *poiAnnotationView = (MAAnnotationView *)[self.mapView
                                                               dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
    if (poiAnnotationView == nil) {
      poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                       reuseIdentifier:routePlanningCellIdentifier];
    }
    
    poiAnnotationView.canShowCallout = YES;
    poiAnnotationView.image = nil;
    if ([[annotation title] isEqualToString:@"起点"]) {
      poiAnnotationView.image = UIImageMake(@"startpoint");
    } else if ([[annotation title] isEqualToString:@"终点"]) {
      poiAnnotationView.image = UIImageMake(@"endpoint");
    }
    
    return poiAnnotationView;
  }
  
  return nil;
}
#pragma mark - AMAPSearchDelegate
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request
                 response:(AMapRouteSearchResponse *)response {
  if (response.route == nil) { return; }
  if ([request isKindOfClass:AMapDrivingRouteSearchRequest.class]) {
    self.carRoute = response.route;
    //    [self updateTotal];
    self.carTotalCourse = self.carRoute.paths.count;
    self.carCurrentCourse = 0;
    if (response.count > 0) {
      [self presentCurrentCourse:MANaviAnnotationTypeDrive currentIndex:self.carCurrentCourse];
    }
  } else if ([request isKindOfClass:AMapTransitRouteSearchRequest.class]) {
    self.busRoute = response.route;
    self.busTotalCourse = self.busRoute.paths.count;
    self.busCurrentCourse = 0;
    if (response.count > 0) {
      [self presentCurrentCourse:MANaviAnnotationTypeBus currentIndex:self.busCurrentCourse];
    }
  } else {
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    if (response.count > 0) {
      [self presentCurrentCourse:MANaviAnnotationTypeWalking currentIndex:self.currentCourse];
    }
  }
  if (self.carRoute && self.busRoute && self.route) { [self generateLabel]; }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
  NSLog(@"Error: %@", error);
}

- (void)updateTotal {
  self.totalCourse = self.route.paths.count;
}

- (void)presentCurrentCourse:(MANaviAnnotationType)type currentIndex:(NSInteger)currentIndex {
  //  MANaviAnnotationType type = MANaviAnnotationTypeWalking;
  
  if (currtentType == type) {
    if (type == MANaviAnnotationTypeWalking) {
      self.naviRoute = [MANaviRoute
                        naviRouteForPath:self.route.paths[currentIndex]
                        withNaviType:type
                        showTraffic:YES
                        startPoint:[AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                                            longitude:startLocation.coordinate.longitude]
                        endPoint:[AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                                          longitude:endLocation.coordinate.longitude]];
    } else if (type == MANaviAnnotationTypeDrive) {
      self.naviRoute = [MANaviRoute
                        naviRouteForPath:self.carRoute.paths[0]
                        withNaviType:MANaviAnnotationTypeDrive
                        showTraffic:YES
                        startPoint:[AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                                            longitude:startLocation.coordinate.longitude]
                        endPoint:[AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                                          longitude:endLocation.coordinate.longitude]];
    } else if (type == MANaviAnnotationTypeBus) {
      self.naviRoute = [MANaviRoute
                        naviRouteForTransit:self.busRoute.transits[0]
                        startPoint:[AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                                            longitude:startLocation.coordinate.longitude]
                        endPoint:[AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                                          longitude:endLocation.coordinate.longitude]];
    }
    self.naviRoute.walkingColor = UIColor.qmui_randomColor;
    self.naviRoute.routeColor = UIColor.qmui_randomColor;
    self.naviRoute.railwayColor = UIColor.qmui_randomColor;
    [self.naviRoute addToMapView:self.mapView];
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                           animated:YES];
  }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
  if ([overlay isKindOfClass:[LineDashPolyline class]]) {
    MAPolylineRenderer *polylineRenderer =
    [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
    polylineRenderer.lineWidth = 8;
    polylineRenderer.lineDashType = kMALineDashTypeSquare;
    polylineRenderer.strokeColor = [UIColor redColor];
    
    return polylineRenderer;
  }
  if ([overlay isKindOfClass:[MANaviPolyline class]]) {
    MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
    MAPolylineRenderer *polylineRenderer =
    [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
    
    polylineRenderer.lineWidth = 8;
    
    if (naviPolyline.type == MANaviAnnotationTypeWalking) {
      polylineRenderer.strokeColor = self.naviRoute.walkingColor;
      polylineRenderer.strokeColor = UIColor.qmui_randomColor;
    } else if (naviPolyline.type == MANaviAnnotationTypeRailway) {
      polylineRenderer.strokeColor = self.naviRoute.railwayColor;
    } else {
      polylineRenderer.strokeColor = self.naviRoute.routeColor;
    }
    
    return polylineRenderer;
  }
  if ([overlay isKindOfClass:[MAMultiPolyline class]]) {
    MAMultiColoredPolylineRenderer *polylineRenderer =
    [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
    
    polylineRenderer.lineWidth = 10;
    polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
    
    return polylineRenderer;
  }
  
  return nil;
}

- (void)addDefaultAnnotations {
  MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
  startAnnotation.coordinate = startLocation.coordinate;
  startAnnotation.title = @"起点";
  startAnnotation.subtitle =
  [NSString stringWithFormat:@"{%f, %f}", startAnnotation.coordinate.latitude,
   startAnnotation.coordinate.longitude];
  //  self.startAnnotation = startAnnotation;
  
  MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
  destinationAnnotation.coordinate = endLocation.coordinate;
  destinationAnnotation.title = @"终点";
  destinationAnnotation.subtitle =
  [NSString stringWithFormat:@"{%f, %f}", endLocation.coordinate.latitude,
   endLocation.coordinate.longitude];
  //  self.destinationAnnotation = destinationAnnotation;
  
  [self.mapView addAnnotation:startAnnotation];
  [self.mapView addAnnotation:destinationAnnotation];
}

- (void)changeRouteWithType:(MANaviAnnotationType)type
                   mapRoute:(AMapRoute *)mapRoute
               currentIndex:(NSInteger)currentIndex {
  self.naviRoute = [MANaviRoute
                    naviRouteForPath:mapRoute.paths[currentIndex]
                    withNaviType:type
                    showTraffic:YES
                    startPoint:[AMapGeoPoint locationWithLatitude:startLocation.coordinate.latitude
                                                        longitude:endLocation.coordinate.longitude]
                    endPoint:[AMapGeoPoint locationWithLatitude:endLocation.coordinate.latitude
                                                      longitude:endLocation.coordinate.longitude]];
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  CGFloat pageWidth = scrollView.frame.size.width;
  NSInteger page = scrollView.contentOffset.x / pageWidth;
  [UIView animateWithDuration:0.5 animations:^{ self.waySegCon.selectedSegmentIndex = page; }];
}

- (void)generateLabel {
  addView(self.wayScrollView, self.walkLabel);
  addView(self.wayScrollView, self.busLabel);
  addView(self.wayScrollView, self.carLabel);
  addView(self.wayScrollView, self.taxiLabel);
  
  [@[ self.walkLabel, self.busLabel, self.carLabel, self.taxiLabel ]
   mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.wayScrollView).with.inset(0.5 * SPACE);
    make.width.mas_equalTo(DEVICE_WIDTH - SPACE);
    //    make.bottom.equalTo(self.wayScrollView).with.inset(0.5 * SPACE);
  }];
  
  [self.walkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.center.equalTo(self.wayScrollView);
    //    make.width.mas_equalTo(DEVICE_WIDTH - SPACE);
    make.centerX.equalTo(self.wayScrollView);
  }];
  
  [self.busLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.wayScrollView).offset(DEVICE_WIDTH);
    //    make.width.mas_equalTo(DEVICE_WIDTH - SPACE);
  }];
  
  [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.wayScrollView).offset(2 * DEVICE_WIDTH);
    //    make.width.mas_equalTo(DEVICE_WIDTH - SPACE);
  }];
  
  [self.taxiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.wayScrollView).offset(3 * DEVICE_WIDTH);
  }];
}

- (void)clear {
  [self.naviRoute removeFromMapView];
}
@end
