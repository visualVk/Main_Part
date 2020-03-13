//
//  LevelSectionHeaderView.h
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HWWaveView.h"
#import <UIKit/UIKit.h>
//#import <ZZCircleProgress.h>

@interface LevelSectionHeaderView : UIView
//@property (nonatomic, strong) ZZCircleProgress *levelView;
@property (nonatomic, strong) HWWaveView *waveView;
-(void)hideAllCircleView;
-(void)showAllCircleView;
@end
