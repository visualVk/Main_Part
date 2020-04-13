//
//  HotelComboCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotelComboCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>

@interface HotelComboCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@end

@implementation HotelComboCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.backgroundColor = UIColor.clearColor;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.days.layer.cornerRadius = self.days.frame.size.height / 2;
  self.days.layer.masksToBounds = YES;
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  [self container];
  
  UIEdgeInsets padding = UIEdgeInsetsMake(0.5 * SPACE, 0.5 * SPACE, 0.25 * SPACE, 0.5 * SPACE);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview).with.insets(padding);
  }];
  
  [@[ self.stDate, self.edDate, self.days, self.configuration ]
   mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
  
  [@[ self.stDate, self.days, self.edDate, self.configuration ]
   mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
   withFixedSpacing:0.5 * SPACE
   leadSpacing:0
   tailSpacing:0];
  
  [self.hotelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.container).with.inset(0.5 * SPACE);
    make.top.equalTo(self.stDate.mas_bottom).with.inset(0.5 * SPACE);
  }];
  
  [self.tags mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.container).with.inset(0.5 * SPACE);
    make.top.equalTo(self.hotelTitle.mas_bottom).with.inset(0.5 * SPACE);
    make.bottom.equalTo(self.container).with.inset(0.5 * SPACE);
  }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    _container.layer.cornerRadius = 8;
    _container.layer.masksToBounds = YES;
    //    _container.backgroundColor = UIColor.qd_backgroundColor;
    addView(self.contentView, _container);
    addView(_container, self.stDate);
    addView(_container, self.days);
    addView(_container, self.edDate);
    //    addView(_container, self.showHotel);
    addView(_container, self.hotelTitle);
    addView(_container, self.tags);
    addView(_container, self.configuration);
    
    UIView *shadowView = [UIView new];
    shadowView.layer.shadowRadius = 8;
    shadowView.backgroundColor = UIColor.qd_backgroundColor;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowColor = UIColor.qd_mainTextColor.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    shadowView.layer.shadowOpacity = 0.25;
    shadowView.layer.borderColor = UIColor.clearColor.CGColor;
    [self.contentView insertSubview:shadowView belowSubview:_container];
    [shadowView
     mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(_container); }];
  }
  return _container;
}

- (QMUILabel *)stDate {
  if (!_stDate) {
    _stDate = [self generateCommonLabel];
    _stDate.userInteractionEnabled = YES;
  }
  return _stDate;
}

- (QMUILabel *)edDate {
  if (!_edDate) {
    _edDate = [self generateCommonLabel];
    _edDate.userInteractionEnabled = YES;
  }
  return _edDate;
}

- (QMUILabel *)days {
  if (!_days) {
    _days = [self generateCommonLabel];
    _days.highlightedBackgroundColor = nil;
    _days.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    _days.layer.borderColor = UIColor.blackColor.CGColor;
    _days.layer.borderWidth = 0.5;
    _days.layer.masksToBounds = YES;
  }
  return _days;
}

- (UILabel *)hotelTitle {
  if (!_hotelTitle) {
    _hotelTitle = [UILabel new];
    _hotelTitle.text = @"标准间";
    _hotelTitle.textColor = UIColor.qd_mainTextColor;
    _hotelTitle.font = UIFontBoldMake(18);
  }
  return _hotelTitle;
}

- (UILabel *)showHotel {
  if (!_showHotel) {
    _showHotel = [UILabel new];
    _showHotel.text = @"查看详情";
    _showHotel.textColor = UIColor.qmui_randomColor;
    _showHotel.font = UIFontMake(14);
  }
  return _showHotel;
}

- (UILabel *)tags {
  if (!_tags) {
    _tags = [UILabel new];
    _tags.attributedText = [self generateTags:@[ @"含早餐", @"大床", @"酒水服务" ]];
  }
  return _tags;
}

- (UILabel *)configuration {
  if (!_configuration) {
    _configuration = [UILabel new];
    _configuration.userInteractionEnabled = YES;
    _configuration.textAlignment = NSTextAlignmentCenter;
    _configuration.text = @"1间1人";
    _configuration.font = UIFontBoldMake(14);
  }
  return _configuration;
}

- (NSAttributedString *)generateTags:(NSArray *)tags {
  NSAttributedString *str =
  [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.qd_placeholderColor).font(UIFontMake(15));
    for (int i = 0; i < tags.count; i++) {
      make.append(tags[i]);
      if (i != i - 1) { make.append(@" | "); }
    }
  }];
  return str;
}

- (NSString *)generateDate:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"M月d日"];
  return [formatter stringFromDate:date];
}

- (QMUILabel *)generateCommonLabel {
  QMUILabel *label = [QMUILabel new];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = UIColor.clearColor;
  label.highlightedBackgroundColor = UIColor.qd_placeholderColor;
  label.highlightedTextColor = nil;
  label.font = UIFontBoldMake(14);
  return label;
}

- (NSString *)generateDays:(NSDate *)stTime edTime:(NSDate *)edTime {
  NSTimeInterval st = [stTime timeIntervalSince1970];
  NSTimeInterval et = [edTime timeIntervalSince1970];
  NSInteger days = (et - st) / 60 / 60 / 24;
  return [NSString stringWithFormat:@"%li天", days];
}

- (void)loadData:(NSDictionary *)infoDict {
  NSDate *st = infoDict[@"stDate"];
  NSDate *ed = infoDict[@"edDate"];
  self.stDate.text = [self generateDate:st];
  self.edDate.text = [self generateDate:ed];
  self.days.text = [self generateDays:st edTime:ed];
  self.configuration.text =
  [NSString stringWithFormat:@"%@间%@人", infoDict[@"room"], infoDict[@"people"]];
}
@end
