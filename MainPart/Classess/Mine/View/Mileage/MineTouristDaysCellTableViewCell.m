//
//  MineTouristDaysCellTableViewCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineTouristDaysCellTableViewCell.h"
#import "MarkUtils.h"
#import <AAChartKit.h>

@interface MineTouristDaysCellTableViewCell () <GenerateEntityDelegate>
@property (nonatomic, strong) AAChartView *chartView;
@end

@implementation MineTouristDaysCellTableViewCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
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
  addView(superview, self.chartView);
  
  [self.chartView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
}

- (AAChartView *)chartView {
  if (!_chartView) {
    _chartView = [[AAChartView alloc] init];
    _chartView.scrollEnabled = false;
    [_chartView aa_drawChartWithChartModel:[self configureColumnrangeMixedLineChart]];
  }
  return _chartView;
}

- (AAChartModel *)configureColumnrangeMixedLineChart {
  return AAChartModel.new.titleSet(@"各星级酒店外宿天数统计")
  .yAxisTitleSet(@"天")
  .markerRadiusSet(@6)
  .yAxisVisibleSet(true)
  .yAxisGridLineWidthSet(@0)
  .markerSymbolStyleSet(AAChartSymbolStyleTypeBorderBlank)
  .chartTypeSet(AAChartTypeLine)
  .categoriesSet(@[
    @"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月",
    @"十一月", @"十二月"
  ])
  .dataLabelsEnabledSet(true)
  .colorsThemeSet(@[
    @"#1e90ff",
    @"#EA007B",
    @"#49C1B6",
    @"#FDC20A",
    @"#F78320",
    @"#068E81",
  ])
  .seriesSet(@[
    AASeriesElement.new.typeSet(AAChartTypeColumn).nameSet(@"外宿天数").dataSet(@[
      @[ @9.4 ],
      @[ @6.5 ],
      @[ @9.4 ],
      @[ @19.9 ],
      @[ @22.6 ],
      @[ @29.5 ],
      @[ @30.7 ],
      @[ @26.5 ],
      @[ @18.0 ],
      @[ @11.4 ],
      @[ @10.4 ],
      @[ @16.8 ],
    ]),
    AASeriesElement.new.typeSet(AAChartTypeLine).nameSet(@"民宿").dataSet(@[
      @2, @3.1, @4.1, @5.1, @18.2, @23.5, @22.2, @27.5, @29.3, @15.3, @10.9, @5.6
    ]),
    AASeriesElement.new.typeSet(AAChartTypeLine).nameSet(@"二星").dataSet(@[
      @7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6
    ]),
    AASeriesElement.new.typeSet(AAChartTypeLine).nameSet(@"三星").dataSet(@[
      @-0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5
    ]),
    AASeriesElement.new.typeSet(AAChartTypeLine).nameSet(@"四星").dataSet(@[
      @-0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0
    ]),
    AASeriesElement.new.typeSet(AAChartTypeLine).nameSet(@"五星").dataSet(@[
      @3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8
    ]),
  ]);
}
@end
