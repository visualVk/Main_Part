//
//  RepertoireCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Log.h"
#import "QMUITableViewCell.h"
@interface RepertoireCell : QMUITableViewCell
@property (nonatomic, strong) UILabel *log;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *logDate;
@property (nonatomic, strong) NSArray *datas;
- (void)loadData:(Log *)log;
@end
