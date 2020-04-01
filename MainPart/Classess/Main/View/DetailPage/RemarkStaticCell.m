//
//  RemarkStaticCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/21.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RemarkStaticCell.h"
#import "HWProgressView.h"
#import "MarkUtils.h"
#import "RemarkScoreView.h"
#import <SJAttributesFactory.h>

@interface RemarkStaticCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUILabel *avgScore;
@property (nonatomic, strong) UIView *scoreContainer;
@property (nonatomic, strong) RemarkScoreView *hiyLB;
@property (nonatomic, strong) RemarkScoreView *evLB;
@property (nonatomic, strong) RemarkScoreView *seLB;
@property (nonatomic, strong) RemarkScoreView *faLB;
@end

@implementation RemarkStaticCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  addView(superview, self.avgScore);
  addView(superview, self.scoreContainer);
  
  [self.avgScore mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(superview).with.inset(15);
    make.top.bottom.equalTo(superview).with.inset(20);
  }];
  
  [self.scoreContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avgScore.mas_right).with.inset(15);
    make.centerY.equalTo(superview);
  }];
}

- (QMUILabel *)avgScore {
  if (!_avgScore) {
    _avgScore = [QMUILabel new];
    _avgScore.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    _avgScore.textColor = UIColor.blueColor;
    _avgScore.highlightedTextColor = nil;
    _avgScore.highlightedBackgroundColor = nil;
    _avgScore.qmui_borderColor = UIColor.qd_separatorColor;
    _avgScore.qmui_borderPosition = QMUIViewBorderPositionRight;
    _avgScore.qmui_borderWidth = 1.5;
  }
  return _avgScore;
}

- (NSAttributedString *)generateAvgScore:(CGFloat)score {
  return [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol> _Nonnull make) {
    make.textColor(UIColor.systemBlueColor);
    make.append([NSString stringWithFormat:@"%.1f", score]).font(UIFontBoldMake(24));
    make.append(@"分").font(UIFontMake(16));
  }];
}

- (UIView *)scoreContainer {
  if (!_scoreContainer) {
    _scoreContainer = [UIView new];
    addView(_scoreContainer, self.hiyLB);
    addView(_scoreContainer, self.evLB);
    addView(_scoreContainer, self.seLB);
    addView(_scoreContainer, self.faLB);
    
    [@[ self.hiyLB, self.evLB, self.seLB, self.faLB ]
     mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.mas_equalTo(DEVICE_WIDTH / 4);
    }];
    
    [self.hiyLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(_scoreContainer);
    }];
    
    [self.evLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.hiyLB.mas_right).with.inset(10);
      make.top.equalTo(_scoreContainer);
      make.right.equalTo(_scoreContainer);
    }];
    
    [self.seLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.hiyLB.mas_bottom).with.inset(2);
      make.left.equalTo(self.hiyLB);
      make.bottom.equalTo(_scoreContainer);
    }];
    
    [self.faLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.seLB);
      make.left.equalTo(self.evLB);
      make.bottom.equalTo(_scoreContainer);
    }];
  }
  return _scoreContainer;
}

- (RemarkScoreView *)hiyLB {
  if (!_hiyLB) { _hiyLB = [[RemarkScoreView alloc] initWithTitle:@"卫生"]; }
  return _hiyLB;
}

- (RemarkScoreView *)evLB {
  if (!_evLB) { _evLB = [[RemarkScoreView alloc] initWithTitle:@"环境"]; }
  return _evLB;
}

- (RemarkScoreView *)seLB {
  if (!_seLB) { _seLB = [[RemarkScoreView alloc] initWithTitle:@"服务"]; }
  return _seLB;
}

- (RemarkScoreView *)faLB {
  if (!_faLB) { _faLB = [[RemarkScoreView alloc] initWithTitle:@"设施"]; }
  return _faLB;
}

- (void)setModel:(HotelModel *)model {
  _model = model;
  self.avgScore.attributedText = [self generateAvgScore:model.hotelSource];
  self.hiyLB.scoreGrade = @"4.1";
  self.evLB.scoreGrade = @"4.2";
  self.seLB.scoreGrade = @"4";
  self.faLB.scoreGrade = @"3";
}
@end
