//
//  XLChartView.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "XLChartView.h"
#import "UIColor+XLCategory.h"
#import "XLColorExtensionConst.h"

@interface XLChartView ()
// 折线路径
@property (nonatomic, strong) UIBezierPath *chartLinePath;
@property (nonatomic, strong) CAShapeLayer *chartLineLayer;

// 折线阴影
@property (nonatomic, strong) UIBezierPath *shadowPath;
@property (nonatomic, strong) CAShapeLayer *shadowColorLayer;

// 描点坐标【起始、终点】
@property (nonatomic, assign) CGPoint xstartPoint;  // 起始描点
@property (nonatomic, assign) CGPoint xendPoint;    // 结束描点
// 描点坐标【折线值对应描点坐标】
@property (nonatomic, copy) NSMutableArray *pointYArray;
@property (nonatomic, copy) NSMutableArray *pointXArray;

// 描点绘制圆点Layer
@property (nonatomic, strong) CALayer *circleLayer;

// 标签值
@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, copy) NSMutableArray  *bottomTitleLabels;
@property (nonatomic, copy) NSMutableArray  *contentLineLayers;
@property (nonatomic, copy) NSMutableArray  *chartPointLayers;
@property (nonatomic, copy) UIView          *bottomLineView;

// 折线图绘制View
@property (nonatomic, copy) UIView          *chartView;
// 绘制区域
@property (nonatomic, assign) CGFloat drawHeight;
@property (nonatomic, assign) CGFloat drawWidth;
@end

static CGFloat const XLBottomTitleHeight    = 45.0f;    // 底部文本高度
static CGFloat const XLTopSpaceHeight       = 30.0f;    // 顶部留白区域
static CGFloat const XLHorSpace             = 20.0f;    // 左右间距
static CGFloat const XLMaxLineNumber        = 6;        // 横线最大行数

@implementation XLChartView

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, 45, 25)];
        _tagLabel.backgroundColor = [UIColor blackColor];
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tagLabel.numberOfLines = 0;
        _tagLabel.layer.cornerRadius = 4.0f;
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.font = [UIFont systemFontOfSize:15.0f];
        _tagLabel.hidden = YES;
    }
    return _tagLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLayerAndPathTool];
        [self initMemberVariableWithFrame:frame];
        [self initViewDisplayWithFrame:frame];
    }
    return self;
}

-(void)initLayerAndPathTool{
    _shadowPath       = [[UIBezierPath alloc] init];
    _shadowColorLayer = [[CAShapeLayer alloc] init];
    _shadowColorLayer.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2].CGColor;
    _shadowColorLayer.strokeColor = [UIColor clearColor].CGColor;
    
    _chartLinePath  = [[UIBezierPath alloc]init];
    _chartLineLayer = [[CAShapeLayer alloc] init];
    _chartLineLayer.strokeColor = HexColor(@"#c15d40").CGColor;
    _chartLineLayer.lineWidth = 1.0f;
    _chartLineLayer.fillColor = [UIColor clearColor].CGColor;
}

-(void)initMemberVariableWithFrame:(CGRect)frame{
    _pointYArray = [NSMutableArray array];
    _pointXArray = [NSMutableArray array];
    _chartPointLayers  = [NSMutableArray array];
    _contentLineLayers = [NSMutableArray array];
    _bottomTitleLabels = [NSMutableArray array];
}

