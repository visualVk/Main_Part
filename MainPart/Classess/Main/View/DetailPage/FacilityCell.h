//
//  FacilityCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "YXFlipCell.h"

typedef enum : NSUInteger {
  SINGLEINLINE,
  MULTINLINE,
} FacilityCellType;

@interface FacilityCell : YXFlipCell

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) FacilityCellType type;
+ (FacilityCell *)testCellWithTableView:(UITableView *)tableView
                           facilityType:(FacilityCellType)type;
+ (CGFloat)cellCloseH;
+ (CGFloat)cellOpenH;
+ (CGFloat)foldNum;
- (void)setBGColor;
- (void)loadData;
@end
