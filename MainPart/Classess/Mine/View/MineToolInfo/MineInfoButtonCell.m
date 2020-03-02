//
//  MineInfoButtonCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineInfoButtonCell.h"
#import "MarkUtils.h"

@interface MineInfoButtonCell () <GenerateEntityDelegate>

@end

@implementation MineInfoButtonCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.backgroundColor = UIColor.clearColor;
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
  addView(self.contentView, self.addInfo);
  [self.addInfo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).with.inset(0.5 * SPACE);
  }];
}

- (QMUIButton *)addInfo {
  if (!_addInfo) {
    _addInfo = [QDUIHelper generateLightBorderedButton];
    _addInfo.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [_addInfo setBackgroundColor:UIColor.clearColor];
    [_addInfo setTitle:@"新增常用旅客信息" forState:UIControlStateNormal];
    [_addInfo setImage:UIImageMake(@"add") forState:UIControlStateNormal];
    _addInfo.imagePosition = QMUIButtonImagePositionLeft;
    [_addInfo addTarget:self
                 action:@selector(addClick)
       forControlEvents:UIControlEventTouchUpInside];
  }
  return _addInfo;
}

- (void)addClick {
  QMUILogInfo(@"mine info button cell", @"click add info");
}
@end
