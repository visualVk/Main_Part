
//
//  RecToolBar.m
//  MainPart
//
//  Created by blacksky on 2020/3/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RecToolBar.h"
#import "MarkUtils.h"

@interface RecToolBar () <GenerateEntityDelegate> {
  BOOL detailSelected;
  BOOL favorSelected;
  BOOL discountSelected;
}
@property (nonatomic, strong) QMUIButton *detailBtn;
@property (nonatomic, strong) QMUIButton *favorBtn;
@property (nonatomic, strong) QMUIButton *discoutBtn;
@property (nonatomic, strong) UIView *container;
@end

@implementation RecToolBar

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.discoutBtn.layer.cornerRadius = self.discoutBtn.frame.size.height / 2;
  //  self.discoutBtn.layer.borderWidth = 1;
  self.discoutBtn.layer.borderColor = UIColor.clearColor.CGColor;
  self.discoutBtn.layer.masksToBounds = YES;
  
  self.detailBtn.layer.cornerRadius = self.detailBtn.frame.size.height / 2;
  //  self.detailBtn.layer.borderWidth = 1;
  self.detailBtn.layer.borderColor = UIColor.clearColor.CGColor;
  self.detailBtn.layer.masksToBounds = YES;
  
  self.favorBtn.layer.cornerRadius = self.favorBtn.frame.size.height / 2;
  self.favorBtn.layer.borderWidth = 1;
  self.favorBtn.layer.borderColor = UIColor.whiteColor.CGColor;
  self.favorBtn.layer.masksToBounds = YES;
}

- (void)generateRootView {
  addView(self, self.container);
  
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.discoutBtn);
    addView(_container, self.favorBtn);
    addView(_container, self.detailBtn);
    
    [@[ self.discoutBtn, self.favorBtn, self.detailBtn ]
     mas_makeConstraints:^(MASConstraintMaker *make) { make.top.bottom.equalTo(_container); }];
    
    [@[ self.discoutBtn, self.favorBtn, self.detailBtn ]
     mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
     withFixedItemLength:DEVICE_HEIGHT / 12
     leadSpacing:(DEVICE_WIDTH - DEVICE_HEIGHT / 12) / 6
     tailSpacing:(DEVICE_WIDTH - DEVICE_HEIGHT / 12) / 6];
  }
  return _container;
}

- (QMUIButton *)discoutBtn {
  if (!_discoutBtn) {
    _discoutBtn = [QMUIButton new];
    [_discoutBtn setTintColorAdjustsTitleAndImage:UIColor.whiteColor];
    [_discoutBtn setBackgroundColor:UIColorMakeWithHex(@"#DE4313")];
    [_discoutBtn setTitle:@"优惠" forState:UIControlStateNormal];
    [_discoutBtn setImage:UIImageMake(@"discount_unselected") forState:UIControlStateNormal];
    _discoutBtn.imagePosition = QMUIButtonImagePositionTop;
    _discoutBtn.tag = 1;
    _discoutBtn.titleLabel.font = UIFontMake(16);
    _discoutBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    //    [_discoutBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_discoutBtn addTarget:self
                    action:@selector(btnClick:)
          forControlEvents:UIControlEventTouchUpInside];
  }
  return _discoutBtn;
}

- (QMUIButton *)favorBtn {
  if (!_favorBtn) {
    _favorBtn = [QMUIButton new];
    _favorBtn.tag = 2;
    [_favorBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_favorBtn setImage:UIImageMake(@"favor_unselected") forState:UIControlStateNormal];
    _favorBtn.imagePosition = QMUIButtonImagePositionTop;
    _favorBtn.titleLabel.font = UIFontMake(16);
    _favorBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    [_favorBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_favorBtn addTarget:self
                  action:@selector(btnClick:)
        forControlEvents:UIControlEventTouchUpInside];
  }
  return _favorBtn;
}

- (QMUIButton *)detailBtn {
  if (!_detailBtn) {
    _detailBtn = [QMUIButton new];
    _detailBtn.tag = 3;
    [_detailBtn setTintColorAdjustsTitleAndImage:UIColor.whiteColor];
    [_detailBtn setBackgroundColor:UIColor.qd_tintColor];
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setImage:UIImageMake(@"detail_unselected") forState:UIControlStateNormal];
    _detailBtn.imagePosition = QMUIButtonImagePositionTop;
    _detailBtn.titleLabel.font = UIFontLightMake(15);
    _detailBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    [_detailBtn addTarget:self
                   action:@selector(btnClick:)
         forControlEvents:UIControlEventTouchUpInside];
  }
  return _detailBtn;
}

#pragma mark - private click event
- (void)btnClick:(QMUIButton *)button {
  NSInteger tag = button.tag;
  if (tag == 1) {
    QMUILogInfo(@"rec tool bar", @"tag 1");
    if (self.discountBlock) self.discountBlock(tag);
    //    if (!detailSelected) {
    //      [self.discoutBtn setBackgroundColor:UIColor.orangeColor];
    //      [self.discoutBtn
    //       setTintColorAdjustsTitleAndImage:[[UIColor blackColor] colorWithAlphaComponent:0.45]];
    //      self.discoutBtn.layer.borderColor = UIColor.clearColor.CGColor;
    //    } else {
    //      [self.discoutBtn setBackgroundColor:UIColor.clearColor];
    //      [self.discoutBtn setTintColorAdjustsTitleAndImage:UIColor.whiteColor];
    //      self.discoutBtn.layer.borderColor = UIColor.whiteColor.CGColor;
    //    }
  } else if (tag == 2) {
    QMUILogInfo(@"rec tool bar", @"tag 2");
    if (self.favorBtn) self.favorBlock(tag);
    if (!detailSelected) {
      [self.favorBtn setBackgroundColor:UIColorMakeWithHex(@"#F8D800")];
      [self.favorBtn setTintColorAdjustsTitleAndImage:UIColor.whiteColor];
      self.favorBtn.layer.borderColor = UIColor.clearColor.CGColor;
    } else {
      [self.favorBtn setBackgroundColor:UIColor.clearColor];
      [self.favorBtn setTintColorAdjustsTitleAndImage:UIColor.whiteColor];
      self.favorBtn.layer.borderColor = UIColor.whiteColor.CGColor;
    }
  } else if (tag == 3) {
    QMUILogInfo(@"rec tool bar", @"tag 3");
  }
  detailSelected = !detailSelected;
}
@end
