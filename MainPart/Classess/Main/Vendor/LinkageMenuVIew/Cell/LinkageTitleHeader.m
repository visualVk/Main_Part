//
//  LinkageTitleHeader.m
//  LinkageMenu
//
//  Created by blacksky on 2020/2/26.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LinkageTitleHeader.h"
#import "MarkUtils.h"

@interface LinkageTitleHeader ()
@end

@implementation LinkageTitleHeader

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.font = UIFontBoldMake(18);
    _title.text = @"默认";
    addView(self, _title);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.bottom.equalTo(self).with.inset(10);
      make.right.equalTo(self).with.inset(10);
    }];
  }
  return _title;
}
@end