-(void)initViewDisplayWithFrame:(CGRect)frame{
    // 计算折线区域
    CGFloat totalHeight = frame.size.height;
    _drawHeight = totalHeight - XLTopSpaceHeight - XLBottomTitleHeight;
    _drawWidth = frame.size.width - XLHorSpace * 2;
    CGFloat datHeight = self.drawHeight / XLMaxLineNumber;
    
    // 绘制折线区域
    _chartView = [[UIView alloc] initWithFrame:CGRectMake(XLHorSpace, XLTopSpaceHeight, self.drawWidth, self.drawHeight)];
    [self addSubview:_chartView];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chartViewTapGesture:)];
    [_chartView addGestureRecognizer:tapGesture];
    
    // 起始、终点描点位置
    CGFloat datY = self.drawHeight;
    self.xstartPoint = CGPointMake(0, datY);
    self.xendPoint = CGPointMake(self.drawWidth, datY);
    
    // 底部横线
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, totalHeight - XLBottomTitleHeight, frame.size.width, 0.5)];
    _bottomLineView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    [self addSubview:_bottomLineView];
    
    // 折线区域划线
    for (NSInteger index = 0; index < XLMaxLineNumber; index ++) {
        CGPoint startPoint = CGPointMake(0, index * datHeight);
        CGPoint endPoint = CGPointMake(self.drawWidth, index * datHeight);

        UIBezierPath *linePath         = [[UIBezierPath alloc] init];
        [linePath moveToPoint:startPoint];
        [linePath addLineToPoint:endPoint];

        CAShapeLayer *contentLineLayer = [[CAShapeLayer alloc] init];
        contentLineLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.2].CGColor;
        contentLineLayer.lineWidth = 0.5f;
        contentLineLayer.fillColor = [UIColor clearColor].CGColor;

        contentLineLayer.path = linePath.CGPath;
        [self.chartView.layer addSublayer:contentLineLayer];
        [self.contentLineLayers addObject:contentLineLayer];
    }
    // 点击标签
    [self.chartView addSubview:self.tagLabel];
}

/**
 清理数据
 */
-(void)clearAllViewData{
    if (self.chartPointLayers.count > 0) {
        [self.chartPointLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.chartPointLayers removeAllObjects];
    }
    if (self.chartLineLayer) {
        [self.chartLineLayer removeFromSuperlayer];
    }
    self.tagLabel.hidden = YES;
    // 移除底部文本
    if (self.bottomTitleLabels.count > 0) {
        [self.bottomTitleLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bottomTitleLabels removeAllObjects];
    }
    if (self.shadowColorLayer) {
        [self.shadowColorLayer removeFromSuperlayer];
    }
    
    [self.shadowPath removeAllPoints];
}

/**
 YES 判断是否有描点数据

 @return <#return value description#>
 */
-(BOOL)hasPointData{
    if (!self.xlDelegate ||
        [self.xlDelegate numberOfItemsInChartView:self] == 0) {
        return YES;
    }
    return YES;
}


/**
 绘制折线图
 */
-(void)drawChartView{
    [self clearAllViewData];
    
    if(![self hasPointData]){
        return;
    }
    NSInteger itemCount = [self.xlDelegate numberOfItemsInChartView:self];
    CGFloat maxValue = [self.xlDelegate maxAxisXValueInChartView:self];
    
    CGFloat topSpace = self.drawHeight / (XLMaxLineNumber + 1);
    // 单位内高度值
    CGFloat unitHeight = (self.drawHeight - topSpace) / maxValue;
    CGFloat datX = self.drawWidth / (itemCount - 1);
    
    CGFloat firstValue = [self.xlDelegate chartView:self axisXAtIndex:0];
    CGPoint firstPoint = CGPointMake(0, self.drawHeight - firstValue * unitHeight);
    
    // 阴影起点
    [self.shadowPath moveToPoint:self.xstartPoint];
    
    // 显示描点
    BOOL showCirclePoint = NO;
    if(self.xlDelegate &&
       [self.xlDelegate respondsToSelector:@selector(showCirclePointChartView:)]){
        showCirclePoint = [self.xlDelegate showCirclePointChartView:self];
    }
    // 绘制折线图
    for (NSInteger index = 0; index < itemCount; index ++) {
        CGFloat value = [self.xlDelegate chartView:self axisXAtIndex:index];
        CGFloat height = value * unitHeight;
        // 坐标转换
        CGPoint point = CGPointMake(index * datX, self.drawHeight - height);
        [self drawTimeLine:firstPoint toPoint:point];
        firstPoint = point;
        [self.pointYArray addObject:[NSString stringWithFormat:@"%.2f", point.y]];
        [self.pointXArray addObject:[NSString stringWithFormat:@"%.2f", point.x]];
        
        if(showCirclePoint){
            [self setupCircleLayer:point tag:index];
        }
        
        NSString *title = [self.xlDelegate chartView:self bottomTitleAtIndex:index];
        
        UILabel *label = [self bottomLabelWithTitle:title atIndex:index datX:datX];
        [self.bottomTitleLabels addObject:label];
    }
    // 阴影终点
    [self.shadowPath addLineToPoint:self.xendPoint];
    // 阴影终点链接起点
    [self.shadowPath addLineToPoint:self.xstartPoint];
    // 绘制阴影路径
    if(self.xlDelegate &&
       [self.xlDelegate respondsToSelector:@selector(shadowColorInChartView:)]){
        UIColor *color = [self.xlDelegate shadowColorInChartView:self];
        self.shadowColorLayer.fillColor = color.CGColor;
    }
    self.shadowColorLayer.path = self.shadowPath.CGPath;
    [self.chartView.layer insertSublayer:self.shadowColorLayer atIndex:0];
}

