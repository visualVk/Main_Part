//
//  LinkageModel.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkageModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<NSString *> *imageList;
@property (nonatomic, strong) NSArray<NSString *> *hintList;
@property (nonatomic, strong) NSArray<NSString *> *labelList;
@end

NS_ASSUME_NONNULL_END
