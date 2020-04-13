//
//  SloganCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SloganCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface SloganCell () <GenerateEntityDelegate>

@end

@implementation SloganCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.backgroundColor = UIColor.clearColor;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
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
  addView(superview, self.title);
  addView(superview, self.sloganGridView);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.centerX.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  CGSize gridSize = [self.sloganGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.sloganGridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.title.mas_bottom).with.inset(SPACE);
    make.height.mas_equalTo(gridSize.height);
    make.left.right.equalTo(superview);
    make.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"专业服务·全程保障";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(25);
  }
  return _title;
}

- (QMUIGridView *)sloganGridView {
  if (!_sloganGridView) {
    _sloganGridView = [[QMUIGridView alloc] initWithColumn:3 rowHeight:DEVICE_HEIGHT / 12];
    for (int i = 0; i < 3; i++) {
      if (i == 0) {
        [_sloganGridView addSubview:[self generateGrid:@{
          @"title" : @"品质联盟",
          @"placeholder" : @"保障房间质量"
        }]];
      } else if (i == 1) {
        [_sloganGridView addSubview:[self generateGrid:@{
          @"title" : @"客户礼遇",
          @"placeholder" : @"客户福利"
        }]];
      } else {
        [_sloganGridView addSubview:[self generateGrid:@{
          @"title" : @"信息保密",
          @"placeholder" : @"权力维护客户信息"
        }]];
      }
    }
  }
  return _sloganGridView;
}

- (UIView *)generateGrid:(NSDictionary *)infoDict {
  UILabel *label = [UILabel new];
  label.numberOfLines = 0;
  label.attributedText = [NSAttributedString sj_UIKitText:^(
                                                            id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.lineSpacing(2.5);
    make.append(infoDict[@"title"]).textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(16));
    make.append(@"\n");
    make.append(infoDict[@"placeholder"])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(14));
    make.alignment(NSTextAlignmentCenter);
  }];
  UIImageView *imageview = [UIImageView new];
  imageview.image = UIImageMake(@"selection");
  imageview.contentMode = QMUIImageResizingModeScaleAspectFit;
  UIView *container = [UIView new];
  addView(container, label);
  addView(container, imageview);
  
  [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(container);
    make.centerX.equalTo(label);
  }];
  
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(container);
    make.top.greaterThanOrEqualTo(imageview.mas_bottom).with.inset(2.5);
  }];
  
  return container;
}
@end
