//
//  LVCalendarCell.m
//  CalendarTest
//
//  Created by 吕亚斌 on 2018/4/8.
//  Copyright © 2018年 吕亚斌. All rights reserved.
//

#import "LVCalendarCell.h"
#import "UIColor+Hex.h"

@interface LVCalendarCell()
@property(nonatomic,strong) UIImageView* myImageView;
@end
@implementation LVCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        CALayer *selectionLayer = [[CALayer alloc] init];
        CAShapeLayer *selectionLayer =[CAShapeLayer layer];
        selectionLayer.frame = self.selectionLayer.bounds;
//        selectionLayer.backgroundColor = [UIColor colorWithHexString:@"#24555B"].CGColor;
        selectionLayer.actions = @{@"hidden": [NSNull null]};
         //UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0,0,53.8,38} cornerRadius:10];

        selectionLayer.strokeColor = [UIColor blackColor].CGColor;
        selectionLayer.fillColor = [UIColor blueColor].CGColor;
        selectionLayer.lineWidth =1;
        //selectionLayer.path = path.CGPath;
     
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        //这里是与触发相连
        self.selectionLayer = selectionLayer;
        
        //根据类型返回
        
        
        CALayer *middleLayer = [[CALayer alloc] init];
        middleLayer.backgroundColor = [UIColor colorWithHexString:@"#29B5EB" alpha:0.3].CGColor;
        middleLayer.actions = @{@"hidden": [NSNull null]};
        [self.contentView.layer insertSublayer:middleLayer below:self.selectionLayer];
        self.middleLayer = middleLayer;
        // false很关键默认选择有 true 默认选择有无
        self.shapeLayer.hidden = NO;
        
     
       
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.selectionLayer.frame = self.contentView.bounds;
    self.middleLayer.frame = self.contentView.bounds;
       self.selectionLayer.contentsGravity = kCAGravityResize;
    if(_selectionType == middle){
        self.selectionLayer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    }
    else if (_selectionType == leftBorder ){
        self.selectionLayer.contents = (id)[UIImage imageNamed:@"left"].CGImage;
    }
    else if (_selectionType == rightBorder ){
        self.selectionLayer.contents = (id)[UIImage imageNamed:@"right"].CGImage;
    }
}
@end
