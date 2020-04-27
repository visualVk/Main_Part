//
//  SpotCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface SpotCell : QMUITableViewCell
@property (nonatomic, strong) NSArray *datas;
- (void)reloadData:(NSDictionary *)dict;
@end
