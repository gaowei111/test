//
//  ViewController.m
//  TestModel
//
//  Created by gw on 2016/12/2.
//  Copyright © 2016年 mirahome. All rights reserved.
//

#import "ViewController.h"
#import "WYLineChartView.h"
#import "WYLineChartPoint.h"
#import "WYChartCategory.h"
#import "WYLineChartCalculator.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<WYLineChartViewDelegate,WYLineChartViewDatasource>

@property (nonatomic,strong)WYLineChartView *chartView;

@property (nonatomic, strong) NSArray *points;

@property (nonatomic, strong) NSArray *yPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yPoint =@[@5,@10,@15,@20,@25,@30,@35];//@[@50,@60,@70,@80,@90,@100,@110,@120];//@[@2,@4,@6,@8,@10,@12];
    
    [self initView];
}

-(void)initView
{
    self.chartView =[[WYLineChartView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 300)];
    self.chartView.delegate =self;
    self.chartView.datasource =self;
    
    _chartView.labelsFont = [UIFont systemFontOfSize:13];
    _chartView.verticalReferenceLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _chartView.horizontalRefernenceLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _chartView.axisColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _chartView.labelsColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    _chartView.animationDuration =2.0;
    _chartView.animationStyle = kWYLineChartAnimationDrawing;
    _chartView.backgroundColor = [UIColor whiteColor];
    
    _chartView.scrollable = YES;
    _chartView.pinchable = NO;
    
    
     [self.view addSubview:_chartView];
}

- (void)viewDidAppear:(BOOL)animated {
    
   
    [self updateGraph];
}

- (void)updateGraph {
    
    NSArray *(^ProducePointsA)() = ^() {
        NSMutableArray *mutableArray = [NSMutableArray array];
        

        NSArray *points = [WYLineChartPoint pointsFromValueArray:@[@(19),@(21),@(22),@(23),@(21),@(18),@(17),@(20),@(19),@(21),@(21),@(23),@(22)]];
//        [mutableArray addObject:points];
        points = [WYLineChartPoint pointsFromValueArray:@[@(17),@(15.5),@(22),@(17),@(24),@(20),@(33),@(22),@(24),@(21)]];
        [mutableArray addObject:points];
        return mutableArray;
    };
    
    NSArray *(^ProducePointsB)() = ^() {
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *points = [WYLineChartPoint pointsFromValueArray:@[@(70706.89),@(75623.4),@(90980.f),@(80890.34),@(60321.2)]];
        [mutableArray addObject:points];
        points = [WYLineChartPoint pointsFromValueArray:@[@(50503.134),@(50446.85),@(50555.67),@(60216.48),@(50664.45),@(80890.34),@(30321.2)]];
        [mutableArray addObject:points];
        points = [WYLineChartPoint pointsFromValueArray:@[@(30706.89),@(40446.85),@(40555.67),@(20216.48),@(30664.45),@(20890.34),@(20321.2)]];
        [mutableArray addObject:points];
        return mutableArray;
    };
    
    static BOOL isPointsA = false;
    _points = !isPointsA ? ProducePointsA() : ProducePointsB();
    isPointsA = !isPointsA;
    
    _chartView.points = [NSArray arrayWithArray:_points];
    _chartView.yPoint = _yPoint;
    [_chartView updateGraph];
}

#pragma mark - WYLineChartViewDelegate

- (NSInteger)numberOfLabelOnXAxisInLineChartView:(WYLineChartView *)chartView {
    
    return [_points[0] count];
}

- (NSInteger)numberOfLabelOnYAxisInLineChartView:(WYLineChartView *)chartView {
    return self.yPoint.count;
}

- (CGFloat)gapBetweenPointsHorizontalInLineChartView:(WYLineChartView *)chartView {
    
    if (([_points[0] count]-1) *60.f<CGRectGetWidth(self.view.frame)) {
        return CGRectGetWidth(self.view.frame)/([_points[0] count]-1);
    }
    return 60.f;
}

- (NSInteger)numberOfReferenceLineVerticalInLineChartView:(WYLineChartView *)chartView {
    return [_points[0] count];
}

- (NSInteger)numberOfReferenceLineHorizontalInLineChartView:(WYLineChartView *)chartView {
    return 3;
}

- (void)lineChartView:(WYLineChartView *)lineView didBeganTouchAtSegmentOfPoint:(WYLineChartPoint *)originalPoint value:(CGFloat)value {
    //    NSLog(@"began move for value : %f", value);
//    _touchLabel.text = [NSString stringWithFormat:@"%f", value];
}

- (void)lineChartView:(WYLineChartView *)lineView didMovedTouchToSegmentOfPoint:(WYLineChartPoint *)originalPoint value:(CGFloat)value {
    //    NSLog(@"changed move for value : %f", value);
//    _touchLabel.text = [NSString stringWithFormat:@"%f", value];
}

