//
//  SpotRotationView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/18.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SpotRotationView.h"
#import <JQCollectionViewAlignLayout/JQCollectionViewAlignLayout.h>
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "RotationHeaderView.h"
#import "RotationImageCell.h"
#define FLOWHEIGHT DEVICE_HEIGHT / 15
#define HEADERVIEW @"collectionheader"
#define IMAGECELL @"imagecell"
@interface SpotRotationView () <GenerateEntityDelegate, JQCollectionViewAlignLayoutDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) BOOL isBack;
///正面view
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) QMUIFloatLayoutView *floatLayoutView;
@property (nonatomic, strong) QMUILabel *nameLB;
@property (nonatomic, strong) QMUILabel *briefLB;
@property (nonatomic, strong) QMUILabel *scoreLB;
@property (nonatomic, strong) QMUILabel *priceLB;
@property (nonatomic, strong) QMUIButton *moreBtn;
@property (nonatomic, strong) QMUILabel *addressLB;
///反面view
@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation SpotRotationView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    //    self.contentView.backgroundColor = UIColor.qmui_randomColor;
    //图片抗锯齿处理
    self.contentView.layer.allowsEdgeAntialiasing = YES;
    self.contentView.layer.shouldRasterize = YES;
    
    self.contentView.layer.cornerRadius = 10.0f;
    self.contentView.layer.masksToBounds = YES;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)prepareForReuse {
  [super prepareForReuse];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  self.frontView = [UIView new];
  self.frontView.userInteractionEnabled = YES;
  self.frontView.backgroundColor = UIColor.qmui_randomColor;
  self.backView = [UIView new];
  self.backView.userInteractionEnabled = YES;
  self.backView.backgroundColor = UIColor.qmui_randomColor;
  
  addView(superview, self.backView);
  addView(superview, self.frontView);
  addView(self.frontView, self.imageview);
  addView(self.frontView, self.floatLayoutView);
  addView(self.frontView, self.briefLB);
  addView(self.frontView, self.moreBtn);
  addView(self.frontView, self.priceLB);
  addView(self.frontView, self.nameLB);
  addView(self.frontView, self.scoreLB);
  addView(self.frontView, self.addressLB);
  
  [self.frontView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  [self generateFrontView];
  
  [self.backView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self.frontView); }];
  [self generateBackView];
  
  UITapGestureRecognizer *frontTap = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:[self selectorBlock:^(id _Nonnull args) {
    [SpotRotationView transitformShowView:self.backView hiddenView:self.frontView];
    self.isBack = !self.isBack;
  }]];
  [self.frontView addGestureRecognizer:frontTap];
  
  UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:[self selectorBlock:^(id _Nonnull args) {
    [SpotRotationView transitformShowView:self.frontView hiddenView:self.backView];
    self.isBack = !self.isBack;
  }]];
  [self.backView addGestureRecognizer:backTap];
}

- (void)generateFrontView {
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.frontView).offset(0.5 * SPACE);
    make.right.equalTo(self.frontView).offset(-0.5 * SPACE);
    make.height.equalTo(self.frontView.mas_width);
  }];
  
  [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.top.equalTo(self.imageview.mas_bottom).offset(0.5 * SPACE);
  }];
  
  [self.scoreLB
   mas_makeConstraints:^(MASConstraintMaker *make) { make.right.bottom.equalTo(self.nameLB); }];
  
  [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.top.equalTo(self.nameLB.mas_bottom).offset(0.5 * SPACE);
  }];
  
  [self.floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.top.equalTo(self.addressLB.mas_bottom).offset(0.5 * SPACE);
    make.height.equalTo(@(FLOWHEIGHT));
  }];
  
  [self.briefLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.top.equalTo(self.floatLayoutView.mas_bottom).offset(0.5 * SPACE);
    make.height.equalTo(@(FLOWHEIGHT));
  }];
  
  [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.imageview);
    make.bottom.equalTo(self.frontView).offset(-0.5 * SPACE);
  }];
  
  [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.imageview);
    make.bottom.equalTo(self.priceLB);
  }];
}

- (void)generateBackView {
  addView(self.backView, self.collectionview);
  
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.backView).offset(0.5 * SPACE);
    make.right.bottom.equalTo(self.backView).offset(-0.5 * SPACE);
  }];
}

+ (void)transitformShowView:(UIView *)view hiddenView:(UIView *)toView {
  view.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 1, 0);
  toView.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 0);
  [view.superview bringSubviewToFront:view];
  
  [UIView animateWithDuration:0.6
                        delay:0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{ toView.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 1, 0); }
                   completion:^(BOOL finished) {
    
    [view.superview bringSubviewToFront:view];
    
    [UIView
     animateWithDuration:0.6
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{ view.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0); }
     completion:nil];
    
  }];
}

- (void)loadData {
  [self.floatLayoutView qmui_removeAllSubviews];
  for (NSString *tag in self.datas) {
    QMUILabel *tagLB = [SpotRotationView TagLabel];
    tagLB.text = tag;
    [self.floatLayoutView addSubview:tagLB];
  }
  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    RotationImageCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IMAGECELL forIndexPath:indexPath];
    //    cell.layer.borderColor = UIColor.qd_mainTextColor.CGColor;
    //    cell.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:[self selectorBlock:^(id _Nonnull args) {
      QMUILogInfo(@"cell tap", @"section = %li, row = %li", indexPath.section,
                  indexPath.row);
    }]];
    [cell addGestureRecognizer:tap];
    return cell;
  }
  
  return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    RotationHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                    withReuseIdentifier:HEADERVIEW
                                                                           forIndexPath:indexPath];
    header.backgroundColor = UIColor.clearColor;
    return header;
  }
  return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  if (section == 0) { return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 20); }
  return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    return CGSizeMake(
                      self.collectionview.frame.size.width - self.collectionview.contentInset.left -
                      self.collectionview.contentInset.right - 10,
                      (self.collectionview.frame.size.width - 10 - self.collectionview.contentInset.left -
                       self.collectionview.contentInset.right) /
                      3);
  }
  return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"spot collection view", @"section=%li,row=%li", indexPath.section, indexPath.row);
}

