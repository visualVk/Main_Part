//
//  SpotCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/17.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SpotCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>
#define SMALLFONT 13
#define imgList                                                                                    \
@[                                                                                               \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"c689c6e6b3ea4aa16719a5dad5b93d36&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%"          \
@"2Fupload%2F19779%2F19778120.JPG",                                                            \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"ded22c5d5202213bfdc3aaeb2f2ecf09&imgtype=0&src=http%3A%2F%2Fwww.bizhidaquan.com%2Fd%"        \
@"2Ffile%2F1%2F1159829.jpg",                                                                   \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513024&di="                                \
@"829f7b9b0ba4222a9bab2282e2b239bd&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201310%2F19%2F235356fyjkkugokokczyo0.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"557632a98119862074f6306c6b269a9d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F2017-10-13%2F59e0270c6ba4e.jpg",                                                           \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"8db59485be71f14b5a70286128d1aec1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg",                                                 \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513023&di="                                \
@"4d4057e96f0b47cb8cb04575ba744ef1&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%"   \
@"2F1%2F53a15a1343174.jpg",                                                                    \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783660279&di="                                \
@"3c9f7da2c66bd25d350e03656e746696&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%"  \
@"3D2155983538%2C3860699715%26fm%3D214%26gp%3D0.jpg",                                          \
@"https://timgsa.baidu.com/"                                                                   \
@"timg?image&quality=80&size=b9999_10000&sec=1588783513022&di="                                \
@"f8308055cabe18057cb07d55193f547f&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%"    \
@"2F201408%2F05%2F222353wu5y5mzv6mprxvhn.jpg"                                                  \
]
@interface SpotCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *spotMark;
@property (nonatomic, strong) UILabel *spotTitle;
@property (nonatomic, strong) UIImageView *favor;
@property (nonatomic, strong) UIView *spotImg;
@property (nonatomic, strong) UILabel *favorNum;
@property (nonatomic, strong) UILabel *recommond;
@property (nonatomic, strong) UILabel *numRank;
@end

@implementation SpotCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.datas = @[ @"pink_gradient", @"pink_gradient", @"pink_gradient" ];
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

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.spotMark);
  addView(superview, self.spotTitle);
  addView(superview, self.spotImg);
  addView(superview, self.favor);
  addView(superview, self.recommond);
  addView(self.spotMark, self.numRank);
  
  [self.spotMark
   mas_makeConstraints:^(MASConstraintMaker *make) { make.top.left.equalTo(superview); }];
  
  CGSize titleSize = [self.spotTitle sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.spotTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview);
    make.left.equalTo(self.spotMark.mas_right).with.inset(0.5 * SPACE);
    make.right.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(titleSize.height);
  }];
  
  [self.spotImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(superview).with.inset(0.5 * SPACE);
    make.top.equalTo(self.spotTitle.mas_bottom).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(DEVICE_HEIGHT / 6);
  }];
  
  [self.recommond mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.spotImg);
    make.top.equalTo(self.spotImg.mas_bottom).with.inset(0.5 * SPACE);
    make.bottom.equalTo(superview).with.inset(2 * SPACE);
  }];
  
  [self.favor mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.spotTitle);
    make.right.equalTo(self.spotImg).with.inset(0.5 * SPACE);
  }];
  
  [self.numRank mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.spotMark);
    make.centerX.equalTo(self.spotMark).offset(-0.5 * SPACE);
  }];
}

- (UIImageView *)spotMark {
  if (!_spotMark) {
    _spotMark = [UIImageView new];
    _spotMark.image = UIImageMake(@"spot_mark");
  }
  return _spotMark;
}

- (UILabel *)spotTitle {
  if (!_spotTitle) {
    _spotTitle = [UILabel new];
    _spotTitle.numberOfLines = 0;
    _spotTitle.attributedText = [SpotCell generateSpotTitle:@{
      @"title" : @"九寨沟",
      @"country" : @"中国",
      @"city" : @"阿坝"
    }];
  }
  return _spotTitle;
}

