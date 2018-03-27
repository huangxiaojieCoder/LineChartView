//
//  OTLineChartView.m
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/12.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import "OTLineChartView.h"

@interface OTLineChartView ()

/** <#name#> */
@property (nonatomic, strong) CAShapeLayer *markerLayer;

/** <#name#> */
@property (nonatomic, strong) UILabel *markerLabel;

@property (nonatomic, assign) BOOL refresh;

@end


@implementation OTLineChartView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.coordinateLineColor = [UIColor grayColor];
        self.lineColor = [UIColor grayColor];
        self.coverColor = [UIColor redColor];
        self.pointColor = [UIColor blackColor];
        
        /** 初始化X轴节点坐标数组 */
        self.xNodeCordAry = [[NSMutableArray alloc] init];
        
        self.yNodeCordAry = [[NSMutableArray alloc] init];
        // 当前页面添加轻拍手势
        UITapGestureRecognizer *lineViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lineViewTapAction:)];
        [self addGestureRecognizer:lineViewTap];
        
    }
    return self;
}

#pragma mark - 轻拍手势点击
- (void)lineViewTapAction:(UIGestureRecognizer *)tap {

    // 获取点击坐标
    CGPoint point = [tap locationInView:self];
    
    CGRect rect = CGRectMake(self.marginX, self.marginY, self.frame.size.width - self.marginX * 2, self.frame.size.height - self.marginY * 2);
    BOOL contain =  CGRectContainsPoint(rect, point);

    
    if (contain == NO) {
        return;
    }
    
    NSLog(@"%f", point.x);
    NSInteger index = ((point.x - self.marginX) + self.xAxisSpac * 0.5) / self.xAxisSpac;
 
    CGPoint currentPoint = CGPointMake([self.xNodeCordAry[index] floatValue], [self.yNodeCordAry[index] floatValue]);
    NSLog(@"%@", NSStringFromCGPoint(currentPoint));

    if (self.refresh == YES) {
        self.markerLayer = [CAShapeLayer layer];
        self.markerLayer.strokeColor = [UIColor clearColor].CGColor;
        self.markerLayer.lineWidth = 0.001;
        [self.layer addSublayer:self.markerLayer];
        
        self.markerLabel = [[UILabel alloc] init];
        [self addSubview:self.markerLabel];
        
        self.refresh = NO;
    }
   
    
    OTChatData *data = self.datas [index];
    
    self.markerLabel.text =  data.markerText;
 
    CGSize size = [data.markerText sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
    NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:data.markerText attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
    size = [attributeSting size];
    
    self.markerLabel.text = data.markerText;
    self.markerLabel.textAlignment = NSTextAlignmentCenter;
    size.width = size.width + 16;
    size.height = size.height + 12;
    if (size.width < 50) {
        size.width = 50;
    }
    if (size.height < 30 ) {
        size.height = 30;
    }
    
    self.markerLabel.frame = CGRectMake(currentPoint.x, currentPoint.y, size.width , size.height);
    self.markerLabel.font = [UIFont systemFontOfSize:12];
    self.markerLabel.textColor = [UIColor whiteColor];
    
    self.markerImage.marginX = self.marginX;
    self.markerImage.marginY = self.marginY;
    [self.markerImage drawContentxt:self.markerLayer point:currentPoint chatData:data rect:self.markerLabel.frame label:self.markerLabel];
    
    
}





- (void)drawRect:(CGRect)rect {
 
}



- (void)refreshData {
    
    self.refresh = YES;

    [self.xNodeCordAry removeAllObjects];
    [self.yNodeCordAry removeAllObjects];

    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
     NSLog(@"%@", self.layer.sublayers);

     NSLog(@"%@", self.subviews);
    self.layer.sublayers = nil;
   

    // 数据计算
    self.xAxisSpac =( self.frame.size.width - 2 *self.marginX) / (self.datas.count  -1 );

    CGFloat chatHeight = self.frame.size.height - 2 * self.marginY;
    self.yAxisSpac = chatHeight / (self.labelCountY);
    
    NSMutableArray *xValve = [NSMutableArray array];
    NSMutableArray *yValve = [NSMutableArray array];
    for (NSInteger i = 0; i < self.datas.count; i ++) {
        OTChatData *data = self.datas[i];
        [xValve addObject:[NSString stringWithFormat:@"%.0f",data.xValue]];
        [yValve addObject:[NSString stringWithFormat:@"%f",data.yValue]];
    }
    
    // 坐标
    [self drawCoordinate];
    // X线
    [self setXLineDash:xValve];
    // y线
    [self drawYLine];
    // 折线
    [self drawBrokenLine:yValve lineColor:self.lineColor];

}

- (void)drawYLine {
    CGFloat average = self.maxY / (self.labelCountY );
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.labelCountY ; i ++) {
        NSInteger y = self.maxY - average * i;
        [yArray addObject:[NSString stringWithFormat:@"%ld", y]];
    }
    [self setYLineDash:yArray];
}



