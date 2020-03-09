//
//  MineOrderCheckPersonInfoView.h
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineOrderCollaspeDelegate <NSObject>

- (void)collaspView:(UIView *)clickView;

@end

@interface MineOrderCheckPersonInfoView : UICollectionReusableView
@property (nonatomic, strong) QMUILabel *checkTitle;
@property (nonatomic, strong) UILabel *checkPersonName;
@property (nonatomic, strong) UILabel *checkPersonIdCard;
@property (nonatomic, strong) UIImageView *nameImage;
@property (nonatomic, strong) UIImageView *collapseImage;
@property (nonatomic, weak) id<MineOrderCollaspeDelegate> delegate;
@end
