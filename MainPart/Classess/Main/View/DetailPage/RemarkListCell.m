//
//  RemarkListCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkListCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface RemarkListCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIView *scoreContainer;
@property (nonatomic, strong) UILabel *scoreOne;
@property (nonatomic, strong) UILabel *scoreTwo;
@property (nonatomic, strong) UILabel *scoreThree;
@property (nonatomic, strong) UILabel *scoreFour;
@property (nonatomic, strong) UILabel *checkInfo;
@property (nonatomic, strong) UILabel *remarkDetail;
@property (nonatomic, strong) UIView *repContainer;
@property (nonatomic, strong) UILabel *repDetail;
@property (nonatomic, strong) UIImageView *goodImg;
@property (nonatomic, strong) UILabel *goodLB;
@end

@implementation RemarkListCell

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
  [self.avatarImg setNeedsLayout];
  [self.avatarImg layoutIfNeeded];
  self.avatarImg.layer.cornerRadius = CGRectGetHeight(self.avatarImg.frame) / 2;
  self.avatarImg.layer.masksToBounds = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  
  addView(superview, self.avatarImg);
  addView(superview, self.nameLB);
  addView(superview, self.scoreContainer);
  addView(superview, self.checkInfo);
  addView(superview, self.remarkDetail);
  addView(superview, self.repContainer);
  addView(superview, self.goodLB);
  addView(superview, self.goodImg);
  
  [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).with.inset(15);
    //    make.bottom.equalTo(self.scoreContainer);
    //    make.width.equalTo(self.avatarImg.mas_height);
    make.size.mas_equalTo(CGSizeMake(40, 40));
    make.left.equalTo(superview).with.inset(15);
  }];
  
  [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).with.inset(15);
    make.left.equalTo(self.avatarImg.mas_right).with.inset(15);
    make.right.equalTo(superview).with.inset(15);
  }];
  
  [self.scoreContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.nameLB);
    make.top.equalTo(self.nameLB.mas_bottom);
  }];
  
  [self.checkInfo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImg);
    make.top.equalTo(self.scoreContainer.mas_bottom).with.inset(10);
  }];
  
  [self.remarkDetail mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImg);
    make.top.equalTo(self.checkInfo.mas_bottom).with.inset(10);
    make.right.equalTo(superview).with.inset(15);
    //    make.height.mas_greaterThanOrEqualTo(1);
  }];
  
  [self.repContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImg);
    make.top.equalTo(self.remarkDetail.mas_bottom).with.inset(10);
    make.right.equalTo(superview).with.inset(15);
  }];
  
  [self.goodImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.repContainer.mas_bottom).with.inset(20);
    make.bottom.equalTo(superview).with.inset(20);
    make.right.equalTo(self.goodLB.mas_left).with.inset(5);
  }];
  
  [self.goodLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(superview).with.inset(15);
    make.bottom.equalTo(self.goodImg);
  }];
}

- (UIImageView *)avatarImg {
  if (!_avatarImg) {
    _avatarImg = [UIImageView new];
    _avatarImg.image = UIImageMake(@"pink_gradient");
    _avatarImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _avatarImg;
}

- (UILabel *)nameLB {
  if (!_nameLB) {
    _nameLB = [UILabel new];
    _nameLB.text = @"名字";
    _nameLB.font = UIFontMake(16);
  }
  return _nameLB;
}

- (UIView *)scoreContainer {
  if (!_scoreContainer) {
    _scoreContainer = [UIView new];
    addView(_scoreContainer, self.scoreOne);
    addView(_scoreContainer, self.scoreTwo);
    addView(_scoreContainer, self.scoreThree);
    addView(_scoreContainer, self.scoreFour);
    
    [@[ self.scoreOne, self.scoreTwo, self.scoreThree, self.scoreFour ]
     mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_scoreContainer);
      make.bottom.equalTo(_scoreContainer);
      make.width.mas_equalTo(DEVICE_WIDTH / 5);
    }];
    
    [@[ self.scoreOne, self.scoreTwo, self.scoreThree, self.scoreFour ]
     mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
     withFixedSpacing:0
     leadSpacing:0
     tailSpacing:0];
  }
  return _scoreContainer;
}

- (UILabel *)scoreOne {
  if (!_scoreOne) {
    _scoreOne = [UILabel new];
    _scoreOne.attributedText = [self generateScoreLabelText:@"卫生" score:@"9.8"];
  }
  return _scoreOne;
}

- (UILabel *)scoreTwo {
  if (!_scoreTwo) {
    _scoreTwo = [UILabel new];
    _scoreTwo.attributedText = [self generateScoreLabelText:@"卫生" score:@"9.8"];
  }
  return _scoreTwo;
}

