//
//  RecToolBar.h
//  MainPart
//
//  Created by blacksky on 2020/3/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ToolBarClickBlock)(NSInteger);
@interface RecToolBar : UIView
@property (nonatomic, strong, readonly) QMUIButton *favorBtn;
@property (nonatomic, strong) ToolBarClickBlock detailBlock;
@property (nonatomic, strong) ToolBarClickBlock discountBlock;
@property (nonatomic, strong) ToolBarClickBlock favorBlock;
- (void)changeColorWithSelected:(BOOL)selected;
@end
