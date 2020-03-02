//
//  MineOutCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineOutCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineOutCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation MineOutCell

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
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (UIImageView *)image {
  if (!_image) {
    _image = [UIImageView new];
    _image.image = UIImageMake(@"icon_moreOperation_shareQzone");
    _image.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _image;
}

- (UILabel *)award {
  if (!_award) {
    _award = [UILabel new];
    _award.numberOfLines = 0;
    _award.attributedText = [MineOutCell generateAward:@{
      @"title" : @"外出换奖励",
      @"subTitle" : @"天数达到10天，即可获得奖励"
    }];
  }
  return _award;
}

- (QMUIGhostButton *)seeBtn {
  if (!_seeBtn) {
    _seeBtn = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorBlue];
    _seeBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [_seeBtn setTitle:@"去看看" forState:UIControlStateNormal];
    _seeBtn.titleLabel.font = UIFontMake(14);
  }
  return _seeBtn;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.image);
    addView(_container, self.award);
    addView(_container, self.seeBtn);
    
    _container.layer.cornerRadius = 10;
    _container.layer.masksToBounds = YES;
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_container);
      make.centerY.equalTo(_container);
    }];
    
    [self.award mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(_container);
      make.trailing.lessThanOrEqualTo(self.seeBtn).with.inset(0.5 * SPACE);
      make.leading.greaterThanOrEqualTo(self.image).with.inset(0.5 * SPACE);
      make.centerY.equalTo(self.image);
    }];
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(_container);
      make.centerY.equalTo(_container);
    }];
  }
  return _container;
}

+ (NSAttributedString *)generateAward:(NSDictionary *)infoDict {
  NSAttributedString *str = [NSAttributedString sj_UIKitText:^(
                                                               id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.lineSpacing(10);
    make.append([NSString stringWithFormat:@"%@\n", infoDict[@"title"]])
    .textColor(UIColor.qd_mainTextColor)
    .font(UIFontBoldMake(18));
    make.append(infoDict[@"subTitle"]).textColor(UIColor.qd_placeholderColor).font(UIFontMake(15));
  }];
  return str;
}
@end
