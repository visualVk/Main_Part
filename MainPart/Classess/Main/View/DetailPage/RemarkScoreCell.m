//
//  RemarkScoreCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/22.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkScoreCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "RemarkListController.h"
#import <SJAttributesFactory.h>

@interface RemarkScoreCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *score;
@property (nonatomic, strong) QMUIFloatLayoutView *liteTag;
@property (nonatomic, strong) QMUIFloatLayoutView *bigTag;
@property (nonatomic, strong) QMUIButton *moreRemark;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, assign) CGFloat labelHeight;
@property (nonatomic, weak) UIViewController *paCon;
@end

@implementation RemarkScoreCell

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
  self.backgroundColor = UIColor.qd_separatorColor;
  self.container.backgroundColor = UIColor.qd_backgroundColor;
  UIView *superview = self.contentView;
  addView(superview, self.container);
  addView(superview, self.title);
  addView(superview, self.score);
  addView(superview, self.liteTag);
  addView(superview, self.moreRemark);
  
  //  UIEdgeInsets padding = UIEdgeInsetsMake(0.5*SPACE, 0.5*SPACE, <#CGFloat bottom#>, <#CGFloat
  //  right#>)
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).inset(0.5 * SPACE);
    make.right.left.bottom.equalTo(superview);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.equalTo(superview).multipliedBy(1.0 / 3);
  }];
  [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title);
    make.top.equalTo(self.title.mas_bottom);
  }];
  CGSize size = [self.liteTag sizeThatFits:CGSizeMake(300, MAXFLOAT)];
  [self.liteTag mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.score);
    make.left.equalTo(self.score.mas_right).with.inset(0.5 * SPACE);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(size.height);
  }];
  
  [self.moreRemark mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(_container);
    make.bottom.equalTo(_container).with.inset(10);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [RemarkScoreCell generateCommonLabel];
    _title.text = @"住客评价";
  }
  return _title;
}

- (UILabel *)score {
  if (!_score) {
    _score = [UILabel new];
    NSString *content = @"4.5分";
    NSMutableAttributedString *attrbuteString =
    [[NSMutableAttributedString alloc] initWithString:content];
    [attrbuteString addAttribute:NSForegroundColorAttributeName
                           value:UIColor.qd_tintColor
                           range:NSMakeRange(0, content.length)];
    [attrbuteString addAttribute:NSFontAttributeName
                           value:UIFontBoldMake(25)
                           range:NSMakeRange(0, 3)];
    _score.attributedText = attrbuteString;
  }
  return _score;
}

- (QMUIFloatLayoutView *)liteTag {
  if (!_liteTag) {
    _liteTag = [[QMUIFloatLayoutView alloc] init];
    _liteTag.itemMargins = UIEdgeInsetsMake(0, 5, 0, 5);
    //    _liteTag.translatesAutoresizingMaskIntoConstraints = NO;
    _liteTag.padding = UIEdgeInsetsMake(0, 10, 0, 0);
    for (int i = 0; i < 3; ++i) {
      UILabel *label = [self generateTagLabel];
      CGSize size = [label sizeThatFits:CGSizeMake(30, MAXFLOAT)];
      self.labelHeight = size.height;
      addView(_liteTag, label);
    }
    _liteTag.qmui_borderColor = UIColor.qd_separatorColor;
    _liteTag.qmui_borderPosition = QMUIViewBorderPositionLeft;
  }
  return _liteTag;
}

- (UIView *)container {
  if (!_container) { _container = [UIView new]; }
  return _container;
}

- (QMUIButton *)moreRemark {
  if (!_moreRemark) {
    _moreRemark = [QDUIHelper generateLightBorderedButton];
    _moreRemark.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _moreRemark.backgroundColor = UIColor.clearColor;
    _moreRemark.titleLabel.font = UIFontMake(18);
    [_moreRemark setTitle:@"更多评论" forState:UIControlStateNormal];
    [_moreRemark addTarget:self
                    action:@selector(moreRemarkJump)
          forControlEvents:UIControlEventTouchUpInside];
  }
  return _moreRemark;
}

- (void)moreRemarkJump {
  if (!self.paCon) { self.paCon = self.qmui_viewController; }
  RemarkListController *rlCon = [RemarkListController new];
  rlCon.hotelId = 1;
  [self.paCon.navigationController pushViewController:rlCon animated:YES];
}

- (UILabel *)generateTagLabel {
  UILabel *label = [UILabel new];
  label.textColor = UIColor.qd_codeColor;
  label.text = @"卫生4.5";
  label.font = UIFontMake(14);
  return label;
}

- (UILabel *)generateTagLabelWithContent:(NSString *)content {
  UILabel *label = [UILabel new];
  label.textColor = UIColor.qd_codeColor;
  label.text = content;
  label.font = UIFontMake(14);
  return label;
}

+ (UILabel *)generateCommonLabel {
  UILabel *label = [UILabel new];
  label.textColor = UIColor.qd_mainTextColor;
  label.font = UIFontBoldMake(24);
  label.textAlignment = NSTextAlignmentCenter;
  return label;
}

- (void)generateTagFlow:(NSArray *)list {
  [self.liteTag qmui_removeAllSubviews];
  for (NSString *str in list) { [self.liteTag addSubview:[self generateTagLabelWithContent:str]]; }
}

- (NSAttributedString *)generateAvgScore:(CGFloat)score {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append([NSString stringWithFormat:@"%g", score])
    .textColor(UIColor.qd_tintColor)
    .font(UIFontBoldMake(25));
    make.append(@"分").textColor(UIColor.qd_tintColor).font(UIFontMake(18));
  }];
}

- (void)setModel:(HotelRoomModel *)model {
  _model = model;
  self.score.attributedText = [self generateAvgScore:model.avgGrade];
  [self generateTagFlow:@[
    [self floatConvertString:model.serviceGrade name:@"服务"],
    [self floatConvertString:model.hygieneGrade name:@"卫生"],
    [self floatConvertString:model.serviceGrade name:@"设施"],
    [self floatConvertString:model.serviceGrade name:@"位置"]
  ]];
}

- (NSString *)floatConvertString:(CGFloat)score name:(NSString *)name {
  return [NSString stringWithFormat:@"%@%g", name, score];
}
@end
