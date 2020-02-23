//
//  FacilityCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "FacilityCell.h"
#import "MarkUtils.h"
#import <TYAttributedLabel/TYAttributedLabel.h>

@interface FacilityCell ()
@property (nonatomic, strong) UIView *foreView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *show;
@property (nonatomic, strong) QMUIGridView *gridTag;
@property (nonatomic, strong) TYAttributedLabel *label;
@end

@implementation FacilityCell

+ (CGFloat)cellOpenH {
  return 3 * DEVICE_HEIGHT / 7;
}

+ (CGFloat)cellCloseH {
  return DEVICE_HEIGHT / 10;
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

- (void)prepareForReuse {
  [super prepareForReuse];
  UIView *superview = [self viewWithIndex:1];
  [superview qmui_removeAllSubviews];
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0, 0.5 * SPACE);
  if (self.type == SINGLEINLINE) {
    addView(superview, self.label);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(superview).with.insets(padding);
    }];
  } else {
    addView(superview, self.gridTag);
    [self.gridTag mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.top.equalTo(superview).width.inset(0.5 * SPACE);
      make.height.equalTo(@((DEVICE_HEIGHT / 20) * 4));
    }];
  }
}

#pragma mark - GenerateForeView
- (void)generateForeView:(UIView *)superview {
  addView(superview, self.title);
  addView(superview, self.show);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(superview).offset(-0.5 * SPACE);
  }];
  
  [self.show mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(superview).offset(-0.5 * SPACE);
    make.centerY.equalTo(self.title);
  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"设施";
    _title.font = UIFontBoldMake(18);
    _title.textColor = UIColor.qd_mainTextColor;
  }
  return _title;
}

- (UILabel *)show {
  if (!_show) {
    _show = [UILabel new];
    _show.text = @"显示";
    _show.textColor = UIColor.qd_tintColor;
    _show.font = UIFontMake(16);
  }
  return _show;
}

+ (FacilityCell *)testCellWithTableView:(UITableView *)tableView {
  FacilityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FacilityCell"];
  if (cell == nil) {
    CGFloat subHeight;
    if ([FacilityCell foldNum] == 1) {
      subHeight = 0;
    } else {
      subHeight = ([FacilityCell cellOpenH] - 20 - ([FacilityCell cellCloseH] - 20) * 2) /
      ([FacilityCell foldNum] - 1);
    }
    cell = [[FacilityCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:@"FacilityCell"
                             forwardViewHeight:[FacilityCell cellCloseH] - 20
                                 subFlipHeight:subHeight
                                     foldCount:[FacilityCell foldNum]
                                     cornerRad:10
                                    paddingAry:@[ @10, @10 ]
                                  reverseColor:[UIColor lightGrayColor]];
  }
  return cell;
}

- (UIView *)foreView {
  if (!_foreView) {
    _foreView = [UIView new];
    [self generateForeView:_foreView];
    UIView *superview = [self viewWithIndex:0];
    addView(superview, _foreView);
    [_foreView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.equalTo(superview);
      make.right.bottom.equalTo(superview);
    }];
  }
  return _foreView;
}

- (void)setNumber:(NSInteger)number {
  _number = number;
  if (self.foreView) { QMUILogInfo(@"spot fold cell", @"fold cell create successfully!"); }
  //  if (!self.facilityBack) {
  //    self.facilityBack = [UIView new]; UIView *superview = [self viewWithIndex:1];
  //    addView(superview, self.facilityBack);
  //    addView(sel, <#sub#>)
  //  }
}

- (void)setBGColor {
  UIView *view0 = [self viewWithIndex:0];
  view0.backgroundColor = UIColor.qd_backgroundColor;
  UIView *view1 = [self viewWithIndex:1];
  view1.backgroundColor = UIColor.qd_backgroundColor;
}

