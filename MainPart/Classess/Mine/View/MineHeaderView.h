//
//  MineHeaderView.h
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIImageView *imgBackground;
- (void)loadData;
@end
