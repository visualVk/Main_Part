//
//  SpotFoldCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/18.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SpotFoldCell.h"
#import "AMLocationUtils.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#define SMALLFONT 13

@interface SpotFoldCell ()
@property (nonatomic, strong) UIView *foreView;
@property (nonatomic, strong) UIImageView *startImage;
@property (nonatomic, strong) UIImageView *spotImage;
@property (nonatomic, strong) QMUILabel *spotNameLB;
@property (nonatomic, strong) QMUILabel *spotTagLB;
@property (nonatomic, strong) QMUILabel *remarkLB;
@property (nonatomic, strong) QMUILabel *scoreLB;
@property (nonatomic, strong) QMUILabel *locLB;
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation SpotFoldCell

+ (CGFloat)cellOpenH {
  return 3 * DEVICE_HEIGHT / 7;
}

+ (CGFloat)cellCloseH {
  return DEVICE_HEIGHT / 7;
}

+ (CGFloat)foldNum {
  return 3;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

+ (SpotFoldCell *)testCellWithTableView:(UITableView *)tableView {
  SpotFoldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotFoldCell"];
  if (cell == nil) {
    CGFloat subHeight;
    if ([SpotFoldCell foldNum] == 1) {
      subHeight = 0;
    } else {
      subHeight = ([SpotFoldCell cellOpenH] - 20 - ([SpotFoldCell cellCloseH] - 20) * 2) /
      ([SpotFoldCell foldNum] - 1);
    }
    cell = [[SpotFoldCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:@"SpotFoldCell"
                             forwardViewHeight:[SpotFoldCell cellCloseH] - 20
                                 subFlipHeight:subHeight
                                     foldCount:[SpotFoldCell foldNum]
                                     cornerRad:10
                                    paddingAry:@[ @10, @10 ]
                                  reverseColor:[UIColor lightGrayColor]];
  }
  return cell;
}

- (void)setNumber:(NSInteger)number {
  _number = number;
  if (self.foreView) { QMUILogInfo(@"spot fold cell", @"fold cell create successfully!"); }
  if (!self.mapView) {
    UIView *superview = [self viewWithIndex:1];
    self.mapView = [[MAMapView alloc] initWithFrame:superview.bounds];
    addView(superview, self.mapView);
  }
}

- (void)setBGColor {
  UIView *view0 = [self viewWithIndex:0];
  view0.backgroundColor = UIColor.qd_backgroundColor;
  UIView *view1 = [self viewWithIndex:1];
  view1.backgroundColor = UIColor.qmui_randomColor;
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView:(UIView *)superview {
  //  UIView *superview = [self viewWithIndex:0];
  addView(superview, self.startImage);
  addView(superview, self.spotImage);
  addView(superview, self.spotNameLB);
  addView(superview, self.spotTagLB);
  addView(superview, self.remarkLB);
  addView(superview, self.scoreLB);
  addView(superview, self.locLB);
  
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:[self selectorBlock:^(id _Nonnull args) {
    QMUILogInfo(@"tap", @"detail tap");
  }]];
  self.spotImage.userInteractionEnabled = YES;
  [self.spotImage addGestureRecognizer:tap];
  
  [self.spotImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(superview).offset(-0.5 * SPACE);
    //    make.width.equalTo(superview).multipliedBy(0.25);
    make.width.equalTo(self.spotImage.mas_height);
    //    make.height.equalTo(self.spotImage.mas_height);
  }];
  
  [self.spotNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotImage);
    make.left.equalTo(self.spotImage.mas_right).offset(0.5 * SPACE);
  }];
  
  [self.startImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.spotNameLB.mas_right).offset(0.5 * SPACE);
    make.centerY.equalTo(self.spotNameLB.mas_centerY);
    make.height.width.equalTo(@20);
  }];
  
  [self.spotTagLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotNameLB.mas_bottom).offset(0.5 * SPACE);
    make.left.equalTo(self.spotNameLB);
  }];
  
  [self.remarkLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.spotTagLB.mas_bottom).offset(0.25 * SPACE);
    make.left.equalTo(self.spotTagLB);
    make.bottom.lessThanOrEqualTo(self.locLB.mas_top);
  }];
  
  [self.locLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.remarkLB);
    make.bottom.equalTo(self.scoreLB);
  }];
  
  [self.scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.bottom.equalTo(superview).offset(-0.5 * SPACE);
  }];
}

- (UIImageView *)startImage {
  if (!_startImage) {
    _startImage = [UIImageView new];
    _startImage.image = UIImageMake(@"pink_gradient");
    _startImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _startImage.layer.cornerRadius = 2.5f;
    _startImage.layer.masksToBounds = YES;
    _startImage.clipsToBounds = YES;
  }
  return _startImage;
}

- (UIImageView *)spotImage {
  if (!_spotImage) {
    _spotImage = [UIImageView new];
    _spotImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    _spotImage.image = UIImageMake(@"navigationbar_background");
    _spotImage.layer.cornerRadius = 5;
    _spotImage.layer.borderColor = UIColor.clearColor.CGColor;
    _spotImage.layer.masksToBounds = YES;
    _spotImage.clipsToBounds = YES;
  }
  return _spotImage;
}

- (QMUILabel *)spotNameLB {
  if (!_spotNameLB) {
    _spotNameLB = [QMUILabel new];
    _spotNameLB.text = @"五马街";
    _spotNameLB.textColor = UIColor.qd_mainTextColor;
    _spotNameLB.font = UIFontBoldMake(18);
  }
  return _spotNameLB;
}

- (QMUILabel *)spotTagLB {
  if (!_spotTagLB) {
    _spotTagLB = [QMUILabel new];
    _spotTagLB.text = @"小吃众多";
    _spotTagLB.textColor = UIColor.qmui_randomColor;
    _spotTagLB.font = UIFontBoldMake(14);
  }
  return _spotTagLB;
}

- (QMUILabel *)remarkLB {
  if (!_remarkLB) {
    _remarkLB = [QMUILabel new];
    _remarkLB.text = @"100条评论";
    _remarkLB.textColor = UIColor.qd_placeholderColor;
    _remarkLB.font = UIFontBoldMake(SMALLFONT);
  }
  return _remarkLB;
}

- (QMUILabel *)scoreLB {
  if (!_scoreLB) {
    _scoreLB = [QMUILabel new];
    _scoreLB = [QMUILabel new];
    _scoreLB.text = @"5.2分";
    _scoreLB.textColor = UIColor.qmui_randomColor;
    _scoreLB.font = UIFontBoldMake(25);
  }
  return _scoreLB;
}

- (QMUILabel *)locLB {
  if (!_locLB) {
    _locLB = [QMUILabel new];
    _locLB = [QMUILabel new];
    _locLB.text = @"xxxxxxxxxxxxxxx";
    _locLB.textColor = UIColor.qd_placeholderColor;
    _locLB.font = UIFontBoldMake(SMALLFONT);
  }
  return _locLB;
}

- (UIView *)foreView {
  if (!_foreView) {
    _foreView = [UIView new];
    [self generateRootView:_foreView];
    UIView *superview = [self viewWithIndex:0];
    addView(superview, self.foreView);
    [self.foreView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.equalTo(superview);
      make.right.bottom.equalTo(superview);
    }];
  }
  return _foreView;
}
@end
