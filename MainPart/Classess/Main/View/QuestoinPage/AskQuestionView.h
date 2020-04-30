//
//  AskQuestionView.h
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskQuestionView : UIView
@property (nonatomic, strong, readonly) QMUITextView *textview;

@property (nonatomic, strong, readonly) QMUIButton *submitBtn;
@end
