//
//  ViewController.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "XLExampleViewController.h"
#import "XLChartView.h"
#import "NSDate+XLCategory.h"
#import "XLColorExtensionConst.h"

// 屏幕尺寸
#define XLScreenBounds      [UIScreen mainScreen].bounds
#define XLScreenWidth       [UIScreen mainScreen].bounds.size.width     // 屏幕宽度
#define XLScreenHeight      [UIScreen mainScreen].bounds.size.height    // 屏幕高度

@interface XLExampleViewController () <XLChartViewDataSource>
#pragma mark - 可滑动
@property (nonatomic, strong) UIScrollView      *chartScrollViewBg;
@property (nonatomic, strong) XLChartView       *chartViewInScr;

@property (nonatomic, copy) NSArray         *chartTitlesInScr;
@property (nonatomic, copy) NSArray         *valueArrayInScr;

#pragma mark - 固定
@property (nonatomic, strong) XLChartView       *chartView;

@property (nonatomic, copy) NSArray         *chartTitles;
@property (nonatomic, copy) NSArray         *valueArray;
@end

CGFloat const XLHorzMargin    = 15.0f;    // 水平边距
CGFloat const XLVerMargin     = 12.0f;    // 垂直边距
CGFloat const XLVerMargin1    = 10.0f;    // 垂直边距

CGFloat const XLHorzSpacing  = 12.0f;    // 内部水平间距
CGFloat const XLHorzSpacing1 = 10.0f;    // 内部水平间距
CGFloat const XLVerSpacing   = 6.0f;     // 内部垂直间距

@implementation XLExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewData];
    [self initViewDisplay];
}

-(void)initViewData{
    _chartTitlesInScr = [[NSDate latelyDaysTimeForCount:14] copy];
    _valueArrayInScr  = @[[NSNumber numberWithFloat:30.0f],
                          [NSNumber numberWithFloat:10.0f],
                          [NSNumber numberWithFloat:101.0f],
                          [NSNumber numberWithFloat:54.0f],
                          [NSNumber numberWithFloat:63.0f],
                          [NSNumber numberWithFloat:38.0f],
                          [NSNumber numberWithFloat:89.0f],
                          [NSNumber numberWithFloat:45.0f],
                          [NSNumber numberWithFloat:67.0f],
                          [NSNumber numberWithFloat:200.0f],
                          [NSNumber numberWithFloat:54.0f],
                          [NSNumber numberWithFloat:70.0f],
                          [NSNumber numberWithFloat:140.0f],
                          [NSNumber numberWithFloat:0.0f]];
    
    _chartTitles = [[NSDate latelyWeekTime] copy];
    _valueArray  = @[[NSNumber numberWithFloat:30.0f],
                     [NSNumber numberWithFloat:10.0f],
                     [NSNumber numberWithFloat:101.0f],
                     [NSNumber numberWithFloat:54.0f],
                     [NSNumber numberWithFloat:63.0f],
                     [NSNumber numberWithFloat:38.0f],
                     [NSNumber numberWithFloat:89.0f]];
}

-(void)initViewDisplay{
    CGRect frame = CGRectMake(0.0f, 88.0f, XLScreenWidth, 240.0f);
    _chartScrollViewBg = [[UIScrollView alloc] initWithFrame:frame];
    _chartScrollViewBg.showsVerticalScrollIndicator = NO;
    _chartScrollViewBg.showsHorizontalScrollIndicator = NO;
    _chartScrollViewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chartScrollViewBg];
    
    frame = CGRectMake(XLHorzMargin, 0.0f, XLScreenWidth * 2 - XLHorzMargin * 2, 240.0f);
    _chartViewInScr = [[XLChartView alloc] initWithFrame:frame];
    _chartViewInScr.tag = 1001;
    [self.chartScrollViewBg addSubview:_chartViewInScr];
    self.chartScrollViewBg.contentSize = CGSizeMake(XLScreenWidth * 2, 260.0f);
    _chartViewInScr.xlDelegate = self;
    [_chartViewInScr drawChartView];
    
    frame = CGRectMake(XLHorzMargin, 330.0f, XLScreenWidth - XLHorzMargin * 2, 240.0f);
    _chartView = [[XLChartView alloc] initWithFrame:frame];
    _chartView.tag = 1002;
    [self.view addSubview:_chartView];
    _chartView.xlDelegate = self;
    [_chartView drawChartView];
}

#pragma mark - XLCaseChartViewDataSource
/**
 描点位置是否显示小圆点
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(BOOL)showCirclePointChartView:(XLChartView *)chartView{
    if (chartView.tag == 1001) {
        return YES;
    } else {
        return NO;
    }
}

/**
 描点颜色
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(UIColor *)circlePointColorInChartView:(XLChartView *)chartView{
    return HexColor(@"#c15d40");
}

/**
 阴影颜色

 @param chartView <#chartView description#>
 @return <#return value description#>
 */
- (UIColor *)shadowColorInChartView:(XLChartView *)chartView{
    if (chartView.tag == 1001) {
        return [UIColor colorWithWhite:0.5 alpha:0.4];
    } else {
        return HexAlphaColor(@"#c15d40", 0.3f);
    }
}

/**
 数据源数量
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(NSInteger)numberOfItemsInChartView:(XLChartView *)chartView{
    if (chartView.tag == 1001) {
        return self.chartTitlesInScr.count;
    } else {
        return self.chartTitles.count;
    }
}

/**
 X 轴最大值
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(CGFloat)maxAxisXValueInChartView:(XLChartView *)chartView{
    if (chartView.tag == 1001) {
        return 200.0f;
    } else {
        return 101.0f;
    }
}

/**
 X 轴坐标值
 
 @param chartView <#chartView description#>
 @param index <#index description#>
 @return <#return value description#>
 */
-(CGFloat)chartView:(XLChartView *)chartView axisXAtIndex:(NSInteger)index{
    if (chartView.tag == 1001) {
        NSNumber *number = self.valueArrayInScr[index];
        return [number floatValue];
    } else {
        NSNumber *number = self.valueArray[index];
        return [number floatValue];
    }
}

/**
 Y 坐标显示标题
 
 @param chartView <#chartView description#>
 @param yIndex <#yIndex description#>
 @return <#return value description#>
 */
-(NSString *)chartView:(XLChartView *)chartView bottomTitleAtIndex:(NSInteger)yIndex{
    if (chartView.tag == 1001) {
        return self.chartTitlesInScr[yIndex];
    } else {
        return self.chartTitles[yIndex];
    }
    
}

/**
 点击时显示标题
 
 @param chartView <#chartView description#>
 @param yIndex <#yIndex description#>
 @return <#return value description#>
 */
-(NSString *)chartView:(XLChartView *)chartView titleForSelectAtIndex:(NSInteger)yIndex{
    if (chartView.tag == 1001) {
        NSNumber *number = self.valueArrayInScr[yIndex];
        return [self stringWithInterger:[number integerValue]];
    } else {
        NSNumber *number = self.valueArray[yIndex];
        return [self stringWithInterger:[number integerValue]];
    }
}

-(NSString*)stringWithInterger:(NSInteger)value{
    return [NSString stringWithFormat:@"%ld", (long)value];
}

@end
