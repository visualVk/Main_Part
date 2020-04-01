//
//  RemarkScoreView.h
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkScoreView : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, strong) NSString *scoreGrade;
@end
