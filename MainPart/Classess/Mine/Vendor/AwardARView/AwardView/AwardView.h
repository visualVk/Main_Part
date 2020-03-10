//
//  AwardView.h
//  AwardView
//
//  Created by blacksky on 2020/3/8.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CloseClickBlock)(void);
@interface AwardView : UIView
@property (nonatomic, strong) CloseClickBlock closeClickBlock;
- (void)showView;
- (void)hideView;

@end
