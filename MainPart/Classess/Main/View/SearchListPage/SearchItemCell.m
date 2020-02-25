//
//  SearchItemCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/25.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SearchItemCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface SearchItemCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, strong) UILabel *simple;
@property (nonatomic, strong) QMUIFloatLayoutView *tagFloatView;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) QMUILabel *desPrice;
@end

@implementation SearchItemCell

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

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.searchImg);
  addView(superview, self.simple);
  addView(superview, self.tagFloatView);
  addView(superview, self.price);
  addView(superview, self.desPrice);
  
  [self.searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.bottom.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(self.searchImg.mas_height).multipliedBy(6.0 / 7);
  }];
  
  CGSize simpleSize = [self.simple sizeThatFits:CGSizeMake(DEVICE_WIDTH * 4 / 5, MAXFLOAT)];
  [self.simple mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.searchImg.mas_right).with.inset(0.5 * SPACE);
    make.top.equalTo(self.searchImg);
    make.width.mas_equalTo(simpleSize.width);
    make.height.mas_equalTo(simpleSize.height);
  }];
  
  CGSize tagSize = [self.tagFloatView sizeThatFits:CGSizeMake(DEVICE_WIDTH * 4 / 5, MAXFLOAT)];
  [self.tagFloatView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.simple);
    make.width.mas_equalTo(tagSize.width);
    make.height.mas_equalTo(tagSize.height);
    make.top.equalTo(self.simple.mas_bottom);
  }];
  
  [self.desPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.desPrice);
    make.bottom.equalTo(self.desPrice.mas_top);
  }];
}

- (UIImageView *)searchImg {
  if (!_searchImg) {
    _searchImg = [UIImageView new];
    _searchImg.image = UIImageMake(@"pink_gradient");
    _searchImg.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _searchImg;
}

- (UILabel *)simple {
  if (!_simple) {
    _simple = [UILabel new];
    _simple.numberOfLines = 0;
    NSAttributedString *str = [NSAttributedString sj_UIKitText:^(
                                                                 id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_mainTextColor);
      make.append(@"title").font(UIFontBoldMake(20));
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"more_bottom");
      })
      .baseLineOffset(-4);
      make.append(@"\nscore分 remark remarkmore\n")
      .textColor(UIColor.qd_tintColor)
      .font(UIFontMake(14));
      make.append(@"distance\nlocation")
      .textColor(UIColor.qd_placeholderColor)
      .font(UIFontMake(14));
      make.regex(@"title").replaceWithString(@"温州荣欣楼大酒店");
      make.regex(@"score").replaceWithText(^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
        make.append(@"4.6").textColor(UIColor.qd_tintColor).font(UIFontMake(18));
      });
      make.regex(@"\\bremark\\b").replaceWithText(^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
        make.append(@"好").textColor(UIColor.qd_tintColor).font(UIFontBoldMake(18));
      });
      make.regex(@"\\bremarkmore\\b").replaceWithString(@"早餐很棒");
    }];
    _simple.attributedText = str;
  }
  return _simple;
}

- (QMUIFloatLayoutView *)tagFloatView {
  if (!_tagFloatView) {
    _tagFloatView = [[QMUIFloatLayoutView alloc] init];
    _tagFloatView.itemMargins = UIEdgeInsetsMake(0, 5, 0, 5);
    for (int i = 0; i < 2; i++) {
      [_tagFloatView addSubview:[SearchItemCell generateTagLabelWithContent:@"xxxax"]];
      [_tagFloatView addSubview:[SearchItemCell generateTagLabelWithContent:@"xas"]];
    }
  }
  return _tagFloatView;
}

- (QMUILabel *)desPrice {
  if (!_desPrice) {
    _desPrice = [QMUILabel new];
    _desPrice.textColor = UIColor.qd_backgroundColor;
    _desPrice.backgroundColor = UIColor.qmui_randomColor;
    _desPrice.font = UIFontMake(16);
    _desPrice.text = @"已减¥99";
    _desPrice.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _desPrice.layer.borderColor = UIColor.clearColor.CGColor;
    _desPrice.layer.cornerRadius = 5;
    _desPrice.layer.masksToBounds = YES;
    _desPrice.highlightedBackgroundColor = nil;
    _desPrice.highlightedTextColor = nil;
  }
  return _desPrice;
}

- (UILabel *)price {
  if (!_price) {
    _price = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_placeholderColor).font(UIFontMake(14));
      make.append(@"¥328 ").strikethrough(^(id<SJUTDecoration> _Nonnull make) {
        make.style = NSUnderlineStyleSingle | NSUnderlineStylePatternSolid;
        make.color = UIColor.qd_placeholderColor;
      });
      make.append(@"¥229 ").textColor(UIColor.qmui_randomColor).font(UIFontMake(18));
      make.append(@"起");
      make.regex(@"¥").update(
                              ^(id<SJUTAttributesProtocol> _Nonnull make) { make.font(UIFontMake(14)); });
    }];
    _price.attributedText = str;
  }
  return _price;
}

+ (QMUILabel *)generateTagLabelWithContent:(NSString *)content {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
  label.layer.borderColor = UIColor.qmui_randomColor.CGColor;
  label.layer.borderWidth = 1.0f;
  label.text = content;
  label.font = UIFontMake(12);
  label.textColor = UIColor.qmui_randomColor;
  label.highlightedTextColor = nil;
  label.highlightedBackgroundColor = nil;
  return label;
}
@end
