//
//  MineMeliedgeCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineMeliedgeCell.h"
#import "MarkUtils.h"

@interface MineMeliedgeCell () <GenerateEntityDelegate>

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
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.mileageCircle);
  
  [self.mileageCircle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).with.inset(0.5 * SPACE);
    make.height.mas_equalTo(4 * (CIRCLEHEIGHT - 2 * SPACE) / 3);
    make.width.mas_equalTo(4 * (CIRCLEHEIGHT - 2 * SPACE) / 3);
    make.centerX.equalTo(superview);
  }];
}

- (ZZCircleProgress *)mileageCircle {
  if (!_mileageCircle) {
    _mileageCircle = [[ZZCircleProgress alloc] initWithFrame:CGRectZero
                                               pathBackColor:UIColor.qd_placeholderColor
                                               pathFillColor:UIColor.qmui_randomColor
                                                  startAngle:150
                                                 strokeWidth:25];
    _mileageCircle.reduceAngle = 120;
    _mileageCircle.duration = 0.5;
    _mileageCircle.showPoint = YES;
    _mileageCircle.showPoint = UIImageMake(@"check_selected");
    _mileageCircle.showProgressText = YES;
    _mileageCircle.progress = (arc4random() % 500 * 1.0) / 500;
    _mileageCircle.progressLabel.text = @"目前累计公里:38888";
    _mileageCircle.progressLabel.textColor = UIColor.qmui_randomColor;
  }
  return _mileageCircle;
}

@end