- (void)lineChartView:(WYLineChartView *)lineView didEndedTouchToSegmentOfPoint:(WYLineChartPoint *)originalPoint value:(CGFloat)value {
    //    NSLog(@"ended move for value : %f", value);
//    _touchLabel.text = [NSString stringWithFormat:@"%f", value];
}

- (void)lineChartView:(WYLineChartView *)lineView didBeganPinchWithScale:(CGFloat)scale {
    
    //    NSLog(@"begin pinch, scale : %f", scale);
}

- (void)lineChartView:(WYLineChartView *)lineView didChangedPinchWithScale:(CGFloat)scale {
    
    //    NSLog(@"change pinch, scale : %f", scale);
}

- (void)lineChartView:(WYLineChartView *)lineView didEndedPinchGraphWithOption:(WYLineChartViewScaleOption)option scale:(CGFloat)scale {
    
    //    NSLog(@"end pinch, scale : %f", scale);
}

#pragma mark - WYLineChartViewDatasource

- (NSString *)lineChartView:(WYLineChartView *)chartView contextTextForPointAtIndexPath:(NSIndexPath *)indexPath {
    
    if((indexPath.row%3 != 0 && indexPath.section%2 != 0)
       || (indexPath.row%3 == 0 && indexPath.section%2 == 0)) return nil;
    
    NSArray *pointsArray = _chartView.points[indexPath.section];
    WYLineChartPoint *point = pointsArray[indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%lu", (NSInteger)point.value];
    return text;
}

- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForXAxisLabelAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%lu月", index+1];
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToXAxisLabelAtIndex:(NSInteger)index {
    return _points[0][index];
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToVerticalReferenceLineAtIndex:(NSInteger)index {
    
    return _points[0][index];
}

- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForYAxisLabelAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@h",self.yPoint[index]];
//    CGFloat value;
//    switch (index) {
//        case 0:
//            value = [self.chartView.calculator minValuePointsOfLinesPointSet:self.chartView.points].value;
//            break;
//        case 1:
//            value = [self.chartView.calculator maxValuePointsOfLinesPointSet:self.chartView.points].value;
//            break;
//        case 2:
//            value = [self.chartView.calculator calculateAverageForPointsSet:self.chartView.points];
//            break;
//        default:
//            break;
//    }
//    return [NSString stringWithFormat:@"%lu", (NSInteger)value];
}

- (CGFloat)lineChartView:(WYLineChartView *)chartView valueReferToYAxisLabelAtIndex:(NSInteger)index {
    
    return [self.yPoint[index] floatValue];
//    CGFloat value;
//    switch (index) {
//        case 0:
//            value = [self.chartView.calculator minValuePointsOfLinesPointSet:self.chartView.points].value;
//            break;
//        case 1:
//            value = [self.chartView.calculator maxValuePointsOfLinesPointSet:self.chartView.points].value;
//            break;
//        case 2:
//            value = [self.chartView.calculator calculateAverageForPointsSet:self.chartView.points];
//            break;
//        default:
//            break;
//    }
//    return value;
}

- (CGFloat)lineChartView:(WYLineChartView *)chartView valueReferToHorizontalReferenceLineAtIndex:(NSInteger)index {
    
    CGFloat value;
    switch (index) {
        case 0:
            value = [self.chartView.calculator minValuePointsOfLinesPointSet:self.chartView.points].value;
            break;
        case 1:
            value = [self.chartView.calculator maxValuePointsOfLinesPointSet:self.chartView.points].value;
            break;
        case 2:
            value = [self.chartView.calculator calculateAverageForPointsSet:self.chartView.points];
            break;
        default:
            break;
    }
    return value;
}



- (NSDictionary *)lineChartView:(WYLineChartView *)chartView attributesForLineAtIndex:(NSUInteger)index {
//    NSDictionary *attribute = [_settingViewController getLineAttributesAtIndex:index];
    NSMutableDictionary *resultAttributes = [NSMutableDictionary dictionary];
    resultAttributes[kWYLineChartLineAttributeLineStyle] = @(kWYLineChartMainBezierWaveLine);
    resultAttributes[kWYLineChartLineAttributeDrawGradient] = @(true);
    resultAttributes[kWYLineChartLineAttributeJunctionStyle] = @(kWYLineChartJunctionShapeNone);
    
    UIColor *lineColor;
    switch (index%3) {
        case 0:
            lineColor =UIColorFromRGB(0xc69c6d);// [UIColor colorWithRed:216/255.f green:191/255.f blue:165/255.f alpha:1];
            break;
        case 1:
            lineColor = UIColorFromRGB(0xea975d);//[UIColor colorWithRed:226.f/255.f green:166.f/255.f blue:125.f/255.f alpha:1];
            break;
        case 2:
            lineColor = [UIColor colorWithRed:242.f/255.f green:188.f/255.f blue:13.f/255.f alpha:0.9];
            break;
        default:
            break;
    }
    
    resultAttributes[kWYLineChartLineAttributeLineColor] = lineColor;
    resultAttributes[kWYLineChartLineAttributeJunctionColor] = lineColor;
    
    return resultAttributes;
}



@end