- (UILabel *)scoreThree {
  if (!_scoreThree) {
    _scoreThree = [UILabel new];
    _scoreThree.attributedText = [self generateScoreLabelText:@"卫生" score:@"9.8"];
  }
  return _scoreThree;
}

- (UILabel *)scoreFour {
  if (!_scoreFour) {
    _scoreFour = [UILabel new];
    _scoreFour.attributedText = [self generateScoreLabelText:@"卫生" score:@"9.8"];
  }
  return _scoreFour;
}

- (NSAttributedString *)generateScoreLabelText:(NSString *)title score:(NSString *)score {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_tintColor).font(UIFontMake(15));
    make.append(title);
    make.append(score).font(UIFontBoldMake(18));
    ;
  }];
}

- (UILabel *)checkInfo {
  if (!_checkInfo) {
    _checkInfo = [UILabel new];
    _checkInfo.text = @"xxxxx";
  }
  return _checkInfo;
}

- (NSAttributedString *)generateCheckInfoText:(HotelAppreaiseModel *)model {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColorMakeWithHex(@"#0396FF")).font(UIFontMake(14));
    make.append(
                [NSString stringWithFormat:@"%@入住,%@评价|单人|", model.createTime, model.liveTime])
    .textColor(UIColorMakeWithHex(@"#A1A1A1"));
    make.append(model.roomtypeName);
  }];
}

- (UILabel *)remarkDetail {
  if (!_remarkDetail) {
    _remarkDetail = [UILabel new];
    _remarkDetail.font = UIFontMake(18);
    _remarkDetail.numberOfLines = 0;
    //    _remarkDetail.lineBreakMode = NSLineBreakByTruncatingTail;
  }
  return _remarkDetail;
}

- (UIView *)repContainer {
  if (!_repContainer) {
    _repContainer = [UIView new];
    _repContainer.backgroundColor = UIColor.qd_customBackgroundColor;
    _repContainer.layer.cornerRadius = 5;
    addView(_repContainer, self.repDetail);
    
    [self.repDetail mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(_repContainer).with.inset(10);
      //      make.size.lessThanOrEqualTo(_repContainer);
    }];
  }
  return _repContainer;
}

- (UILabel *)repDetail {
  if (!_repDetail) {
    _repDetail = [UILabel new];
    _repDetail.font = UIFontMake(16);
    _repDetail.textColor = UIColorMakeWithHex(@"#F0F0F0");
    _repDetail.numberOfLines = 0;
  }
  return _repDetail;
}

- (NSAttributedString *)generateRepDetailText:(NSString *)content {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColorMakeWithHex(@"#808080")).font(UIFontMake(16));
    make.append([NSString stringWithFormat:@"客服回复:%@", content]);
  }];
}

- (UIImageView *)goodImg {
  if (!_goodImg) {
    _goodImg = [UIImageView new];
    _goodImg.image = UIImageMake(@"good_image");
  }
  return _goodImg;
}

- (UILabel *)goodLB {
  if (!_goodLB) {
    _goodLB = [UILabel new];
    _goodLB.text = @"赞";
    _goodLB.font = UIFontLightMake(18);
  }
  return _goodLB;
}

- (void)setModel:(HotelAppreaiseModel *)model {
  _model = model;
  self.nameLB.text = [NSString stringWithFormat:@"用户%li", model.userId];
  self.scoreOne.attributedText =
  [self generateScoreLabelText:@"卫生"
                         score:[NSString stringWithFormat:@"%g", model.hygieneGrade]];
  self.scoreTwo.attributedText =
  [self generateScoreLabelText:@"服务"
                         score:[NSString stringWithFormat:@"%g", model.serviceGrade]];
  self.scoreThree.attributedText =
  [self generateScoreLabelText:@"设施"
                         score:[NSString stringWithFormat:@"%g", model.facilitiesGrade]];
  self.scoreFour.attributedText =
  [self generateScoreLabelText:@"环境"
                         score:[NSString stringWithFormat:@"%g", model.locationGrade]];
  self.checkInfo.attributedText = [self generateCheckInfoText:model];
  self.remarkDetail.text = model.content;
  NSInteger random = arc4random() % 255;
  //  NSInteger random = 125;
  if (random < 125) {
    self.repDetail.text = @"";
  } else {
    self.repDetail.text = @"无法显示";
  }
  if (self.repDetail.text == nil || [self.repDetail.text isEqualToString:@""] ||
      self.repDetail.text.length == 0) {
    self.repContainer.backgroundColor = UIColor.clearColor;
    [self.repDetail mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(self.repContainer).with.inset(0);
    }];
  } else {
    self.repDetail.attributedText = [self generateRepDetailText:self.repDetail.text];
    self.repContainer.backgroundColor = UIColor.qd_customBackgroundColor;
    [self.repDetail mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(self.repContainer).with.inset(10);
    }];
  }
}
@end
