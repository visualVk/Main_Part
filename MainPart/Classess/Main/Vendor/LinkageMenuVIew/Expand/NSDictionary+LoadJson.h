//
//  NSDictionary+LoadJson.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LoadJson)

+ (NSDictionary *)readLocalFileWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
