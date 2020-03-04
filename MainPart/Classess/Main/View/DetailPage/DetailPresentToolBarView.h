//
//  DetailPresentToolBarView.h
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(void);
@interface DetailPresentToolBarView : UIView
@property (nonatomic, strong) UILabel *asksSupplier;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *buyImage;
@property (nonatomic, strong) NSDictionary *infoDict;
@property (nonatomic, strong) ClickBlock clickBlock;
- (void)loadData:(NSDictionary *)infoDict;
@end
