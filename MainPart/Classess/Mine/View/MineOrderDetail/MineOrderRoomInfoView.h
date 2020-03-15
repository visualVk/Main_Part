//
//  MineOrderRoomInfoView.h
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCheckInfo.h"
@interface MineOrderRoomInfoView : UICollectionViewCell
@property (nonatomic, strong) UILabel *roomName;
@property (nonatomic, strong) UILabel *roomStatus;
@property (nonatomic, strong) UILabel *room;
@property (nonatomic, strong) UILabel *liveDuration;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *qrCodeImage;
@property (nonatomic, strong) UIImageView *switchPage;
@property (nonatomic, strong) UILabel *roomCombo;
@property(nonatomic, strong) OrderCheckInfo *model;
@property(nonatomic, assign) NSInteger modelIndex;

- (void)resetStatus;
@end
