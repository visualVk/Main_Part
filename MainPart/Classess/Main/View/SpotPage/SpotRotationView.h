//
//  SpotRotationView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/18.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotRotationView : UICollectionViewCell
@property(nonatomic, strong) NSArray *datas;
-(void)loadData;
-(void)stateInit;
@end