- (UIView *)spotImg {
  if (!_spotImg) {
    _spotImg = [UIView new];
    _spotImg.layer.cornerRadius = 10;
    _spotImg.layer.borderColor = UIColor.clearColor.CGColor;
    _spotImg.layer.masksToBounds = YES;
    UIImageView *bigImg = [UIImageView new];
    [bigImg sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % imgList.count]]
              placeholderImage:UIImageMake(@"pink_gradient")];
    bigImg.contentMode = QMUIImageResizingModeScaleAspectFill;
    UIImageView *smImg1 = [UIImageView new];
    [smImg1 sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % imgList.count]]
              placeholderImage:UIImageMake(@"pink_gradient")];
    smImg1.contentMode = QMUIImageResizingModeScaleAspectFill;
    UIImageView *smImg2 = [UIImageView new];
    [smImg2 sd_setImageWithURL:[NSURL URLWithString:imgList[arc4random() % imgList.count]]
              placeholderImage:UIImageMake(@"pink_gradient")];
    smImg2.contentMode = QMUIImageResizingModeScaleAspectFill;
    addView(_spotImg, bigImg);
    addView(_spotImg, smImg1);
    addView(_spotImg, smImg2);
    [bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.equalTo(_spotImg);
      make.width.equalTo(_spotImg).multipliedBy(3.0 / 5);
      make.bottom.equalTo(_spotImg);
    }];
    [smImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(bigImg.mas_right).with.inset(0.5 * SPACE);
      make.right.top.equalTo(_spotImg);
      make.height.equalTo(bigImg).multipliedBy(0.5).offset(-0.25 * SPACE);
    }];
    [smImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.equalTo(smImg1);
      make.top.equalTo(smImg1.mas_bottom).with.inset(0.5 * SPACE);
      make.bottom.lessThanOrEqualTo(bigImg);
    }];
  }
  return _spotImg;
}

- (UIImageView *)favor {
  if (!_favor) {
    _favor = [UIImageView new];
    _favor.image = UIImageMake(@"favor");
  }
  return _favor;
}

- (UILabel *)recommond {
  if (!_recommond) {
    _recommond = [UILabel new];
    _recommond.numberOfLines = 0;
    _recommond.attributedText = [SpotCell generateRecommond:@{
      @"advice" : @"xxxkfajksldjkalsjdlak"
    }];
  }
  return _recommond;
}

- (UILabel *)numRank {
  if (!_numRank) {
    _numRank = [UILabel new];
    _numRank.text = @"1";
    _numRank.textColor = UIColor.qd_backgroundColor;
    _numRank.font = UIFontBoldMake(18);
  }
  return _numRank;
}

+ (NSAttributedString *)generateRecommond:(NSDictionary *)recDic {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_mainTextColor);
    make.append(@"推荐理由:").font(UIFontBoldMake(14));
    make.append(recDic[@"advice"]).font(UIFontMake(14));
  }];
  return str;
}

+ (NSAttributedString *)generateSpotTitle:(NSDictionary *)titleDic {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.lineSpacing(5);
    make.append(@"spotname\t").textColor(UIColor.qd_mainTextColor).font(UIFontBoldMake(22));
    make.appendImage(^(id<SJUTImageAttachment> _Nonnull make) {
      make.image = UIImageMake(@"right-arrow-fill");
    })
    .baseLineOffset(-3);
    make.append(@"\n");
    make.appendImage(
                     ^(id<SJUTImageAttachment> _Nonnull make) { make.image = UIImageMake(@"spot_locate"); });
    make.append(@"country·city").textColor(UIColor.qd_placeholderColor).font(UIFontMake(14));
    make.regex(@"\\bspotname\\b").replaceWithString(titleDic[@"title"]);
    make.regex(@"country").replaceWithString(titleDic[@"country"]);
    make.regex(@"city").replaceWithString(titleDic[@"city"]);
  }];
  return str;
}

- (void)reloadData:(NSDictionary *)dict {
  self.spotTitle.attributedText = [SpotCell generateSpotTitle:@{
    @"title" : dict[@"title"],
    @"country" : @"九龙",
    @"city" : @"一山"
  }];
  self.numRank.text = ([dict[@"numRank"] integerValue] < 4) ? dict[@"numRank"] : @"";
  self.favorNum.text = dict[@"favor"];
  self.recommond.attributedText = [SpotCell generateRecommond:@{ @"advice" : dict[@"recommond"] }];
}
@end
