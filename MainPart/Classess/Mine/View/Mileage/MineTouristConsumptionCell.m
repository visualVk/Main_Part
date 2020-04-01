//
//  MineTouristConsumptionCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/19.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MineTouristConsumptionCell.h"
#import "MarkUtils.h"
#import <AAChartKit.h>
@interface MineTouristConsumptionCell () <GenerateEntityDelegate>
@property (nonatomic, strong) AAChartView *chartView;
@end

@implementation MineTouristConsumptionCell

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
    [_chartView aa_drawChartWithChartModel:[self configureStackingColumnMixedLineChart]];
  }
  return _chartView;
}

- (AAChartModel *)configureStackingColumnMixedLineChart {
  return AAChartModel.new.chartTypeSet(AAChartTypeColumn)
  .titleSet(@"2020年外宿消费统计")
  .subtitleSet(@"")
  .yAxisTitleSet(@"")
  .stackingSet(AAChartStackingTypeNormal)
  .seriesSet(@[
    AASeriesElement.new.nameSet(@"一星")
    .colorSet((id)AAGradientColor.mysticMauveColor)
    .dataSet(@[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11 ])
    .dataLabelsSet(AADataLabels.new.enabledSet(YES).styleSet(
                                                             AAStyle.new.colorSet(@"#000000").fontSizeSet(@"11px"))),
    AASeriesElement.new.nameSet(@"二星")
    .colorSet((id)AAGradientColor.deepSeaColor)
    .dataSet(@[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11 ])
    .dataLabelsSet(AADataLabels.new.enabledSet(YES).styleSet(
                                                             AAStyle.new.colorSet(@"#000000").fontSizeSet(@"11px"))),
    AASeriesElement.new.typeSet(AAChartTypeLine)
    .lineWidthSet(@5)
    .nameSet(@"总量")
    .colorSet((id)AAGradientColor.sanguineColor)
    .dataSet(@[ @0, @2, @4, @6, @8, @10, @12, @14, @16, @18, @20, @22 ])
    .dataLabelsSet(AADataLabels.new.enabledSet(YES).styleSet(
                                                             AAStyle.new.colorSet(@"#000000")
                                                             .fontSizeSet(@"15px")
                                                             .fontWeightSet(AAChartFontWeightTypeBold)))
    .markerSet(
               AAMarker.new
               .radiusSet(@7)                      //曲线连接点半径，默认是4
               .symbolSet(AAChartSymbolTypeCircle) //曲线点类型："circle", "square", "diamond",
               //"triangle","triangle-down"，默认是"circle"
               .fillColorSet(@"#ffffff") //点的填充色(用来设置折线连接点的填充色)
               .lineWidthSet(@3) //外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
               .lineColorSet(
                             @"") //外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色)
               ),
  ]);
}
@end
