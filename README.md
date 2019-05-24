# XLChartView
简单折线图

初始化使用：
- -(instancetype)initWithFrame:(CGRect)frame;

调用绘制方法前，需设置xlDelegate.

调用示例：
CGRect frame = CGRectMake(20.0f, 330.0f, 460.0f - 20.0f * 2, 240.0f);
XLChartView *chartView = [[XLChartView alloc] initWithFrame:frame];
chartView.xlDelegate = self;
[chartView drawChartView];

