//
//  RoomCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RoomCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface RoomCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUIFloatLayoutView *tagFloatView;
@property (nonatomic, strong) UILabel *notationLabel;
@property (nonatomic, strong) UILabel *oldPrice;
@property (nonatomic, strong) UILabel *discountPrice;
@property (nonatomic, strong) QMUILabel *desPrice;
@property (nonatomic, strong) UIImageView *payImg;
@end

@implementation RoomCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.title);
  addView(superview, self.tagFloatView);
  addView(superview, self.notationLabel);
  addView(superview, self.oldPrice);
  addView(superview, self.discountPrice);
  addView(superview, self.desPrice);
  addView(superview, self.payImg);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  CGSize tagSize = [self.tagFloatView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.tagFloatView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.title.mas_bottom).with.inset(0.25 * SPACE);
    make.left.equalTo(self.title);
    make.width.equalTo(superview).multipliedBy(5.0 / 7);
    make.height.mas_equalTo(tagSize.height);
  }];
  
  [self.notationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.tagFloatView.mas_bottom).with.inset(0.25 * SPACE);
    make.left.equalTo(self.title);
    make.bottom.lessThanOrEqualTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.payImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(0.5 * SPACE);
    make.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.desPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.payImg);
    make.trailing.equalTo(self.payImg.mas_leading).with.inset(0.25 * SPACE);
  }];
  
  [self.discountPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.desPrice);
    make.bottom.equalTo(self.desPrice.mas_top).with.inset(0.25 * SPACE);
  }];
  
  [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.desPrice);
    make.bottom.equalTo(self.discountPrice.mas_top).with.inset(0.25 * SPACE);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.font(UIFontMake(16));
      make.append(@"2份早餐\t").textColor(UIColor.qmui_randomColor);
      make.append(@"大床\t2人入住\t").textColor(UIColor.qd_mainTextColor);
      make.append(@"详情").textColor(UIColor.qd_mainTextColor);
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"right_arrow_small");
      });
    }];
    _title.attributedText = str;
  }
  return _title;
}

- (QMUIFloatLayoutView *)tagFloatView {
  if (!_tagFloatView) {
    _tagFloatView = [[QMUIFloatLayoutView alloc] init];
    _tagFloatView.itemMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    for (int i = 0; i < 3; i++) {
      [_tagFloatView addSubview:[RoomCell generateTagLabelWithContent:@"便宜"]];
    }
  }
  return _tagFloatView;
}

- (UILabel *)notationLabel {
  if (!_notationLabel) {
    _notationLabel = [UILabel new];
    _notationLabel.text = @"暂无说明信息";
    _notationLabel.textColor = UIColor.qmui_randomColor;
  }
  return _notationLabel;
}

- (UILabel *)oldPrice {
  if (!_oldPrice) {
    _oldPrice = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.font(UIFontMake(13)).textColor(UIColor.qd_placeholderColor);
      make.append(@"¥328").strikethrough(^(id<SJUTDecoration> _Nonnull make) {
        make.style = NSUnderlineStyleSingle | NSUnderlinePatternSolid;
        make.color = UIColor.qd_placeholderColor;
      });
    }];
    _oldPrice.attributedText = str;
  }
  return _oldPrice;
}
- (UILabel *)discountPrice {
  if (!_discountPrice) {
    _discountPrice = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.font(UIFontMake(16)).textColor(UIColor.qmui_randomColor);
      make.append(@"¥229");
      make.regex(@"¥").update(
                              ^(id<SJUTAttributesProtocol> _Nonnull make) { make.font(UIFontMake(13)); });
    }];
    _discountPrice.attributedText = str;
  }
  return _discountPrice;
}

- (QMUILabel *)desPrice {
  if (!_desPrice) {
    _desPrice = [QMUILabel new];
    _desPrice.textColor = UIColor.qd_backgroundColor;
    _desPrice.backgroundColor = UIColor.qmui_randomColor;
    _desPrice.text = @"已减¥99";
    _desPrice.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _desPrice.layer.borderColor = UIColor.clearColor.CGColor;
    _desPrice.layer.cornerRadius = 5;
    _desPrice.layer.masksToBounds = YES;
  }
  return _desPrice;
}

- (UIImageView *)payImg {
  if (!_payImg) {
    _payImg = [UIImageView new];
    _payImg.image = UIImageMake(@"pay");
  }
  return _payImg;
}

+ (QMUILabel *)generateTagLabelWithContent:(NSString *)content {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
  label.layer.borderColor = UIColor.qmui_randomColor.CGColor;
  label.layer.borderWidth = 1.0f;
  label.text = content;
  label.font = UIFontMake(14);
  label.textColor = UIColor.qmui_randomColor;
  return label;
}
@end
