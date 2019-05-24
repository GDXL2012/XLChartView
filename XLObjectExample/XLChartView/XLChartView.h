//
//  XLChartView.h
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XLChartView;

@protocol XLChartViewDataSource <NSObject>

@optional
/**
 描点是否显示小圆点
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(BOOL)showCirclePointChartView:(XLChartView *)chartView;

/**
 描点颜色

 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(UIColor *)circlePointColorInChartView:(XLChartView *)chartView;

/**
 阴影颜色

 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(UIColor *)shadowColorInChartView:(XLChartView *)chartView;

@required
/**
 数据源数量
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(NSInteger)numberOfItemsInChartView:(XLChartView *)chartView;

/**
 X 轴最大值
 
 @param chartView <#chartView description#>
 @return <#return value description#>
 */
-(CGFloat)maxAxisXValueInChartView:(XLChartView *)chartView;

/**
 X 轴坐标值
 
 @param chartView <#chartView description#>
 @param index <#index description#>
 @return <#return value description#>
 */
-(CGFloat)chartView:(XLChartView *)chartView axisXAtIndex:(NSInteger)index;

/**
 Y 坐标显示标题
 
 @param chartView <#chartView description#>
 @param yIndex <#yIndex description#>
 @return <#return value description#>
 */
-(NSString *)chartView:(XLChartView *)chartView bottomTitleAtIndex:(NSInteger)yIndex;

/**
 点击时显示标题
 
 @param chartView <#chartView description#>
 @param yIndex <#yIndex description#>
 @return <#return value description#>
 */
-(NSString *)chartView:(XLChartView *)chartView titleForSelectAtIndex:(NSInteger)yIndex;
@end

@interface XLChartView : UIView

@property (nonatomic, weak) id<XLChartViewDataSource> xlDelegate;

/**
 绘制图标:
 */
-(void)drawChartView;

@end

NS_ASSUME_NONNULL_END
