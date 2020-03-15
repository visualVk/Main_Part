//
//  PopListSectionView.h
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PopListClearBlock)(void);
@interface PopListSectionView : UIView
@property (nonatomic, strong) UILabel *popListTitle;
@property (nonatomic, strong) UILabel *popListClear;
@property (nonatomic, strong) PopListClearBlock popListClearBlock;
@end
