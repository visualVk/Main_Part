//
//  PopListController.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Food.h"
#import "QMUICommonViewController.h"

@protocol PopListDelegate <NSObject>

- (void)foodNumberValueChanged:(NSInteger)currentNumber;

@end

@interface PopListController : QMUICommonViewController
@property (nonatomic, strong) NSMutableArray *foodList;
@property (nonatomic, weak) id<PopListDelegate> delegate;
@property(nonatomic, strong) UIView *bottomView;

-(void)showPopListView;
-(void)hidePopListView;
@end
