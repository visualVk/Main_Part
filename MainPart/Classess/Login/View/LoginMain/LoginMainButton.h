//
//  LoginMainButton.h
//  LoginPart
//
//  Created by blacksky on 2020/4/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginMainButtonDelegate <NSObject>

- (void)tap:(UIView *)view;

@end

@interface LoginMainButton : UIView
@property (nonatomic, strong, readonly) UIView *container;
@property (nonatomic, strong, readonly) UIImageView *pic;
@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, weak) id<LoginMainButtonDelegate> delegate;
@end
