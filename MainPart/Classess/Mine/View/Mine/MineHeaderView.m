//
//  MineHeaderView.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineHeaderView.h"
#import "DiscountController.h"
#import "FavorController.h"
#import "HistoryController.h"
#import "MarkUtils.h"
#import "MileageController.h"
#import "NSObject+BlockSEL.h"
#import <SJAttributesFactory.h>
const NSInteger TAGBEGIN = 1000;
@interface MineHeaderView () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *profileImg;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) QMUIFloatLayoutView *tagFlowView;
@property (nonatomic, strong) QMUIGridView *gridView;
@property (nonatomic, strong) QMUICommonViewController *parentController;
@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.datas = @[
      @{ @"number" : [NSNumber numberWithInt:1],
         @"title" : @"我的收藏" },
      @{ @"number" : [NSNumber numberWithInt:2],
         @"title" : @"浏览历史" },
      @{ @"number" : [NSNumber numberWithInt:3],
         @"title" : @"旅行记录" },
      @{ @"number" : [NSNumber numberWithInt:4],
         @"title" : @"优惠券" }
    ];
    //    self.backgroundColor = UIColor.systemBlueColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  //  self.imgBackground.frame =
  //  CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
  NSInteger radius = CGRectGetHeight(self.profileImg.frame) / 2;
  self.profileImg.layer.cornerRadius = radius;
  self.profileImg.layer.borderColor = UIColor.clearColor.CGColor;
  self.profileImg.layer.masksToBounds = YES;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  //  UIView *superview = self;
  self.userInteractionEnabled = YES;
  addView(self, self.imgBackground);
  addView(self, self.profileImg);
  addView(self, self.name);
  addView(self, self.tagFlowView);
  addView(self, self.gridView);
  
  //  [self.imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
  //    make.left.right.bottom.equalTo(self);
  //    make.top.equalTo(self);
  //  }];
  
  [self.profileImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self);
    //    make.top.equalTo(self).with.inset(SPACE);
    make.left.equalTo(self).with.inset(2 * SPACE);
    make.width.mas_equalTo(DEVICE_WIDTH / 7);
    make.height.equalTo(self.profileImg.mas_width);
  }];
  
  [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.profileImg.mas_right).with.inset(SPACE);
    make.top.equalTo(self.profileImg);
  }];
  
  CGSize tagSize = [self.tagFlowView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.tagFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.name);
    make.bottom.equalTo(self.profileImg);
    make.right.equalTo(self);
    make.height.mas_equalTo(tagSize.height);
  }];
  
  CGSize gridSize = [self.gridView sizeThatFits:CGSizeMake(DEVICE_WIDTH - 2 * SPACE, MAXFLOAT)];
  [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self);
    make.height.mas_equalTo(gridSize.height);
    make.bottom.equalTo(self).with.inset(SPACE);
  }];
}

- (void)tagClick:(UIGestureRecognizer *)gesture {
  QMUILabel *label = gesture.qmui_targetView;
  if ([label.text isEqualToString:@"银行"]) { QMUILogInfo(@"mine header view", @"bank"); }
}

- (void)gridClick:(UIGestureRecognizer *)gesture {
  UILabel *label = gesture.qmui_targetView;
  UIViewController *con = nil;
  if (!self.parentController) { self.parentController = [self qmui_viewController]; }
  if ([label.text containsString:@"我的收藏"]) { con = [FavorController new]; }
  if ([label.text containsString:@"浏览历史"]) { con = [HistoryController new]; }
  if ([label.text containsString:@"优惠券"]) { con = [DiscountController new]; }
  if ([label.text containsString:@"旅行记录"]) { con = [MileageController new]; }
  [self.parentController.navigationController qmui_pushViewController:con
                                                             animated:YES
                                                           completion:nil];
  QMUILogInfo(@"mine header view", @"grid:%@", label.text);
}

