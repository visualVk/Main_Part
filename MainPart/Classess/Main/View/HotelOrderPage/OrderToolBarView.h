//
//  OrderToolBarView.h
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PopOrderDetail)(void);
typedef void (^PushPay)(void);
@interface OrderToolBarView : UIView
@property (nonatomic, strong) UIImageView *askSupplier;
@property (nonatomic, strong) UILabel *askSupplierTitle;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) QMUIButton *subBtn;
@property (nonatomic, strong) UILabel *consumeDetail;
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) PopOrderDetail popOrderDetail;
@property (nonatomic, strong) PushPay pushPay;
@end