/**
 底部坐标t标题Label
 
 @param title <#title description#>
 @param index <#index description#>
 @param datX <#datX description#>
 @return <#return value description#>
 */
-(UILabel *)bottomLabelWithTitle:(NSString *)title atIndex:(NSInteger)index datX:(CGFloat)datX{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = [UIColor lightGrayColor];
    [self addSubview:label];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [label sizeToFit];
    label.center = CGPointMake(XLHorSpace + index * datX, self.frame.size.height - XLBottomTitleHeight / 2.0f);
    return label;
}

/**
 点击手势

 @param tapGesture <#tapGesture description#>
 */
-(void)chartViewTapGesture:(UITapGestureRecognizer *)tapGesture{
    CGPoint point = [tapGesture locationInView:self.chartView];
    [self showTagLabel:point];
}

/**
 显示标签

 @param point <#point description#>
 */
- (void)showTagLabel:(CGPoint)point {
    NSInteger count = [self.xlDelegate numberOfItemsInChartView:self];
    if (count == 0) {
        return;
    }
    // 1.点击位置处理：取间隔的一半值作为计算单位
    CGFloat datX = self.drawWidth / (count - 1) / 2;
    // 2.去除首位的一个计算单位
    NSInteger datCount = (point.x - datX) / datX;
    
    NSInteger index = 0;
    if (point.x - datX < 0) {
        // 小于 0 点击位置为首位
        index = 0;
    } else {
        // 之后每两个计算单位则下标增加1，下标从1开始计算
        index = datCount / 2 + 1;
    }
    
    NSString *title = [self.xlDelegate chartView:self titleForSelectAtIndex:index];
    if (!title || title.length == 0) {
        return;
    }
    // 取描点坐标
    NSString *whichY = self.pointYArray[index];
    NSString *whichX = self.pointXArray[index];
    self.tagLabel.center = CGPointMake(whichX.floatValue, whichY.floatValue - 25);
    
    self.tagLabel.text = title;
    self.tagLabel.hidden = NO;
    [self.chartView bringSubviewToFront:self.tagLabel];
}

// 绘制折现
- (void)drawTimeLine:(CGPoint)point toPoint:(CGPoint)toPoint {
    [self.chartLinePath moveToPoint:point];
    [self.chartLinePath addLineToPoint:toPoint];
    // 添加阴影描点
    [self.shadowPath addLineToPoint:toPoint];
    
    self.chartLineLayer.path = self.chartLinePath.CGPath;
    [self.chartView.layer addSublayer:self.chartLineLayer];
}

// 设置圆点
- (void)setupCircleLayer:(CGPoint)point tag:(NSInteger)tag{
    self.circleLayer = [[CALayer alloc] init];
    if(self.xlDelegate &&
       [self.xlDelegate respondsToSelector:@selector(circlePointColorInChartView:)]){
        UIColor *color = [self.xlDelegate circlePointColorInChartView:self];
        self.circleLayer.backgroundColor = color.CGColor;
    } else {
        self.circleLayer.backgroundColor = HexColor(@"#c15d40").CGColor;
    }
    self.circleLayer.frame = CGRectMake(0, 0, 6, 6);
    self.circleLayer.cornerRadius = 3;
    self.circleLayer.position = point;
    self.circleLayer.masksToBounds = YES;
    [self.chartView.layer addSublayer:self.circleLayer];
    [self.chartPointLayers addObject:self.circleLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
