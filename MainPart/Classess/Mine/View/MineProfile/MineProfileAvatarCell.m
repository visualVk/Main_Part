//
//  MineProfileAvatorCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineProfileAvatarCell.h"
#import "MarkUtils.h"

@interface MineProfileAvatarCell () <GenerateEntityDelegate>

@end

@implementation MineProfileAvatarCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.avatarTitle);
  addView(superview, self.avatarImg);
  
  [self.avatarTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.left.equalTo(superview).with.inset(SPACE);
    make.size.lessThanOrEqualTo(superview);
  }];
  
  [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.right.equalTo(superview).with.inset(0.25 * SPACE);
    make.top.bottom.equalTo(superview).with.inset(5);
    make.width.equalTo(self.avatarImg.mas_height);
  }];
}

- (UILabel *)avatarTitle {
  if (!_avatarTitle) {
    _avatarTitle = [UILabel new];
    _avatarTitle.text = @"个人头像";
    _avatarTitle.font = UIFontMake(17);
    _avatarTitle.textColor = UIColor.blackColor;
  }
  return _avatarTitle;
}

- (UIImageView *)avatarImg {
  if (!_avatarImg) {
    _avatarImg = [UIImageView new];
    _avatarImg.image = UIImageMake(@"pink_gradient");
    _avatarImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _avatarImg;
}
@end
