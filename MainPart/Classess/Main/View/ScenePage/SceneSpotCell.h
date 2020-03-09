//
//  SceneSpotCell.h
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface SceneSpotCell : QMUITableViewCell
@property(nonatomic, strong) UIImageView *sceneImg;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *score;
@property(nonatomic, strong) QMUILabel *special;
@property(nonatomic, strong) QMUILabel *stars;
@end
