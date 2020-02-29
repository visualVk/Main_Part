//
//  MineFavorCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineFavorCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineFavorCell () <GenerateEntityDelegate>

@end

@implementation MineFavorCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  addView(superview, self.validImg);
}

- (UIImageView *)validImg {
  if (!_validImg) {
    _validImg = [UIImageView new];
    _validImg.image = UIImageMake(@"spot_mark");
  }
  return _validImg;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"pink_gradient");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imageview;
}

- (UILabel *)title{
  if(!_title){
    _title.text = @"派大星";
    _title.font = UIFontBoldMake(18);
  }
  return _title;
}

- (UILabel *)remark {
  if (!_remark) {
    _remark = [UILabel new];
    _remark.attributedText = [MineFavorCell generateRemark:@{
      @"image" : @[ @"light", @"light" ],
      @"score" : @"4.3",
      @"location" : @"未知"
    }];
  }
  return _remark;
}

+ (NSAttributedString *)generateRemark:(NSDictionary *)infoDict {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    NSArray *imgList = infoDict[@"image"];
    for (NSString *imageName in imgList) {
      make.appendImage(
                       ^(id<SJUTImageAttachment> _Nonnull make) { make.image = UIImageMake(imageName); });
      make.append([NSString stringWithFormat:@"\n%@分", infoDict[@"score"]])
      .textColor(UIColor.qd_placeholderColor)
      .font(UIFontMake(13));
      make.append(infoDict[@"location"]);
    }
  }];
  return str;
}
@end
