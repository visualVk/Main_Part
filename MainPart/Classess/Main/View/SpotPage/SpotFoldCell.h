//
//  SpotFoldCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/18.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXFlipCell.h"

static CGFloat cellCloseH = 180;  // cell折叠之后的高度
static CGFloat cellOpenH = 440;   // cell展开后的高度
static NSInteger foldNum = 3;     //折叠次数

@interface SpotFoldCell : YXFlipCell

@property (nonatomic, assign) NSInteger number;

+ (SpotFoldCell *)testCellWithTableView:(UITableView *)tableView;
+ (CGFloat)cellCloseH;
+ (CGFloat)cellOpenH;
+ (CGFloat)foldNum;
- (void)setBGColor;

@end
