//=============================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights
// Reserved. EasyAR is the registered trademark or trademark of VisionStar Information Technology
// (Shanghai) Co., Ltd in China and other countries for the augmented reality technology developed
// by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================

#import "helloar.h"

#import "AppDelegate.h"
#import "BGRenderer.h"
#import "BoxRenderer.h"
#import <easyar/buffer.oc.h>
#import <easyar/callbackscheduler.oc.h>
#import <easyar/camera.oc.h>
#import <easyar/cameraparameters.oc.h>
#import <easyar/cloud.oc.h>
#import <easyar/dataflow.oc.h>
#import <easyar/frame.oc.h>
#import <easyar/image.oc.h>
#import <easyar/imagetarget.oc.h>
#import <easyar/imagetracker.oc.h>
#import <easyar/types.oc.h>

#include <OpenGLES/ES2/gl.h>

extern NSString *cloudRecognitionServiceServerAddress;
extern NSString *apiKey;
extern NSString *apiSecret;
extern NSString *cloudRecognitionServiceAppId;

easyar_DelayedCallbackScheduler *scheduler;
easyar_CameraDevice *camera;
NSMutableArray<easyar_ImageTracker *> *trackers;
BGRenderer *bgRenderer;
BoxRenderer *boxRenderer;
easyar_CloudRecognizer *cloud_recognizer;
NSMutableSet<NSString *> *uids;

easyar_InputFrameThrottler *throttler;
easyar_FeedbackFrameFork *feedBackFrameFork;
easyar_InputFrameToOutputFrameAdapter *i2OAdapter;
easyar_InputFrameFork *inputFrameFork;
easyar_OutputFrameJoin *join;
easyar_OutputFrameBuffer *outputFrameBuffer;
easyar_InputFrameToFeedbackFrameAdapter *i2FAdapter;
easyar_OutputFrameFork *outputFrameFork;
int previousInputFrameIndex = -1;
BOOL isFirst;
void createScheduler() {
  scheduler = [easyar_DelayedCallbackScheduler create];
}
easyar_DelayedCallbackScheduler *getScheduler() {
  return scheduler;
}

void recreate_context() {
  bgRenderer = nil;
  boxRenderer = nil;
  previousInputFrameIndex = -1;
  bgRenderer = [BGRenderer create];
  boxRenderer = [BoxRenderer create];
}

void initialize() {
  recreate_context();
  
  throttler = [easyar_InputFrameThrottler create];
  inputFrameFork = [easyar_InputFrameFork create:3];
  outputFrameBuffer = [easyar_OutputFrameBuffer create];
  i2OAdapter = [easyar_InputFrameToOutputFrameAdapter create];
  i2FAdapter = [easyar_InputFrameToFeedbackFrameAdapter create];
  outputFrameFork = [easyar_OutputFrameFork create:2];
  
  camera = [easyar_CameraDeviceSelector
            createCameraDevice:easyar_CameraDevicePreference_PreferObjectSensing];
  if (![camera openWithPreferredType:easyar_CameraDeviceType_Back]) { return; }
  [camera setFocusMode:easyar_CameraDeviceFocusMode_Continousauto];
  [camera setSize:[easyar_Vec2I create:@[ @1280, @960 ]]];
  
  uids = [[NSMutableSet<NSString *> alloc] init];
  cloud_recognizer = [easyar_CloudRecognizer
                      create:cloudRecognitionServiceServerAddress
                      apiKey:apiKey
                      apiSecret:apiSecret
                      cloudRecognitionServiceAppId:cloudRecognitionServiceAppId
                      callbackScheduler:scheduler
                      callback:^(easyar_CloudStatus status, NSArray<easyar_Target *> *targets) {
    if (status == easyar_CloudStatus_FoundTargets) {
      NSLog(@"CloudRecognizerCallBack: FoundTargets");
    } else if (status == easyar_CloudStatus_Reconnecting) {
      NSLog(@"CloudRecognizerCallBack: Reconnecting");
    } else if (status == easyar_CloudStatus_TargetsNotFound) {
      NSLog(@"CloudRecognizerCallBack: TargetsNotFound");
    } else if (status == easyar_CloudStatus_ProtocolError) {
      NSLog(@"CloudRecognizerCallBack: ProtocolError");
      NSLog(@"Invalid cloud key or cloud secret");
    } else {
      NSLog(@"CloudRecognizerCallBack: %ld", (long)status);
    }
    @synchronized(uids) {
      for (easyar_Target *t in targets) {
        if (![uids containsObject:[t uid]]) {
          NSLog(@"add cloud target: %@", [t uid]);
          [uids addObject:[t uid]];
          [[trackers objectAtIndex:0]
           loadTarget:t
           callbackScheduler:scheduler
           callback:^(easyar_Target *target, bool status) {
            NSLog(@"load target (%@): %@ (%d)",
                  status ? @"true" : @"false", [target name],
                  [target runtimeID]);
          }];
        }
      }
    }
  }];
  
  easyar_ImageTracker *tracker = [easyar_ImageTracker create];
  trackers = [[NSMutableArray<easyar_ImageTracker *> alloc] init];
  [trackers addObject:tracker];
  
  feedBackFrameFork = [easyar_FeedbackFrameFork create:(int)[trackers count]];
  join = [easyar_OutputFrameJoin create:(int)(trackers.count + 1)];
  [[camera inputFrameSource] connect:[throttler input]];
  [[throttler output] connect:[inputFrameFork input]];
  [[inputFrameFork output:0] connect:[i2OAdapter input]];
  [[i2OAdapter output] connect:[join input:0]];
  
  [[inputFrameFork output:1] connect:[cloud_recognizer inputFrameSink]];
  
  [[inputFrameFork output:2] connect:[i2FAdapter input]];
  [[i2FAdapter output] connect:[feedBackFrameFork input]];
  int trackerBufferRequirement = 0;
  for (int i = 0; i < trackers.count; i++) {
    [[feedBackFrameFork output:i] connect:trackers[i].feedbackFrameSink];
    [[trackers[i] outputFrameSource] connect:[join input:i + 1]];
    trackerBufferRequirement += [trackers[i] bufferRequirement];
  }
  
  [[join output] connect:[outputFrameFork input]];
  [[outputFrameFork output:0] connect:[outputFrameBuffer input]];
  [[outputFrameFork output:1] connect:[i2FAdapter sideInput]];
  [[outputFrameBuffer signalOutput] connect:[throttler signalInput]];
  
  // CameraDevice and rendering each require an additional buffer
  [camera setBufferCapacity:[throttler bufferRequirement] + [i2FAdapter bufferRequirement] +
   [outputFrameBuffer bufferRequirement] +
   [cloud_recognizer bufferRequirement] + trackerBufferRequirement + 2];
}

