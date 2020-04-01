//
//  RecCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RecCell.h"
#import "MarkUtils.h"

@interface RecCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *recImg;
@property (nonatomic, strong) UILabel *recName;
@property (nonatomic, strong) UILabel *recScore;
@property (nonatomic, strong) UILabel *recAddress;
@property (nonatomic, strong) UILabel *recDescription;
@property (nonatomic, strong) QMUIFloatLayoutView *tagView;
@end

@implementation RecCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithReuseIdentifier:reuseIdentifier]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.whiteColor;
    addView(_container, self.recImg);
    addView(_container, self.recName);
    addView(_container, self.recScore);
    //    addView(_container, self.recAddress);
    //    addView(_container, self.tagView);
    addView(_container, self.recDescription);
    
    [self.recImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.right.left.equalTo(_container);
      make.height.equalTo(_container).multipliedBy(0.6);
      //      make.height.equalTo(self.recImg.mas_width);
    }];
    
    [self.recName mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.recImg.mas_bottom).with.inset(5);
      make.left.equalTo(self.recImg).with.inset(10);
    }];
    
    [self.recScore mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.recName.mas_bottom);
      make.right.equalTo(self.recImg).with.inset(10);
    }];
    //
    //    //    [self.recAddress mas_makeConstraints:^(MASConstraintMaker *make) {
    //    //      make.top.equalTo(self.recName.mas_bottom).with.inset(10);
    //    //      make.left.equalTo(self.recName).with.inset(10);
    //    //    }];
    //
    [self.recDescription mas_makeConstraints:^(MASConstraintMaker *make) {
      //      make.top.equalTo(self.recAddress.mas_bottom).with.inset(5);
      make.top.equalTo(self.recName.mas_bottom).with.inset(10);
      make.left.right.equalTo(_container).with.inset(10);
      //      make.bottom.equalTo(_container).with.inset(5);
      make.bottom.lessThanOrEqualTo(_container).with.inset(5);
    }];
    //
    //    CGSize tagSize = [self.tagView sizeThatFits:CGSizeMake(DEVICE_WIDTH - 60, MAXFLOAT)];
    //    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.height.mas_equalTo(tagSize.height);
    //      make.left.right.equalTo(_container).with.inset(10);
    //      make.top.equalTo(self.recName.mas_bottom).with.inset(5);
    //    }];
    //
    //    [self.recAddress mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.right.left.equalTo(_container).with.inset(10);
    //      make.bottom.equalTo(_container).with.inset(5);
    //    }];
  }
  return _container;
}

- (UIImageView *)recImg {
  if (!_recImg) {
    _recImg = [UIImageView new];
    _recImg.image = UIImageMake(@"pink_gradient");
    _recImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _recImg;
}

- (UILabel *)recName {
  if (!_recName) {
    _recName = [UILabel new];
    _recName.textColor = UIColor.qd_mainTextColor;
    _recName.font = UIFontBoldMake(35);
    _recName.text = @"星级住宿会员";
  }
  return _recName;
}

- (UILabel *)recScore {
  if (!_recScore) {
    _recScore = [UILabel new];
    _recScore.textColor = UIColor.qd_placeholderColor;
    _recScore.font = UIFontLightMake(13);
    _recScore.text = @"阿库娅系列专属";
  }
  return _recScore;
}

- (UILabel *)recAddress {
  if (!_recAddress) {
    _recAddress = [UILabel new];
    _recAddress.textColor = UIColor.qd_separatorColor;
    _recAddress.text = @"xxxfasfasdasdads";
    _recAddress.font = UIFontLightMake(13);
  }
  return _recAddress;
}

- (UILabel *)recDescription {
  if (!_recDescription) {
    _recDescription = [UILabel new];
    _recDescription.numberOfLines = 0;
    _recDescription.text = @"3-4星级酒店享受7.5折优惠，并附送夜宵、水果";
    _recDescription.textColor = UIColor.qd_mainTextColor;
    _recDescription.font = UIFontMake(18);
  }
  return _recDescription;
}

- (QMUIFloatLayoutView *)tagView {
  if (!_tagView) {
    _tagView = [[QMUIFloatLayoutView alloc] initWithFrame:CGRectZero];
    _tagView.itemMargins = UIEdgeInsetsMake(3, 5, 3, 5);
    int count = arc4random() % 6;
    for (int i = 0; i < count; i++) {
      QMUILabel *tag = [self generateTag:[NSString stringWithFormat:@"tag %d", i]];
      [_tagView addSubview:tag];
    }
  }
  return _tagView;
}

- (QMUILabel *)generateTag:(NSString *)tagName {
  QMUILabel *tag = [QMUILabel new];
  tag.highlightedBackgroundColor = nil;
  tag.highlightedTextColor = nil;
  tag.textColor = UIColor.qmui_randomColor;
  tag.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 2, 3);
  tag.layer.borderColor = UIColor.qmui_randomColor.CGColor;
  tag.layer.borderWidth = 1;
  tag.font = UIFontLightMake(12);
  tag.text = tagName;
  return tag;
}
@end
