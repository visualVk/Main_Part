//
//  MineHistoryCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineHistoryCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineHistoryCell () <GenerateEntityDelegate>

@end

@implementation MineHistoryCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  addView(superview, self.imageview);
  addView(superview, self.title);
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.bottom.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(self.imageview.mas_height);
  }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.imageview.mas_right).with.inset(0.5 * SPACE);
    make.top.equalTo(self.imageview);
  }];
}

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
    _title = [UILabel new];
    _title.text = @"派大星";
    _title.font = UIFontBoldMake(18);
  }
  return _title;
}

- (UILabel *)remark {
  if (!_remark) {
    _remark = [UILabel new];
    _remark.numberOfLines = 0;
    _remark.attributedText = [MineHistoryCell generateRemark:@{
      @"image" : @[ @"light", @"light" ],
      @"time" : @"02-27至02-28入住",
      @"location" : @"未知"
    }];
    addView(self.contentView, _remark);
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.title);
      make.bottom.equalTo(self.imageview);
      make.right.equalTo(self.contentView);
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
    }
    make.append([NSString stringWithFormat:@"\n%@", infoDict[@"time"]])
    .textColor(UIColor.qd_placeholderColor)
    .font(UIFontMake(13));
    make.append(infoDict[@"location"]).textColor(UIColor.qmui_randomColor);
    
  }];
  return str;
}
@end
