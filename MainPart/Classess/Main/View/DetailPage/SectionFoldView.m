//
//  SectionFoldView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/20.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SectionFoldView.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"

@interface SectionFoldView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUIFloatLayoutView *briefFlow;
@property (nonatomic, strong) QMUIFloatLayoutView *tagFlow;
@property (nonatomic, strong) UILabel *originPriceLB;
@property (nonatomic, strong) UILabel *discountPrice;
@property (nonatomic, strong) QMUILabel *desPriceLB;
@property (nonatomic, strong) UIImageView *moreBtn;
@property (nonatomic, strong) UIView *moreView;
@end

@implementation SectionFoldView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
    self.backgroundColor = UIColor.clearColor;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *fa = self.contentView;
  UIView *superview = [UIView new];
  superview.backgroundColor = UIColor.qd_backgroundColor;
  
  addView(fa, superview);
  addView(superview, self.imageview);
  addView(superview, self.moreBtn);
  addView(superview, self.title);
  addView(superview, self.briefFlow);
  addView(superview, self.tagFlow);
  addView(superview, self.originPriceLB);
  addView(superview, self.discountPrice);
  addView(superview, self.desPriceLB);
  addView(superview, self.moreView);
  
  [superview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(fa);
    make.bottom.equalTo(fa).offset(-10);
  }];
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).offset(10).priorityMedium;
    make.bottom.equalTo(superview).offset(-10).priorityMedium;
    make.width.equalTo(self.imageview.mas_height);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.imageview.mas_right).offset(0.5 * SPACE);
    make.top.equalTo(self.imageview);
  }];
  
  [self.briefFlow mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title);
    make.top.equalTo(self.title.mas_bottom).offset(0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(3.0 / 5);
    make.height.equalTo(superview).multipliedBy(1.0 / 5);
  }];
  
  [self.tagFlow mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.title);
    make.top.equalTo(self.briefFlow.mas_bottom).offset(0.5 * SPACE);
    make.width.equalTo(superview).multipliedBy(3.0 / 7);
    make.height.equalTo(superview).multipliedBy(1.0 / 5);
  }];
  
  [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(superview).offset(-10).priorityMedium;
    make.centerY.equalTo(superview).priorityMedium;
  }];
  
  [self.originPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.greaterThanOrEqualTo(self.imageview);
    make.right.equalTo(self.discountPrice);
    make.bottom.equalTo(self.discountPrice.mas_top).offset(-10);
  }];
  
  [self.discountPrice mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.desPriceLB);
    make.bottom.equalTo(self.desPriceLB.mas_top).offset(-10);
  }];
  
  [self.desPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.moreBtn.mas_left).offset(-0.5 * SPACE);
    make.bottom.equalTo(self.imageview);
  }];
  
  [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.moreBtn);
    make.top.bottom.equalTo(superview);
  }];
  
  __weak __typeof(self) weakSelf = self;
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:[self selectorBlock:^(id _Nonnull args) {
    if (weakSelf.didSelectBlock) {
      QMUILogInfo(@"section fold view", @"tap recoginzed !");
      BOOL flg = self.didSelectBlock(YES);
      if (flg) {
        weakSelf.moreBtn.image = UIImageMake(@"more_bottom");
      } else {
        weakSelf.moreBtn.image = UIImageMake(@"more_top");
      }
    }
  }]];
  self.moreView.userInteractionEnabled = YES;
  [self.moreView addGestureRecognizer:tap];
}

#pragma mark - Lazy Init
- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"pink_gradient");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imageview;
}

- (UILabel *)title {
  if (!_title) {
    _title = [SectionFoldView generateCommonLabel];
    _title.text = @"豪华大床";
  }
  return _title;
}

- (UILabel *)originPriceLB {
  if (!_originPriceLB) {
    _originPriceLB = [SectionFoldView generateCommonLabel];
    _originPriceLB.textColor = UIColor.qd_placeholderColor;
    NSAttributedString *attr = [[NSAttributedString alloc]
                                initWithString:@"¥328"
                                attributes:@{
                                  NSStrikethroughStyleAttributeName :
                                    @(NSUnderlineStyleSingle | NSUnderlinePatternSolid),
                                  NSStrikethroughColorAttributeName : UIColor.qd_placeholderColor,
                                  NSFontAttributeName : UIFontMake(14)
                                }];
    _originPriceLB.attributedText = attr;
  }
  return _originPriceLB;
}

- (UILabel *)discountPrice {
  if (!_discountPrice) {
    _discountPrice = [SectionFoldView generateCommonLabel];
    _discountPrice.textColor = UIColorMakeWithHex(@"#067904");
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥229"];
    [str addAttribute:NSFontAttributeName value:UIFontMake(14) range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName
                value:UIFontMake(18)
                range:NSMakeRange(1, str.length - 1)];
    _discountPrice.attributedText = str;
  }
  return _discountPrice;
}

