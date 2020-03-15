//
//  CustomUrlUtil.h
//  MainPart
//
//  Created by blacksky on 2020/3/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomUrlUtil : NSObject
+ (NSDictionary *)getUrlParam:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
