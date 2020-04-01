//
//  ProfileStatusCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/27.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ProfileStatusCell.h"
#import "CardBagView.h"
#import "CreditView.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "RecommondController.h"

@interface ProfileStatusCell () <GenerateEntityDelegate>
@property (nonatomic, strong) QMUIGridView *statusGridView;
@end

@implementation ProfileStatusCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.qmui_borderColor = UIColor.qd_separatorColor;
  self.qmui_borderPosition = QMUIViewBorderPositionBottom;
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
  addView(superview, self.statusGridView);
  
  CGSize size = [self.statusGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH, MAXFLOAT)];
  [self.statusGridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(superview);
    make.centerY.equalTo(superview);
    make.height.mas_equalTo(size.height);
  }];
}

- (QMUIGridView *)statusGridView {
  if (!_statusGridView) {
    _statusGridView = [[QMUIGridView alloc] initWithColumn:2 rowHeight:DEVICE_HEIGHT / 10];
    _statusGridView.separatorWidth = 0.5;
    CreditView *cv = [CreditView new];
    addView(_statusGridView, cv);
    CardBagView *cbv = [CardBagView new];
    cbv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(go2CardBag:)];
    [cbv addGestureRecognizer:tap];
    addView(_statusGridView, cbv);
  }
  return _statusGridView;
}

- (void)go2CardBag:(UITapGestureRecognizer *)tap {
  [self.qmui_viewController.navigationController pushViewController:[RecommondController new]
                                                           animated:YES];
}
@end
