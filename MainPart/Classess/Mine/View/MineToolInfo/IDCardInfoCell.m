//
//  IDCardInfoCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "IDCardInfoCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface IDCardInfoCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation IDCardInfoCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
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
  addView(self.contentView, self.container);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    _container.layer.cornerRadius = 10;
    _container.layer.masksToBounds = YES;
    addView(_container, self.infoAttr);
    [self.infoAttr mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(_container);
      make.left.equalTo(_container).with.inset(SPACE);
    }];
  }
  return _container;
}

- (UILabel *)infoAttr {
  if (!_infoAttr) {
    _infoAttr = [UILabel new];
    _infoAttr.numberOfLines = 0;
    _infoAttr.attributedText = [IDCardInfoCell generateIdInfo:@{
      @"name" : @"王大锤",
      @"idCard" : @"3303044545151651688"
    }];
  }
  return _infoAttr;
}

+ (NSAttributedString *)generateIdInfo:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(infoDict[@"name"]).textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
    make.lineSpacing(5);
    NSString *cardNum = infoDict[@"idCard"];
    make.append([NSString stringWithFormat:@"\n身份证\t%@**********%@",
                 [cardNum substringWithRange:NSMakeRange(0, 6)],
                 [cardNum substringWithRange:NSMakeRange(15, 2)]])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(15));
  }];
  return str;
}

+ (NSAttributedString *)generateIdInfoWithInfo:(Info *)info {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(info.name).textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
    make.lineSpacing(5);
    NSString *cardNum = info.idCard;
    make.append([NSString stringWithFormat:@"\n身份证\t%@**********%@",
                 [cardNum substringWithRange:NSMakeRange(0, 6)],
                 [cardNum substringWithRange:NSMakeRange(15, 2)]])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(15));
  }];
  return str;
}

- (void)loadData:(Info *)info {
  self.infoAttr.attributedText = [IDCardInfoCell generateIdInfoWithInfo:info];
}
@end
