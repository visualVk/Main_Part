//
//  MineOrderDetailDeleteToolBar.h
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AllSelectBlock)(BOOL on);
typedef void (^DeleteBlock)(void);
@interface MineOrderDetailDeleteToolBar : UIView
@property (nonatomic, strong) AllSelectBlock allSelectBlock;
@property (nonatomic, strong) DeleteBlock deleteBlock;
@end
