//
//  MineAvatarPickerController.h
//  MainPart
//
//  Created by blacksky on 2020/3/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QMUICommonViewController.h"

@protocol MineAvatraPickerDelegate <NSObject>

- (void)installAvatar:(UIImage *)avatar;

@end

@interface MineAvatarPickerController : QMUICommonViewController
@property (nonatomic, strong) QMUICommonViewController *parentController;
@property (nonatomic, weak) id<MineAvatraPickerDelegate> delegate;
- (void)authorizationPresentAlbumViewControllerWithTitle:(NSString *)title;
@end
