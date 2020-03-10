//=============================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
// EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
// and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================

#import <GLKit/GLKView.h>

@interface OpenGLView : GLKView

- (void)initialize;
- (void)start;
- (void)stop;
- (void)setOrientation:(UIInterfaceOrientation)orientation;

@property int screenRotation;

@end
