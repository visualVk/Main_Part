//
//  MineOrderHotelView.h
//  MainPart
//
//  Created by blacksky on 2020/3/6.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineOrderHotelView : UICollectionViewCell
@property (nonatomic, assign) NSInteger hotelId;
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) QMUIButton *goHotelBtn;
@property (nonatomic, strong) UILabel *hotelAddress;
@property (nonatomic, strong) UIImageView *locateImage;
@end
