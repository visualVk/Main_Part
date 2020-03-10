//=============================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
// EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
// and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================

#import <Foundation/Foundation.h>
#import <easyar/callbackscheduler.oc.h>

void createScheduler();
easyar_DelayedCallbackScheduler * getScheduler();
void recreate_context();
void initialize();
void finalize();
BOOL start();
void stop();
BOOL render(int width, int height, int screenRotation);
