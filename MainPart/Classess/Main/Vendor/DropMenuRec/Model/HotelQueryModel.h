//
//  HotelQueryModel.h
//  DropMenuRe
//
//  Created by blacksky on 2020/3/11.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
  OrderByComposite,
  OrderByPriceAsc,
  OrderByPriceDesc,
  OrderByDistanceAsc,
  OrderByDistanceDesc,
  OrderByGradeAsc,
  OrderByGradeDesc
} HotelQueryOrder;
@interface HotelQueryModel : NSObject
@property (nonatomic, assign) CGFloat lowPrice;
@property (nonatomic, assign) CGFloat highPrice;
@property (nonatomic, strong) NSMutableArray *hotelRankList;
@property (nonatomic, assign) HotelQueryOrder hotelQueryOrder;
@property (nonatomic, strong) NSString *hotelDistance;
@property (nonatomic, assign) NSInteger hotelComment;
@property (nonatomic, strong) NSMutableArray *brandList;
@property (nonatomic, strong) NSMutableArray *roomComboList;
@property (nonatomic, strong) NSMutableArray *discountList;
@end

NS_ASSUME_NONNULL_END
