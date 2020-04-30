//
//  QuestionAnsDetailCell.m
//  MainPart
//
//  Created by blacksky on 2020/4/30.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "QuestionAnsDetailCell.h"
#import "MarkUtils.h"

@interface QuestionAnsDetailCell () <GenerateEntityDelegate>
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *avatorImg;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) QMUILabel *status;
@property (nonatomic, strong) UILabel *ans;
@property (nonatomic, strong) UILabel *ansDate;
@end

@implementation QuestionAnsDetailCell

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
  addView(superview, self.container);
  [self.container
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (UIView *)container {
  if (!_container) {
    _container = [UIView new];
    addView(_container, self.avatorImg);
    addView(_container, self.username);
    addView(_container, self.status);
    addView(_container, self.ans);
    addView(_container, self.ansDate);
    
    [self.avatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(30, 30));
      make.top.left.equalTo(_container).with.inset(15);
    }];
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.avatorImg);
      make.left.equalTo(self.avatorImg.mas_right).with.inset(15);
    }];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.username.mas_right).with.inset(5);
      make.centerY.equalTo(self.avatorImg);
    }];
    
    [self.ans mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.avatorImg.mas_bottom).with.inset(15);
      make.left.equalTo(self.username);
      make.right.equalTo(_container).with.inset(15);
    }];
    
    [self.ansDate mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.ans.mas_bottom).with.inset(10);
      make.left.equalTo(self.ans);
      make.bottom.equalTo(_container).with.inset(15);
    }];
  }
  return _container;
}

- (UIImageView *)avatorImg {
  if (!_avatorImg) {
    _avatorImg = [UIImageView new];
    _avatorImg.layer.cornerRadius = 15;
    _avatorImg.layer.masksToBounds = YES;
    _avatorImg.image = UIImageMake(@"pink_gradient");
  }
  return _avatorImg;
}

- (UILabel *)username {
  if (!_username) {
    _username = [UILabel new];
    _username.text = @"小草";
    _username.font = UIFontMake(14);
    _username.textColor = UIColor.lightGrayColor;
  }
  return _username;
}

- (UILabel *)ans {
  if (!_ans) {
    _ans = [UILabel new];
    _ans.font = UIFontMake(16);
    _ans.numberOfLines = 0;
    _ans.text = @"临时互答";
  }
  return _ans;
}

- (QMUILabel *)status {
  if (!_status) {
    _status = [QMUILabel new];
    _status.font = UIFontMake(14);
    _status.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _status.layer.cornerRadius = 4;
    _status.layer.masksToBounds = YES;
    _status.highlightedBackgroundColor = nil;
    _status.highlightedTextColor = nil;
    _status.textColor = UIColor.systemGreenColor;
    _status.layer.borderColor = UIColor.systemGreenColor.CGColor;
    _status.layer.borderWidth = 0.5;
    _status.text = @"住客";
  }
  return _status;
}

- (UILabel *)ansDate {
  if (!_ansDate) {
    _ansDate = [UILabel new];
    _ansDate.text = @"2019-06-12 回答";
    _ansDate.textColor = UIColor.lightGrayColor;
    _ansDate.font = UIFontMake(14);
  }
  return _ansDate;
}
@end
