//
//  RemarkCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <TYAttributedLabel/TYAttributedLabel.h>

@interface RemarkCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *avtorImg;
@property (nonatomic, strong) UIImageView *levelImg;
@property (nonatomic, strong) QMUILabel *checkInTypeLB;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) TYAttributedLabel *remark;
@end

@implementation RemarkCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.avtorImg.layer.cornerRadius = CGRectGetHeight(self.avtorImg.frame) / 2;
  self.avtorImg.layer.masksToBounds = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.avtorImg);
  addView(superview, self.username);
  addView(superview, self.remark);
  addView(superview, self.checkInTypeLB);
  
  [self.avtorImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(superview).offset(0.5 * SPACE);
    //    make.bottom.equalTo(superview).offset(-0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(1.0 / 8);
    make.height.equalTo(self.avtorImg.mas_width);
  }];
  
  [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avtorImg.mas_right).with.inset(0.25 * SPACE);
    make.top.equalTo(self.avtorImg.mas_top);
    make.height.equalTo(@30);
  }];
  
  [self.remark mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.avtorImg.mas_bottom).offset(0.5 * SPACE);
    make.left.equalTo(self.avtorImg);
    make.right.bottom.equalTo(superview).offset(-0.5 * SPACE);
  }];
  
  [self.checkInTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.username);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UIImageView *)avtorImg {
  if (!_avtorImg) {
    _avtorImg = [UIImageView new];
    _avtorImg.image = UIImageMake(@"pink_gradient");
  }
  return _avtorImg;
}

- (UILabel *)username {
  if (!_username) {
    _username = [UILabel new];
    _username.text = @"wwx";
    _username.font = UIFontBoldMake(16);
  }
  return _username;
}

- (QMUILabel *)checkInTypeLB {
  if (!_checkInTypeLB) {
    _checkInTypeLB = [QMUILabel new];
    _checkInTypeLB.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
    _checkInTypeLB.layer.borderColor = UIColor.systemGrayColor.CGColor;
    _checkInTypeLB.layer.cornerRadius = 3;
    _checkInTypeLB.layer.borderWidth = 1;
    _checkInTypeLB.textColor = UIColor.systemGrayColor;
    _checkInTypeLB.layer.masksToBounds = YES;
    _checkInTypeLB.highlightedTextColor = nil;
    _checkInTypeLB.highlightedBackgroundColor = nil;
    _checkInTypeLB.font = UIFontMake(17);
  }
  return _checkInTypeLB;
}

- (TYAttributedLabel *)remark {
  if (!_remark) {
    _remark = [[TYAttributedLabel alloc] init];
    _remark.userInteractionEnabled = YES;
    [_remark
     appendText:
     @"评"
     @"价"
     @"优"
     @"秀"
     @"评"
     @"价"
     @"优"
     @"秀"
     @"评"
     @"价优秀评价优秀评价优秀评价优秀评价优秀评价优秀评价优秀\n"];
  }
  return _remark;
}

- (void)setModel:(HotelAppreaiseModel *)model {
  _model = model;
  self.remark.text = model.content;
  
  self.checkInTypeLB.text = model.roomtypeName;
}
@end
