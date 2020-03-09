//
//  SelectCircleVIew.h
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCircleVIew : UIView
@property (nonatomic, strong) UIView *outer;
@property (nonatomic, strong) UIView *inner;
- (void)selectCheckBox:(BOOL)selected;
@end