- (UIImageView *)profileImg {
  if (!_profileImg) {
    _profileImg = [UIImageView new];
    _profileImg.image = UIImageMake(@"pink_gradient");
    _profileImg.contentMode = QMUIImageResizingModeScaleAspectFill;
    _profileImg.backgroundColor = UIColor.clearColor;
  }
  return _profileImg;
}

- (UILabel *)name {
  if (!_name) {
    _name = [UILabel new];
    _name.backgroundColor = UIColor.clearColor;
    _name.font = UIFontBoldMake(20);
    _name.text = @"尊敬的客户";
    _name.textColor = UIColor.qd_backgroundColor;
  }
  return _name;
}

- (QMUIFloatLayoutView *)tagFlowView {
  if (!_tagFlowView) {
    _tagFlowView = [[QMUIFloatLayoutView alloc] initWithFrame:CGRectZero];
    _tagFlowView.itemMargins = UIEdgeInsetsMake(0, 5, 0, 5);
    _tagFlowView.backgroundColor = UIColor.clearColor;
    QMUILabel *tag = nil;
    for (int i = 0; i < 2; i++) {
      if (!i) {
        tag = [MineHeaderView generateTagLabel:@"领会员福利"];
      } else {
        tag = [MineHeaderView generateTagLabel:@"银行"];
      }
      [self addTagTap:tag];
      [_tagFlowView addSubview:tag];
    }
  }
  return _tagFlowView;
}

- (QMUIGridView *)gridView {
  if (!_gridView) {
    _gridView = [[QMUIGridView alloc] initWithColumn:4 rowHeight:DEVICE_HEIGHT / 20];
    _gridView.backgroundColor = UIColor.clearColor;
    UILabel *grid = nil;
    for (int i = 0; i < 4; i++) {
      grid = [MineHeaderView generateGridLabel:(NSDictionary *)self.datas[i]];
      [self addGridTap:grid];
      [_gridView addSubview:grid];
    }
  }
  return _gridView;
}

- (void)addTagTap:(QMUILabel *)tag {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClick:)];
  [tag addGestureRecognizer:tap];
}

- (void)addGridTap:(UILabel *)gird {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridClick:)];
  [gird addGestureRecognizer:tap];
}

+ (QMUILabel *)generateTagLabel:(NSString *)content {
  QMUILabel *tag = [QMUILabel new];
  tag.userInteractionEnabled = YES;
  tag.highlightedBackgroundColor = nil;
  tag.highlightedTextColor = nil;
  tag.font = UIFontMake(12);
  tag.text = content;
  tag.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
  tag.textColor = UIColor.qd_backgroundColor;
  tag.backgroundColor = UIColor.qd_tintColor;
  
  CGSize tagSize = [tag sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
  tag.layer.cornerRadius = tagSize.height / 2;
  tag.layer.borderColor = UIColor.clearColor.CGColor;
  tag.layer.masksToBounds = YES;
  return tag;
}

+ (UILabel *)generateGridLabel:(NSDictionary *)infoDict {
  UILabel *label = [UILabel new];
  label.userInteractionEnabled = YES;
  label.numberOfLines = 0;
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_backgroundColor).lineSpacing(5);
    make.append(@"number\ntitle");
    make.regex(@"number").replaceWithText(^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.append(
                  [NSString stringWithFormat:@"%li", [[infoDict valueForKey:@"number"] integerValue]]);
      make.font(UIFontBoldMake(15));
    });
    make.regex(@"title").replaceWithText(
                                         ^(id<SJUIKitTextMakerProtocol> _Nonnull make) { make.append(infoDict[@"title"]); });
  }];
  label.attributedText = str;
  label.textAlignment = NSTextAlignmentCenter;
  return label;
}

- (UIImageView *)imgBackground {
  if (!_imgBackground) {
    _imgBackground = [UIImageView new];
    _imgBackground.image = UIImageMake(@"navigationbar_background");
    _imgBackground.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imgBackground;
}

- (void)loadData {
}
@end
