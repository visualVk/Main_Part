//
//  SceneHeaderCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SceneHeaderCell.h"
#import "MarkUtils.h"

@interface SceneHeaderCell ()<GenerateEntityDelegate>

@end

@implementation SceneHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)generateRootView{
  
}

- (UILabel *)title{
  if(!_title){
    _title = [UILabel new];
    _title.textColor = UIColor.qd_mainTextColor;
    _title.text = @"九寨沟风景区";
    _title.font = UIFontBoldMake(22);
  }
  return _title;
}

- (UILabel *)phrase{
  if(!_phrase){
    _phrase = [UILabel new];
    _phrase.text = @"”九寨沟归来不看水“";
    _phrase.textColor = UIColor.qd_tintColor;
    _phrase.text
  }
}
@end
