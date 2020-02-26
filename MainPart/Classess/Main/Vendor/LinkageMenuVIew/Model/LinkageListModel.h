//
//  LinkageListModel.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LinkageListModel : NSObject
@property(nonatomic, strong) NSArray<LinkageModel*> *linkList;
@end

NS_ASSUME_NONNULL_END
