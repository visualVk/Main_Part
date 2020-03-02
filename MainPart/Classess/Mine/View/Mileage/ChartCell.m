//
//  ChartCell.m
//  MainPart
//
//  Created by blacksky on 2020/2/29.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ChartCell.h"
#import "MarkUtils.h"
#import <AAChartKit.h>

@interface ChartCell ()
@property (nonatomic, strong) AAChartView *chartView;
@end

@implementation ChartCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  //  [self addLineChart];
  [self addPieChart];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)addLineChart {
  AAChartModel *aaChartModel =
  AAObject(AAChartModel)
  .chartTypeSet(AAChartTypeArea)
  .titleSet(@"酒店消费")
  .subtitleSet(@"吃+住")
  .categoriesSet(@[
    @"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月",
    @"11月", @"12月", @"13"
  ])
  .yAxisTitleSet(@"元/月")
  .seriesSet(@[
    AAObject(AASeriesElement).nameSet(@"2017").dataSet(@[
      @7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6, @1515
    ]),
    AAObject(AASeriesElement).nameSet(@"2018").dataSet(@[
      @0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5, @1515
    ]),
    AAObject(AASeriesElement).nameSet(@"2019").dataSet(@[
      @0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0, @1212
    ]),
    AAObject(AASeriesElement).nameSet(@"2020").dataSet(@[
      @3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8, @200
    ]),
  ]);
  aaChartModel.zoomType = AAChartZoomTypeX;
  [self.chartView aa_drawChartWithChartModel:aaChartModel];
}

- (void)addPieChart {
  AASeriesElement *element =
  AASeriesElement.new.nameSet(@"酒店星级占比")
  .innerSizeSet(@"20%") //内部圆环半径大小占比
  //    .sizeSet(@300)//尺寸大小
  .borderWidthSet(@0) //描边的宽度
  .allowPointSelectSet(true) //是否允许在点击数据点标记(扇形图点击选中的块发生位移)
  .statesSet(
             @{ @"hover" : @{@"enabled" : @(false)} })
  .dataSet(@[
    @[ @"5星", @3336.2 ],
    @[ @"4星", @26.8 ],
    @{
      @"sliced" : @true,
      @"selected" : @true,
      @"name" : @"3星",
      @"y" : @666.8,
    },
    @[ @"2星", @88.5 ],
    @[ @"1星", @46.0 ],
    @[ @"名宿", @223.0 ],
  ]);
  AAChartModel *aaChartModel =
  AAObject(AAChartModel)
  .chartTypeSet(AAChartTypePie)
  .colorsThemeSet(
                  @[ @"#0c9674", @"#7dffc0", @"#ff3333", @"#facd32", @"#ffffa0", @"#EA007B" ])
  .titleSet(@"")
  .subtitleSet(@"")
  .dataLabelsEnabledSet(true) //是否直接显示扇形图数据
  .yAxisTitleSet(@"摄氏度")
  .seriesSet(@[ element ]);
  [self.chartView aa_drawChartWithChartModel:aaChartModel];
}

- (AAChartView *)chartView {
  if (!_chartView) {
    _chartView = [[AAChartView alloc] init];
    addView(self.contentView, _chartView);
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.equalTo(self.contentView);
      make.top.bottom.equalTo(self.contentView);
    }];
  }
  return _chartView;
}
@end