- (void)loadData {
  //  self.label.attributedText = [NSAttributedString new];
  //  [FacilityCell generateLineTagLabel:self.label
  //                          imageNames:@[ @"light", @"park" ]
  //                         tagContents:@[ @"快速入住\t", @"免费停车" ]];
  //  QMUILogInfo(@"facility cell", @"attribute text:{%@}", self.label.attributedText);
}

- (TYAttributedLabel *)label {
  if (!_label) {
    _label = [[TYAttributedLabel alloc] init];
    _label.textContainer.linesSpacing = 10;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    //    _label.preferredMaxLayoutWidth = DEVICE_WIDTH - SPACE;
    // 文字间隙
    _label.characterSpacing = 2;
    // 文本行间隙
    _label.linesSpacing = 6;
    
    UIImage *img = UIImageMake(@"time");
    [_label appendImage:img
                   size:CGSizeMake(img.size.width, img.size.height)
              alignment:TYDrawAlignmentCenter];
    NSString *text = @"入住时间 10:00-15:00\t";
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{
      NSFontAttributeName : UIFontBoldMake(13),
      NSForegroundColorAttributeName : UIColor.qd_mainTextColor
    }
                              range:NSMakeRange(0, text.length - 1)];
    [_label appendTextAttributedString:attributedString];
    
    text = @"离开时间 17:00-22:00\n";
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{
      NSFontAttributeName : UIFontBoldMake(13),
      NSForegroundColorAttributeName : UIColor.qd_mainTextColor
    }
                              range:NSMakeRange(0, text.length - 1)];
    [_label appendTextAttributedString:attributedString];
    
    img = UIImageMake(@"child");
    [_label appendImage:img size:img.size alignment:TYDrawAlignmentCenter];
    text = @"儿童及其加床\n";
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{
      NSFontAttributeName : UIFontBoldMake(13),
      NSForegroundColorAttributeName : UIColor.qd_mainTextColor
    }
                              range:NSMakeRange(0, text.length - 1)];
    [_label appendTextAttributedString:attributedString];
    text =
    @"·酒店允许携带儿童入住\n·每间客房最多容纳1名儿童，和成人公用"
    @"现"
    @"有"
    @"床"
    @"铺"
    @"。"
    @"\n"
    @"·"
    @"酒"
    @"店"
    @"不"
    @"提"
    @"供"
    @"加"
    @"婴儿床和加床\n·不接受18岁以下的客人再无监护人陪同下入住\n";
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{
      NSFontAttributeName : UIFontBoldMake(12),
      NSForegroundColorAttributeName : UIColor.qd_separatorColor,
    }
                              range:NSMakeRange(0, text.length - 1)];
    [_label appendTextAttributedString:attributedString];
  }
  return _label;
}

- (QMUIGridView *)gridTag {
  if (!_gridTag) {
    _gridTag = [[QMUIGridView alloc] init];
    _gridTag.translatesAutoresizingMaskIntoConstraints = NO;
    _gridTag.columnCount = 2;
    _gridTag.rowHeight = DEVICE_HEIGHT / 20;
    for (int i = 0; i < 8; i++) {
      //      TYAttributedLabel *tag = [FacilityCell generateGridTag];
      [_gridTag addSubview:[FacilityCell generateGridTag]];
    }
  }
  return _gridTag;
}

+ (QMUIButton *)generateGridTag {
  QMUIButton *btn = [QMUIButton new];
  btn.enabled = false;
  [btn setImage:UIImageMake(@"light") forState:UIControlStateDisabled];
  [btn setTitle:@"快速入住" forState:UIControlStateDisabled];
  [btn setTitleColor:UIColor.qd_mainTextColor forState:UIControlStateDisabled];
  btn.titleLabel.font = UIFontMake(14);
  return btn;
}

+ (void)generateLineTagLabel:(TYAttributedLabel *)tagLabel
                  imageNames:(NSArray<NSString *> *)imageNames
                 tagContents:(NSArray<NSString *> *)tagContents {
}
@end
