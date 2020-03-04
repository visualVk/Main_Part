//
//  DetailPresentToolBarView.m
//  MainPart
//
//  Created by blacksky on 2020/3/2.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailPresentToolBarView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface DetailPresentToolBarView () <GenerateEntityDelegate>

@end

@implementation DetailPresentToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.backgroundColor = UIColor.qd_backgroundColor;
    self.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.25;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  addView(self, self.asksSupplier);
  addView(self, self.price);
  addView(self, self.buyImage);
  
  [self.asksSupplier mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).with.inset(SPACE);
    make.centerY.equalTo(self);
  }];
  
  [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.buyImage.mas_leading);
    make.centerY.equalTo(self);
  }];
  
  [self.buyImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self).with.inset(SPACE);
    make.centerY.equalTo(self);
  }];
}

- (UILabel *)asksSupplier {
  if (!_asksSupplier) {
    _asksSupplier = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"client");
        make.alignment = SJUTVerticalAlignmentCenter;
      });
      make.append(@"\t问问店家").textColor(UIColor.qd_placeholderColor).font(UIFontMake(18));
    }];
    _asksSupplier.attributedText = str;
  }
  return _asksSupplier;
}

- (UILabel *)price {
  if (!_price) {
    _price = [UILabel new];
    _price.attributedText = [self generatePrice:@{
      @"oldPrice" : @"339",
      @"discountPrice" : @"237"
    }];
  }
  return _price;
}

- (UIImageView *)buyImage {
  if (!_buyImage) {
    _buyImage = [UIImageView new];
    _buyImage.userInteractionEnabled = true;
    _buyImage.image = UIImageMake(@"pay");
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [_buyImage addGestureRecognizer:tap];
  }
  return _buyImage;
}

- (void)click {
  if (self.clickBlock) { self.clickBlock(); }
}

- (NSAttributedString *)generatePrice:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append([NSString stringWithFormat:@"¥%@", infoDict[@"oldPrice"]])
    .strikethrough(^(id<SJUTDecoration> _Nonnull make) {
      make.color = UIColor.qd_mainTextColor;
      make.style = NSUnderlineStyleSingle | NSUnderlineStylePatternSolid;
    })
    .textColor(UIColor.qd_mainTextColor)
    .font(UIFontMake(15));
    make.append(@" ¥").textColor(UIColor.qmui_randomColor);
    make.append([NSString stringWithFormat:@"%@", infoDict[@"discountPrice"]])
    .textColor(UIColor.qmui_randomColor)
    .font(UIFontMake(17));
  }];
  return str;
}

- (void)loadData:(NSDictionary *)infoDict {
  self.price.attributedText = [self generatePrice:infoDict];
}
@end
