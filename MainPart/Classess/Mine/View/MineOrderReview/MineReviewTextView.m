//
//  MineReviewTextView.m
//  MainPart
//
//  Created by blacksky on 2020/4/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineReviewTextView.h"
#import "FMLStarView.h"
#import "MarkUtils.h"

@interface MineReviewTextView () <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUITextView *reviewTX;
@property (nonatomic, strong) UIView *container;
@end

@implementation MineReviewTextView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  addView(self, self.container);
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.equalTo(self);
    //    make.height.mas_equalTo(400);
    make.bottom.equalTo(self);
  }];
  //  [self mas_makeConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(self.container);
  //  }];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.font = UIFontMake(20);
    _title.textColor = UIColor.blackColor;
    _title.text = @"评价(可空)";
  }
  return _title;
}

- (QMUITextView *)reviewTX {
  if (!_reviewTX) {
    _reviewTX = [[QMUITextView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 400)];
    _reviewTX.font = UIFontMake(18);
    _reviewTX.placeholder = @"撰写评论";
    _reviewTX.placeholderColor = UIColor.qd_placeholderColor;
    _reviewTX.editable = YES;
    _reviewTX.selectable = YES;
    _reviewTX.layer.cornerRadius = 6.0;
    _reviewTX.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _reviewTX.layer.borderWidth = 1 / ([UIScreen mainScreen].scale);
  }
  return _reviewTX;
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    
    addView(_container, self.reviewTX);
    [self.reviewTX mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.left.right.top.equalTo(_container);
      //      make.
    }];
    
    //    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
    //      make.bottom.equalTo(self.reviewTX).with.inset(10);
    //    }];
  }
  return _container;
}

@end
