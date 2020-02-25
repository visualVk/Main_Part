//
//  DetailHeaderPartCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/24.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DetailHeaderPartCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import <SDCycleScrollView.h>
#import <SJAttributesFactory.h>
#define GridTagHeight DEVICE_HEIGHT * 3 / 40
#define BannerHeight DEVICE_HEIGHT / 3

@interface DetailHeaderPartCell ()
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUIGridView *gridTagView;
@end

@implementation DetailHeaderPartCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.qd_backgroundColor;
    self.datas = @[ @"pink_gradient", @"pink_gradient", @"pink_gradient" ];
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)prepareForReuse {
  //  [self.gridTagView qmui_removeAllSubviews];
  //  self.datas = nil;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.banner);
  addView(superview, self.title);
  addView(superview, self.gridTagView);
  
  [self.banner mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(superview);
    make.height.mas_equalTo(BannerHeight);
  }];
  CGSize titleSize = [self.title sizeThatFits:CGSizeMake(200, MAXFLOAT)];
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.banner.mas_bottom).with.inset(0.5 * SPACE);
    make.left.right.equalTo(self.banner).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(titleSize.height);
  }];
  CGSize size = [self.gridTagView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.gridTagView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.title.mas_bottom).with.inset(0.5 * SPACE);
    make.left.right.equalTo(self.title);
    make.height.mas_equalTo(size.height);
    make.bottom.equalTo(superview);
  }];
}

- (SDCycleScrollView *)banner {
  if (!_banner) {
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:self.datas];
    _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
  }
  return _banner;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.font = UIFontBoldMake(20);
    _title.textColor = UIColor.qd_mainTextColor;
    _title.text = @"客房名称";
  }
  return _title;
}

- (QMUIGridView *)gridTagView {
  if (!_gridTagView) {
    _gridTagView = [[QMUIGridView alloc] initWithColumn:3 rowHeight:GridTagHeight / 2];
    for (int i = 0; i < 5; i++) {
      [_gridTagView
       addSubview:[DetailHeaderPartCell generateTagLabelWithImageName:@"light" content:@"20m™"]];
    }
  }
  return _gridTagView;
}

+ (UILabel *)generateTagLabelWithImageName:(NSString *)imageName content:(NSString *)content {
  NSAttributedString *text =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.font(UIFontBoldMake(13)).textColor(UIColor.qd_mainTextColor);
    make.appendImage(
                     ^(id<SJUTImageAttachment> _Nonnull make) { make.image = UIImageMake(imageName); });
    make.append(content);
  }];
  UILabel *label = [UILabel new];
  label.attributedText = text;
  return label;
}
@end
