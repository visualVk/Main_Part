//
//  QuestionAnsDetailCell.h
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "ReplyEntity.h"

@interface QuestionAnsDetailCell : QMUITableViewCell
@property (nonatomic, strong) ReplyEntity *model;
@end
