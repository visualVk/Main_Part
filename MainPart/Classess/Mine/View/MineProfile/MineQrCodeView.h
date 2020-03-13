//
//  MineQrCodeView.h
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineQrCodeView : UIView
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UILabel *locate;
@property (nonatomic, strong) UIImageView *qrCodeImg;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *refreshLB;
@property (nonatomic, strong) NSString *qrString;
@end