#pragma mark - Lazy init
- (QMUILabel *)nameLB {
  if (!_nameLB) {
    _nameLB = [SpotRotationView GenerateCommonLabel];
    _nameLB.textColor = UIColor.qmui_randomColor;
    _nameLB.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _nameLB.font = UIFontBoldMake(24);
    _nameLB.text = @"万达";
    _nameLB.qmui_borderColor = UIColor.qmui_randomColor;
    _nameLB.qmui_borderWidth = 2.0f;
    _nameLB.qmui_borderPosition = QMUIViewBorderPositionBottom;
  }
  return _nameLB;
}

- (QMUILabel *)addressLB {
  if (!_addressLB) {
    _addressLB = [SpotRotationView GenerateCommonLabel];
    _addressLB.text = @"xxx省xxx市xxx区xxx路xxx号(xxx对面)";
    _addressLB.font = UIFontMake(14);
    _addressLB.textColor = UIColor.qd_placeholderColor;
  }
  return _addressLB;
}

- (QMUILabel *)scoreLB {
  if (!_scoreLB) {
    _scoreLB = [QMUILabel new];
    _scoreLB.textColor = UIColor.qmui_randomColor;
    _scoreLB.text = @"9.7";
    _scoreLB.font = UIFontBoldMake(21);
    _scoreLB.highlightedBackgroundColor = nil;
  }
  return _scoreLB;
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview = [UIImageView new];
    _imageview.image = UIImageMake(@"pink_gradient");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
    _imageview.layer.cornerRadius = 10;
    _imageview.layer.masksToBounds = YES;
  }
  return _imageview;
}

- (QMUILabel *)briefLB {
  if (!_briefLB) {
    _briefLB = [QMUILabel new];
    _briefLB.font = UIFontMake(16);
    _briefLB.textColor = UIColor.qd_placeholderColor;
    _briefLB.highlightedBackgroundColor = nil;
    _briefLB.numberOfLines = 0;
    _briefLB.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < 300; ++i) { [str appendString:@"很美丽"]; }
    _briefLB.text = str;
  }
  return _briefLB;
}

- (QMUIFloatLayoutView *)floatLayoutView {
  if (!_floatLayoutView) {
    _floatLayoutView = [[QMUIFloatLayoutView alloc] init];
    //    _floatLayoutView.frame = CGRectMake(0, 0, 0, QMUIViewSelfSizingHeight);
    _floatLayoutView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _floatLayoutView.itemMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    _floatLayoutView.minimumItemSize = CGSizeMake(35, 20);
    QMUILabel *tag = [SpotRotationView TagLabel];
    [_floatLayoutView addSubview:tag];
  }
  return _floatLayoutView;
}

- (QMUILabel *)priceLB {
  if (!_priceLB) {
    _priceLB = [QMUILabel new];
    _priceLB.font = UIFontBoldMake(24);
    _priceLB.textColor = UIColor.qmui_randomColor;
    _priceLB.text = @"999";
    _priceLB.highlightedBackgroundColor = nil;
  }
  return _priceLB;
}

- (QMUIButton *)moreBtn {
  if (!_moreBtn) {
    _moreBtn = [QDUIHelper generateLightBorderedButton];
    [_moreBtn setTitle:@"详细" forState:UIControlStateNormal];
    _moreBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
  }
  return _moreBtn;
}

- (UICollectionView *)collectionview {
  if (!_collectionview) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment = JQCollectionViewItemsHorizontalAlignmentCenter;
    layout.itemsVerticalAlignment = JQCollectionViewItemsVerticalAlignmentCenter;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.userInteractionEnabled = YES;
    [_collectionview registerClass:RotationImageCell.class forCellWithReuseIdentifier:IMAGECELL];
    [_collectionview registerClass:RotationHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:HEADERVIEW];
    _collectionview.backgroundColor = UIColor.clearColor;
    _collectionview.dataSource = self;
    _collectionview.delegate = self;
    _collectionview.scrollEnabled = YES;
    _collectionview.showsHorizontalScrollIndicator = false;
    _collectionview.showsVerticalScrollIndicator = false;
  }
  return _collectionview;
}

+ (QMUILabel *)TagLabel {
  QMUILabel *label = [QMUILabel new];
  label.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
  label.textAlignment = NSTextAlignmentCenter;
  label.layer.cornerRadius = 5.0f;
  label.layer.borderColor = UIColor.qmui_randomColor.CGColor;
  label.layer.masksToBounds = YES;
  label.clipsToBounds = YES;
  label.font = UIFontMake(14);
  label.text = @"OK";
  label.highlightedBackgroundColor = nil;
  label.backgroundColor = UIColor.qd_backgroundColor;
  return label;
}

+ (QMUILabel *)GenerateCommonLabel {
  QMUILabel *label = [QMUILabel new];
  label.highlightedTextColor = nil;
  label.highlightedBackgroundColor = nil;
  return label;
}

- (void)stateInit {
  if (self.isBack) {
    [SpotRotationView transitformShowView:self.frontView hiddenView:self.backView];
    self.isBack = !self.isBack;
  }
}
@end