- (void)drawCoordinate {
    CAShapeLayer *dashLayer = [CAShapeLayer layer];
    dashLayer.strokeColor = self.coordinateLineColor.CGColor;
    dashLayer.fillColor = [UIColor clearColor].CGColor;
    dashLayer.lineWidth = 0.5;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat viewH = self.frame.size.height;
    [path moveToPoint:CGPointMake(self.marginX , self.marginY)];
    [path addLineToPoint:CGPointMake(self.marginX , viewH - self.marginY  )];
    [path addLineToPoint:CGPointMake(self.frame.size.width - self.marginX , viewH - self.marginY  )];
    dashLayer.path = path.CGPath;
    [self.layer addSublayer:dashLayer];
}



- (void)setXLineDash:(NSArray *)nodeAry {
    
    
    CGFloat viewH = self.frame.size.height;
    for (NSInteger i = 0; i < nodeAry.count; i++) {
        // 分割线属性
        CAShapeLayer *dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = self.lineColor.CGColor;
        dashLayer.fillColor = [UIColor clearColor].CGColor;
        dashLayer.lineWidth = 0.5;
        
        // 绘制分割线
        UIBezierPath *path = [[UIBezierPath alloc] init];
        
        [path moveToPoint:CGPointMake(self.marginX + self.xAxisSpac * i , self.marginY)];
        [path addLineToPoint:CGPointMake(self.marginX + self.xAxisSpac * i , viewH - self.marginY )];
        
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
        
    }
    
    [self crateLabelX:nodeAry];
}

// y轴分割线
- (void)setYLineDash:(NSArray *)nodeAry {
//    if (self.width != 0) {
    
    CGFloat chatWith = self.frame.size.width - self.marginX;
    
        for (NSInteger i = 0;i < nodeAry.count; i++ ) {
            // 分割线属性
            CAShapeLayer * dashLayer = [CAShapeLayer layer];
            dashLayer.strokeColor = [UIColor grayColor].CGColor;
            dashLayer.fillColor = [UIColor clearColor].CGColor;
            dashLayer.lineWidth = 0.5;
            // 绘制分割线
           
            UIBezierPath * path = [[UIBezierPath alloc]init];
            // 分割线起始点
            [path moveToPoint:CGPointMake(self.marginX, self.marginY + self.yAxisSpac * i)];
            [path addLineToPoint:CGPointMake(chatWith, self.marginY + self.yAxisSpac * i)];
            dashLayer.path = path.CGPath;
            [self.layer addSublayer:dashLayer];
     
          
        }
        // 创建y轴的数据
        [self createLabelY:nodeAry];
//    }
}


#pragma mark - 创建轴线的数据

- (void)crateLabelX:(NSArray *)nodeAry {
    
    
    CGFloat labelY = self.frame.size.height - self.marginY + 5;
    for (NSInteger i = 0; i < nodeAry.count; i ++) {
        NSString *text = nodeAry[i];
        // 计算size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        
        size = [attributeString size];
        // 展示文字
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake(self.marginX + self.xAxisSpac * i - size.width / 2,
                                                                        labelY,
                                                                        size.width, size.height)];
        LabelMonth.text = text;
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.textColor = self.coordinateLineColor;
        
        [self addSubview:LabelMonth];
        // 保存x轴坐标
        [self.xNodeCordAry addObject:[NSString stringWithFormat:@"%f", self.marginX + self.xAxisSpac * i]];
        
    }
    
}


// 创建y轴数据
- (void)createLabelY:(NSArray *)nodeAry {
    for (NSInteger i = 0; i < nodeAry.count ; i++) {
        // 获取展示字符
        NSString *text = nodeAry[i];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 展示文字
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(self.marginX - size.width - 5,
                                                                            self.marginY + self.yAxisSpac * i - size.height/2,
                                                                            size.width, size.height)];
        labelYdivision.text = text;
        labelYdivision.font = [UIFont systemFontOfSize:10];
        labelYdivision.textColor = self.coordinateLineColor;
        [self addSubview:labelYdivision];
    }
}



