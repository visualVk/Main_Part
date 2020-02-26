//
//  LinkageMenuProtocol.h
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LinkageMenuProtocol <NSObject>
-(NSInteger)rightTopAndBottomTotolNum:(NSInteger)section;
-(NSInteger)rightNumberOfSections;
-(NSInteger)leftTotal:(NSInteger)section;
-(NSString*)loadLeftTitle;
@end

NS_ASSUME_NONNULL_END