void finalize() {
  [trackers removeAllObjects];
  cloud_recognizer = nil;
  bgRenderer = nil;
  boxRenderer = nil;
  camera = nil;
  throttler = nil;
  inputFrameFork = nil;
  outputFrameBuffer = nil;
  i2OAdapter = nil;
  i2FAdapter = nil;
  outputFrameFork = nil;
  scheduler = nil;
}

BOOL start() {
  BOOL status = YES;
  if (camera != nil) {
    status &= [camera start];
  } else {
    status = NO;
  }
  if (cloud_recognizer != nil) { status &= [cloud_recognizer start]; }
  for (easyar_ImageTracker *tracker in trackers) { status &= [tracker start]; }
  return status;
}

void stop() {
  for (easyar_ImageTracker *tracker in trackers) { [tracker stop]; }
  if (cloud_recognizer != nil) { [cloud_recognizer stop]; }
  if (camera != nil) { [camera stop]; }
}

BOOL render(int width, int height, int screenRotation) {
  while ([scheduler runOne]) {}
  
  glViewport(0, 0, width, height);
  glClearColor(0.f, 0.f, 0.f, 1.f);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  
  easyar_OutputFrame *oFrame = [outputFrameBuffer peek];
  if (oFrame == nil) { return false; }
  easyar_InputFrame *iFrame = [oFrame inputFrame];
  if (iFrame == nil) { return false; }
  if (![iFrame hasCameraParameters]) { return false; }
  easyar_CameraParameters *cameraParameters = [iFrame cameraParameters];
  float viewport_aspect_ratio = (float)width / (float)height;
  easyar_Matrix44F *projection = [cameraParameters projection:0.01f
                                                     farPlane:1000.f
                                          viewportAspectRatio:viewport_aspect_ratio
                                               screenRotation:screenRotation
                                                combiningFlip:true
                                         manualHorizontalFlip:false];
  easyar_Matrix44F *imageProjection = [cameraParameters imageProjection:viewport_aspect_ratio
                                                         screenRotation:screenRotation
                                                          combiningFlip:true
                                                   manualHorizontalFlip:false];
  easyar_Image *image = [iFrame image];
  
  if ([iFrame index] != previousInputFrameIndex) {
    [bgRenderer upload:[image format]
                 width:[image width]
                height:[image height]
            bufferData:[[image buffer] data]];
    previousInputFrameIndex = [iFrame index];
  }
  [bgRenderer render:imageProjection];
  
  NSArray<easyar_FrameFilterResult *> *results = [oFrame results];
  for (int i = 0; i < [results count]; i++) {
    easyar_ImageTrackerResult *result = nil;
    easyar_FrameFilterResult *_result = results[i];
    result = ([_result isEqual:[NSNull null]]) ? nil : (easyar_ImageTrackerResult *)_result;
    if (result != nil) {
      for (easyar_TargetInstance *targetInstance in [result targetInstances]) {
        easyar_TargetStatus status = [targetInstance status];
        if (status == easyar_TargetStatus_Tracked) { return true; }
      }
    }
  }
  return false;
}