- (QMUILabel *)desPriceLB {
  if (!_desPriceLB) {
    _desPriceLB = [QMUILabel new];
    _desPriceLB.font = UIFontMake(14);
    _desPriceLB.layer.cornerRadius = 5;
    _desPriceLB.layer.masksToBounds = YES;
    _desPriceLB.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _desPriceLB.backgroundColor = UIColorMakeWithHex(@"#DC0000");
    _desPriceLB.textColor = UIColor.qd_backgroundColor;
    _desPriceLB.highlightedBackgroundColor = nil;
    _desPriceLB.text = @"已减¥99";
  }
  return _desPriceLB;
}

- (QMUIFloatLayoutView *)tagFlow {
  if (!_tagFlow) {
    _tagFlow = [[QMUIFloatLayoutView alloc] init];
    _tagFlow.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _tagFlow.itemMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    NSInteger sum = arc4random() % 3 + 1;
    for (int i = 0; i < sum; ++i) {
      QMUILabel *tag = [SectionFoldView generateTagLabel];
      if (i) { tag.text = [NSString stringWithFormat:@"tag %d", i]; }
      [_tagFlow addSubview:tag];
    }
  }
  return _tagFlow;
}

- (QMUIFloatLayoutView *)briefFlow {
  if (!_briefFlow) {
    _briefFlow = [[QMUIFloatLayoutView alloc] init];
    _briefFlow.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _briefFlow.itemMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    NSInteger sum = arc4random() % 3 + 1;
    for (int i = 0; i < sum; ++i) {
      QMUILabel *tag = [SectionFoldView generateNoBorderTag];
      if (i) { tag.text = [NSString stringWithFormat:@"tag %d", i]; }
      [_briefFlow addSubview:tag];
    }
  }
  return _briefFlow;
}

- (UIImageView *)moreBtn {
  if (!_moreBtn) {
    _moreBtn = [UIImageView new];
    _moreBtn.image = UIImageMake(@"more_bottom");
    _moreBtn.contentMode = QMUIImageResizingModeScaleAspectFit;
  }
  return _moreBtn;
}

- (UIView *)moreView {
  if (!_moreView) {
    _moreView = [UIView new];
    _moreView.backgroundColor = UIColor.clearColor;
  }
  return _moreView;
}

+ (QMUILabel *)generateTagLabel {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
  label.font = UIFontMake(13);
  label.textColor = UIColor.qmui_randomColor;
  label.layer.borderColor = UIColor.qmui_randomColor.CGColor;
  label.layer.borderWidth = 1.0f;
  label.layer.masksToBounds = YES;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = nil;
  label.text = @"积分兑换";
  return label;
}

- (QMUILabel *)generateTagLabelWithContent:(NSString *)content {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
  label.font = UIFontMake(13);
  label.textColor = UIColorMakeWithHex(@"#64B05D");
  label.layer.borderColor = UIColorMakeWithHex(@"#8AED81").CGColor;
  label.layer.borderWidth = 1.0f;
  label.layer.masksToBounds = YES;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = nil;
  label.text = content;
  return label;
}

- (void)generateTagFlowWithContent:(NSString *)content {
  [self.tagFlow qmui_removeAllSubviews];
  [self.tagFlow addSubview:[self generateTagLabelWithContent:@"20㎡"]];
  [self.tagFlow addSubview:[self generateTagLabelWithContent:@"可快速退订"]];
}

+ (QMUILabel *)generateNoBorderTag {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
  label.font = UIFontMake(13);
  label.textColor = UIColor.lightGrayColor;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = nil;
  label.text = @"16 m™";
  return label;
}

+ (UILabel *)generateCommonLabel {
  UILabel *label = [UILabel new];
  label.font = UIFontBoldMake(20);
  label.textColor = UIColor.qd_mainTextColor;
  return label;
}

- (QMUILabel *)generateNoBorderTagWithContent:(NSString *)content {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
  label.font = UIFontMake(13);
  label.textColor = UIColor.blackColor;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = nil;
  label.text = content;
  return label;
}

- (void)generatebriefFlow:(NSString *)area {
  [self.briefFlow qmui_removeAllSubviews];
  [self.briefFlow
   addSubview:[self
               generateNoBorderTagWithContent:[NSString stringWithFormat:@"%@-40㎡", area]]];
  //  [self.briefFlow addSubview:[self generateNoBorderTagWithContent:area]];
}

- (void)setModel:(HotelRoomModel *)model {
  _model = model;
  self.title.text = model.roomType;
  [self generatebriefFlow:model.roomArea];
  [self generateTagFlowWithContent:model.roomName];
  self.originPriceLB.text = [NSString stringWithFormat:@"¥%li", model.roomOrgprice];
  self.discountPrice.text = [NSString stringWithFormat:@"¥%li", model.roomPrice];
  self.desPriceLB.text =
  [NSString stringWithFormat:@"已减¥%li", model.roomOrgprice - model.roomPrice];
}

- (void)setImgUrl:(NSString *)imgUrl {
  _imgUrl = imgUrl;
  [self.imageview sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                    placeholderImage:UIImageMake(@"pink_gradient")];
}
@end
