//
//  MineMeliedgeCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineMeliedgeCell.h"
#import "HWWaveRectView.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface MineMeliedgeCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *mileageTitle;
@property (nonatomic, strong) HWWaveRectView *waveView;
@end

@implementation MineMeliedgeCell

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
  //  __weak __typeof(self) weakSelf = self;
  //  [RACObserve(self.mileTx, text) subscribeNext:^(NSString *x) {
  //    weakSelf.mileTx.attributedText = [weakSelf generateMileTextWithContent:x];
  //  }];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.waveView);
  addView(superview, self.mileageView);
  addView(superview, self.mileageTitle);
  addView(superview, self.mileTx);
  
  [self.waveView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.bottom.equalTo(superview);
    //    make.height.mas_equalTo(superview).multipliedBy(0.5);
  }];
  
  [self.mileageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [self.mileageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(superview).with.inset(0.5 * SPACE);
    make.width.equalTo(self.mileageView.mas_height);
    make.center.equalTo(superview);
  }];
  
  [self.mileTx mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(superview);
    make.size.lessThanOrEqualTo(superview).multipliedBy(1.0 / sqrtf(2));
  }];
}

- (MileageCircleProgressView *)mileageView {
  if (!_mileageView) {
    _mileageView = [MileageCircleProgressView new];
    _mileageView.progress = 30;
    _mileageView.backgroundColor = UIColor.clearColor;
  }
  return _mileageView;
}

- (QMUILabel *)mileageTitle {
  if (!_mileageTitle) {
    _mileageTitle = [QMUILabel new];
    _mileageTitle.text = @"外宿天数";
    _mileageTitle.font = UIFontLightMake(22);
    _mileageTitle.textColor = UIColorBlack;
    _mileageTitle.highlightedTextColor = nil;
    _mileageTitle.highlightedBackgroundColor = nil;
    _mileageTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _mileageTitle.qmui_borderColor = [UIColor colorWithRed:0.9725 green:0.7412 blue:0.1725 alpha:1];
    _mileageTitle.qmui_borderWidth = 2.5;
    _mileageTitle.qmui_borderPosition = QMUIViewBorderPositionLeft;
  }
  return _mileageTitle;
}

- (UILabel *)mileTx {
  if (!_mileTx) {
    _mileTx = [UILabel new];
    _mileTx.attributedText = [self generateMileTextWithContent:@"325"];
  }
  return _mileTx;
}

- (HWWaveRectView *)waveView {
  if (!_waveView) {
    _waveView = [[HWWaveRectView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 75)];
    _waveView.progress = 0.5;
  }
  return _waveView;
}

- (NSAttributedString *)generateMileTextWithContent:(NSString *)content {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.append(content).textColor(UIColor.qd_backgroundColor).font(UIFontBoldMake(40));
    make.append(@"天").textColor(UIColor.qd_backgroundColor).font(UIFontMake(28));
  }];
}
@end
