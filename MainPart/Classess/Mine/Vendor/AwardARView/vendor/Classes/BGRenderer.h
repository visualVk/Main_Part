//================================================================================================================================
//
// Copyright (c) 2015-2019 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
// EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
// and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//================================================================================================================================

#import <easyar/matrix.oc.h>
#import <easyar/image.oc.h>

// all methods of this class can only be called on one thread with the same OpenGLES
@interface BGRenderer : NSObject

+ (instancetype)create;

- (void)upload:(easyar_PixelFormat)format width:(int)width height:(int)height bufferData:(void *)bufferData;
- (void)render:(easyar_Matrix44F *)imageProjection;

@end
