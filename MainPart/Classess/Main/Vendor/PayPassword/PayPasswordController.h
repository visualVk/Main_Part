//
//  PayPasswordController.h
//  PayPassword
//
//  Created by blacksky on 2020/3/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"

@protocol PayPasswordDelegate <NSObject>

- (void)didFinishInput:(NSString *)password;

- (void)closePayPassword;

@end

typedef void (^PasswordDidChangeBlock)(NSString *password);
@interface PayPasswordController : QMUICommonViewController
@property (nonatomic, weak) NSString *price;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITextField *pswTextField;
@property (nonatomic, strong) NSMutableArray *dotArr;
@property (nonatomic, strong) UIImageView *closeImage;
@property (nonatomic, strong) UILabel *hintTitle;
@property (nonatomic, strong) UILabel *payMoney;
@property (nonatomic, strong) PasswordDidChangeBlock passwordDidChangeBlock;
@property (nonatomic, weak) id<PayPasswordDelegate> payDelegate;

- (void)finishPay;
@end
