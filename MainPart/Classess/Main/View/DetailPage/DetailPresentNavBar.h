//
//  DetailPresentNavBar.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPresentNavBar : UIView
@property(nonatomic, strong) UILabel *title;
-(void)didScrollView:(CGPoint)offset;
@end
