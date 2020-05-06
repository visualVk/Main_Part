//
//  RepertoireCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/1.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RepertoireCell.h"
#import "MarkUtils.h"
#import <SJAttributesFactory.h>
const NSInteger IMAGEINDEX = 20000;
@interface RepertoireCell () <GenerateEntityDelegate, QMUIImagePreviewViewDelegate>
@property (nonatomic, strong) QMUIGridView *imageGridView;
@property (nonatomic, strong) QMUIImagePreviewViewController *imagePreviewViewController;
@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) QMUIButton *deleteBtn;
@property (nonatomic, strong) QMUIButton *editBtn;
@end

@implementation RepertoireCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.datas = @[ @"pink_gradient", @"pink_gradient", @"pink_gradient", @"pink_gradient" ];
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)prepareForReuse {
  [super prepareForReuse];
  [self.imageGridView qmui_removeAllSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.title);
  addView(superview, self.imageGridView);
  addView(superview, self.log);
  addView(superview, self.logDate);
  addView(superview, self.deleteBtn);
  addView(superview, self.editBtn);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  CGSize gridSize = [self.imageGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH - SPACE, MAXFLOAT)];
  [self.imageGridView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.title);
    make.top.equalTo(self.title.mas_bottom).with.inset(0.25 * SPACE);
    make.height.mas_equalTo(gridSize.height);
  }];
  
  [self.log mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageGridView);
    make.top.equalTo(self.imageGridView.mas_bottom).with.inset(0.25 * SPACE);
    //    make.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
  
  [@[ self.deleteBtn, self.editBtn ] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.log.mas_bottom).with.inset(5);
  }];
  
  [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(superview).with.inset(0.25 * SPACE);
  }];
  
  [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.editBtn.mas_leading).with.inset(0.5 * SPACE);
  }];
  
  [self.logDate mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.log);
    make.top.equalTo(self.deleteBtn.mas_bottom).with.inset(0.25 * SPACE);
    make.bottom.equalTo(superview).with.inset(0.5 * SPACE);
  }];
}

- (QMUIGridView *)imageGridView {
  if (!_imageGridView) {
    _imageGridView = [[QMUIGridView alloc] initWithColumn:4 rowHeight:(DEVICE_WIDTH - 6) / 4];
    _imageGridView.separatorWidth = 2;
    _imageGridView.separatorColor = UIColor.clearColor;
    //    [self addImage:_imageGridView];
  }
  return _imageGridView;
}

- (UILabel *)log {
  if (!_log) {
    _log = [UILabel new];
    _log.numberOfLines = 0;
    _log.text = @"暂无描述";
    _log.textColor = UIColor.qd_mainTextColor;
    _log.font = UIFontMake(16);
    _log.lineBreakMode = NSLineBreakByTruncatingMiddle;
  }
  return _log;
}

- (UILabel *)logDate {
  if (!_logDate) {
    _logDate = [UILabel new];
    _logDate.textColor = UIColor.qd_placeholderColor;
    _logDate.font = UIFontMake(14);
    _logDate.text = @"2019.01.02";
    _logDate.textAlignment = NSTextAlignmentRight;
  }
  return _logDate;
}

- (UILabel *)title {
  if (!_title) {
    _title = [UILabel new];
    _title.text = @"点点滴滴";
    _title.textColor = UIColor.qd_mainTextColor;
    _title.font = UIFontBoldMake(18);
  }
  return _title;
}

- (void)addImage:(UIView *)view {
  UIImageView *image = nil;
  NSInteger i = 0;
  for (NSString *imageName in self.datas) {
    image = [UIImageView new];
    image.userInteractionEnabled = YES;
    [image sd_setImageWithURL:[NSURL URLWithString:imageName]
             placeholderImage:UIImageMake(imageName)];
    image.contentMode = QMUIImageResizingModeScaleAspectFill;
    image.tag = IMAGEINDEX + i;
    i++;
    [self addTap:image];
    [view addSubview:image];
  }
}

- (QMUIButton *)deleteBtn {
  if (!_deleteBtn) {
    _deleteBtn = [QMUIButton new];
    [_deleteBtn setImage:UIImageMake(@"delete") forState:UIControlStateNormal];
  }
  return _deleteBtn;
}

- (QMUIButton *)editBtn {
  if (!_editBtn) {
    _editBtn = [QMUIButton new];
    [_editBtn setImage:UIImageMake(@"edit") forState:UIControlStateNormal];
  }
  return _editBtn;
}

- (void)addTap:(UIView *)view {
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
  [view addGestureRecognizer:tap];
}

- (void)selectImage:(UITapGestureRecognizer *)gesture {
  UIImageView *image = gesture.qmui_targetView;
  if (!self.parentController) self.parentController = self.qmui_viewController;
  if (!self.imagePreviewViewController) {
    self.imagePreviewViewController = [[QMUIImagePreviewViewController alloc] init];
    self.imagePreviewViewController.presentingStyle =
    QMUIImagePreviewViewControllerTransitioningStyleZoom;
    self.imagePreviewViewController.imagePreviewView.delegate = self;
  }
  [self.imagePreviewViewController.imagePreviewView setCurrentImageIndex:image.tag - IMAGEINDEX
                                                                animated:YES];
  [self.parentController presentViewController:self.imagePreviewViewController
                                      animated:YES
                                    completion:nil];
}

#pragma mark - QMUIImagePreviewViewDelegate
- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView
                             assetTypeAtIndex:(NSUInteger)index {
  return QMUIImagePreviewMediaTypeImage;
}

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
  return self.datas.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView
     renderZoomImageView:(QMUIZoomImageView *)zoomImageView
                 atIndex:(NSUInteger)index {
  zoomImageView.reusedIdentifier = @(index);
  UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
  [imageview sd_setImageWithURL:[NSURL URLWithString:self.datas[index]]
               placeholderImage:UIImageMake(@"pink_gradient")];
  zoomImageView.image = imageview.image;
  [zoomImageView hideEmptyView];
}

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView
                             location:(CGPoint)location {
  //  if ([self.self_delegate
  //  respondsToSelector:@selector(singleTouchInZoomingImageView:location:)]) {
  //    [self.self_delegate singleTouchInZoomingImageView:zoomImageView location:location];
  //  }
  [self.parentController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData:(Log *)log {
  self.datas = log.imageList;
  QMUILogInfo(@"repertoire cell", @"name:%@", self.datas[0]);
  self.log.text = log.log;
  [self addImage:self.imageGridView];
  CGSize gridSize = [self.imageGridView sizeThatFits:CGSizeMake(DEVICE_WIDTH - SPACE, MAXFLOAT)];
  [self.imageGridView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(gridSize.height);
  }];
  [self setNeedsLayout];
  [self layoutIfNeeded];
}
@end
