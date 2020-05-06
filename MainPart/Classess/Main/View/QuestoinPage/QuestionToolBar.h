//
//  QuestionToolBar.h
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^QuestionClick)(void);
@interface QuestionToolBar : UIView
@property (nonatomic, strong, readonly) QMUIButton *questionBtn;
@property (nonatomic, strong) QuestionClick questionBlock;
@end