#pragma mark - 创建折线
// 画折线
- (void)drawBrokenLine:(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor {
    
    [self.yNodeCordAry removeAllObjects];
    // 折线属性
    CAShapeLayer * dashLayer = [CAShapeLayer layer];
    dashLayer.strokeColor = lineColor.CGColor;
    dashLayer.fillColor = [UIColor clearColor].CGColor;
    dashLayer.lineWidth = 0.5;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    
    CGFloat charViewH = self.frame.size.height - 2 * self.marginY ;
    CGFloat mutiple =  charViewH / self.maxY;
    
    CGPoint brokenOrigin = CGPointMake(self.marginX, (self.frame.size.height - self.marginY  -[[brokenLineSpotAry firstObject] integerValue] * mutiple ));
    // 折线起点
    [path moveToPoint:brokenOrigin];
    [self.layer addSublayer:dashLayer];

    [self.yNodeCordAry addObject:[NSString stringWithFormat:@"%f",brokenOrigin.y]];
    
    // 便利折线图数据
    for (NSInteger i = 1;i < brokenLineSpotAry.count; i++ ) {
        // 折线终点
        CGFloat y =  (self.frame.size.height - self.marginY - [[brokenLineSpotAry objectAtIndex:i] integerValue] * mutiple);
        brokenOrigin = CGPointMake(self.marginX + self.xAxisSpac * i,y);
        [path addLineToPoint:brokenOrigin];
        dashLayer.path = path.CGPath;
        
        
        [self.yNodeCordAry addObject:[NSString stringWithFormat:@"%f",y]];
    }
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [dashLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    [self drawMarkeroint:brokenLineSpotAry lineColor:self.pointColor];
//
    [self drawBrokenCoverColer:brokenLineSpotAry coverColer:self.coverColor];
}




// 画包围圈
- (void)drawBrokenCoverColer:(NSArray *)brokenLineSpotAry coverColer:(UIColor *)coverColerneColor {
    // 折线属性
    CAShapeLayer * dashLayer = [CAShapeLayer layer];
    dashLayer.strokeColor = [UIColor clearColor].CGColor;
    dashLayer.fillColor = coverColerneColor.CGColor;
    dashLayer.lineWidth = 0;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    
    CGFloat charViewH = self.frame.size.height - 2 * self.marginY ;
    CGFloat mutiple =  charViewH / self.maxY;
    
    CGPoint origin = CGPointMake(self.marginX, self.frame.size.height - self.marginY);
    // 折线起点
    [path moveToPoint:origin];
    
    CGPoint brokenOrigin = CGPointMake(self.marginX, (self.frame.size.height - self.marginY  -[[brokenLineSpotAry firstObject] integerValue] * mutiple ));
    // 折线起点
    [path addLineToPoint:brokenOrigin];
    
    [self.layer addSublayer:dashLayer];
    
    
    // 便利折线图数据
    for (NSInteger i = 1;i < brokenLineSpotAry.count; i++ ) {
        // 折线终点
        CGFloat y =  (self.frame.size.height - self.marginY - [[brokenLineSpotAry objectAtIndex:i] integerValue] * mutiple);
        brokenOrigin = CGPointMake(self.marginX + self.xAxisSpac * i,y);
        [path addLineToPoint:brokenOrigin];

        dashLayer.path = path.CGPath;
    
    }
    
    // 包围圈终点
    CGPoint maxPoint = CGPointMake(self.marginX + self.xAxisSpac * (brokenLineSpotAry.count - 1),self.frame.size.height - self.marginY);
    [path addLineToPoint:maxPoint];
    dashLayer.path = path.CGPath;
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [dashLayer addAnimation:pathAnimation forKey:@"circleAnimation"];
   
}
// 画标记点
- (void)drawMarkeroint :(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor {
    // 标记点起点
    CGFloat charViewH = self.frame.size.height - 2 * self.marginY ;
    CGFloat mutiple =  charViewH / self.maxY;

    CGPoint markerOrigin = CGPointMake(self.marginX,self.frame.size.height - self.marginY - [[brokenLineSpotAry firstObject] integerValue] * mutiple);
    // 便利折标记点数据
    for (NSInteger i = 1;i <= brokenLineSpotAry.count; i++ ) {
        // 白色标记点
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.frame = CGRectMake(markerOrigin.x - 5, markerOrigin.y - 5, 10, 10);
        whiteView.layer.masksToBounds = YES;
        whiteView.layer.cornerRadius = 5;
        [self addSubview:whiteView];
        [self bringSubviewToFront:whiteView];
        // 折线颜色标记点
        UIView *markeriew = [[UIView alloc] init];
        markeriew.backgroundColor = lineColor;
        markeriew.frame = CGRectMake(2.5, 2.5, 5, 5);
        markeriew.layer.masksToBounds = YES;
        markeriew.layer.cornerRadius = 2.5;
        [whiteView addSubview:markeriew];
        // i==brokenLineAry.count的时候不去取下一个点的坐标
        if (i < brokenLineSpotAry.count) {
            // 保存下一个标记点位置
            markerOrigin = CGPointMake(self.marginX + self.xAxisSpac * i, self.frame.size.height - self.marginY - [[brokenLineSpotAry objectAtIndex:i] integerValue] * mutiple);
        }
    }
}


@end
