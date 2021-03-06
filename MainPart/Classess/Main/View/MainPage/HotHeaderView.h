//
//  HotHeaderView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotHeaderClickDelegate <NSObject>

- (void)reloadDataWithIndex:(NSInteger)index;

@end

@interface HotHeaderView : UICollectionReusableView
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, weak) id<HotHeaderClickDelegate> delegate;
@end
