//
//  MineDiscountCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineDiscountCell.h"
#import "MarkUtils.h"
#import <QuartzCore/QuartzCore.h>
#import <SJAttributesFactory.h>
#define DISCOUNTHEIGHT DEVICE_HEIGHT / 8

@interface MineDiscountCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *discountView;
@property (nonatomic, strong) UILabel *detailContent;
@property (nonatomic, strong) UIView *shadowView1;
@property (nonatomic, strong) UIView *shadowView2;
@end

@implementation MineDiscountCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.clipsToBounds = YES;
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
  addView(superview, self.detailView);
  addView(self.detailView, self.detailContent);
  addView(superview, self.container);
  [self shadowView1];
  addView(self.container, self.discountView);
  addView(self.container, self.title);
  addView(self.container, self.detail);
  addView(self.container, self.brief);
  addView(self.container, self.useBtn);
  
  [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(2 * DISCOUNTHEIGHT);
  }];
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(DISCOUNTHEIGHT);
  }];
  
  [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.bottom.equalTo(self.container);
    make.width.equalTo(self.discountView.mas_height);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.discountView.mas_right).with.inset(0.25 * SPACE);
    make.top.right.equalTo(self.container).with.inset(0.25 * SPACE);
  }];
  
  [self.brief mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.title);
    make.top.equalTo(self.title.mas_bottom);
  }];
  
  [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.brief);
    make.bottom.equalTo(self.container).with.inset(0.25 * SPACE);
  }];
  
  [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.bottom.equalTo(self.container).with.inset(0.25 * SPACE);
  }];
  
  [self.detailContent mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.detailView).with.inset(0.5 * SPACE);
    make.top.equalTo(self.detailView).with.inset(2 * SPACE);
    make.bottom.equalTo(self.detailView).with.inset(0.25 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.backgroundColor = UIColor.qd_backgroundColor;
    _container.layer.borderColor = UIColor.clearColor.CGColor;
    _container.layer.borderWidth = 0.1;
    _container.layer.cornerRadius = 10;
    _container.layer.masksToBounds = YES;
  }
  return _container;
}

- (UIView *)shadowView1 {
  if (!_shadowView1) {
    self.shadowView1 = [UIView new];
    self.shadowView1.backgroundColor = UIColor.qd_backgroundColor;
    self.shadowView1.layer.cornerRadius = 10;
    self.shadowView1.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    self.shadowView1.layer.shadowRadius = 10;
    self.shadowView1.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView1.layer.shadowOpacity = 0.25;
    [self.contentView insertSubview:self.shadowView1 belowSubview:self.container];
    [self.shadowView1
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.container); }];
  }
  return _shadowView1;
}

- (UIView *)discountView {
  if (!_discountView) {
    _discountView = [UIView new];
    _discountView.backgroundColor = UIColor.qmui_randomColor;
    self.discountNum = [UILabel new];
    self.discountNum.attributedText = [MineDiscountCell generateDiscountNum:@"6.0"];
    addView(_discountView, self.discountNum);
    [self.discountNum
     mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(_discountView); }];
  }
  return _discountView;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(18);
    _title.text = @"三亚美食";
  }
  return _title;
}

- (UILabel *)brief {
  if (!_brief) {
    _brief = [UILabel new];
    _brief.numberOfLines = 0;
    _brief.attributedText = [MineDiscountCell generateBreif:@{
      @"content" : @"大伟哥牛啤",
      @"st" : @"2019-12-04",
      @"ed" : @"2020-03-03"
    }];
  }
  return _brief;
}

- (QMUIButton *)useBtn {
  if (!_useBtn) {
    _useBtn = [QDUIHelper generateLightBorderedButton];
    _useBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [_useBtn setBackgroundColor:UIColor.qd_backgroundColor];
    [_useBtn setTitle:@"去使用" forState:UIControlStateNormal];
    [_useBtn setTitleColor:UIColor.qmui_randomColor forState:UIControlStateNormal];
    [_useBtn setTitleColor:UIColor.qmui_randomColor forState:UIControlStateHighlighted];
    [_useBtn setTintColor:UIColor.qmui_randomColor];
    [_useBtn addTarget:self
                action:@selector(useClick)
      forControlEvents:UIControlEventTouchUpInside];
  }
  return _useBtn;
}

- (UIView *)detailView {
  if (!_detailView) {
    _detailView = [UIView new];
    _detailView.layer.cornerRadius = 10;
    _detailView.backgroundColor = UIColor.qd_backgroundColor;
    _detailView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    _detailView.layer.borderWidth = 0.1;
    _detailView.layer.shadowOpacity = 0.25f;
    _detailView.layer.shadowOffset = CGSizeMake(1, 1);
    //    _detailView.layer.masksToBounds = YES;
    addView(_detailContent, self.detailContent);
    [self.detailContent mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.equalTo(_detailContent).with.inset(0.5 * SPACE);
      make.top.equalTo(_detailContent.mas_centerY);
    }];
  }
  return _detailView;
}

- (UILabel *)detailContent {
  if (!_detailContent) {
    _detailContent = [UILabel new];
    _detailContent.text = @"content";
  }
  return _detailContent;
}

- (void)useClick {
  QMUILogInfo(@"mine discount", @"use click");
}

- (UILabel *)detail {
  if (!_detail) {
    _detail = [UILabel new];
    NSAttributedString *str =
    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
      make.textColor(UIColor.qd_placeholderColor).font(UIFontMake(13));
      make.append(@"详细说明");
      make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
        make.image = UIImageMake(@"more_bottom");
        make.alignment = SJUTVerticalAlignmentCenter;
      });
    }];
    _detail.attributedText = str;
  }
  return _detail;
}

+ (NSAttributedString *)generateBreif:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_placeholderColor);
    make.append(infoDict[@"content"]).font(UIFontMake(16));
    make.append([NSString stringWithFormat:@"\n%@ 至 %@", infoDict[@"st"], infoDict[@"ed"]])
    .font(UIFontMake(14));
  }];
  return str;
}

+ (NSAttributedString *)generateDiscountNum:(NSString *)num {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_backgroundColor);
    make.append(num).font(UIFontBoldMake(25));
    make.append(@"折").font(UIFontMake(20));
  }];
  return str;
}
@end
