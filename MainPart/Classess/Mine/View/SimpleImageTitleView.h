//
//  SimpleImageTitleView.h
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleImageTitleView : UIView<GenerateEntityDelegate>
@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, strong) UILabel *title;
@end
