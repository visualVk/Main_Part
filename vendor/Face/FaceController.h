//
//  FaceController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
typedef enum { RegisterFace, RegcognizeFace } FaceType;
@interface FaceController : QMUICommonViewController
- (instancetype)initWithFaceType:(FaceType)type;
@end
