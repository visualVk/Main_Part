//
//  SceneHeaderView.h
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <SDCycleScrollView.h>
#import <UIKit/UIKit.h>

@interface SceneDetailHeaderView : UIView
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) QMUILabel *remarkOne;
@property (nonatomic, strong) QMUILabel *remarkTwo;
@property(nonatomic, strong) NSArray *datas;
@end
