//
//  OTLineChartView.h
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/12.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTMarkerImage.h"
#import "OTChatData.h"

@interface OTLineChartView : UIView


//@property (nonatomic, assign) CGFloat xOrigin;
@property (nonatomic, assign) CGFloat xAxisSpac;

/** Y轴间距离上边距离 */
//@property (assign, nonatomic) CGFloat yAxisTopSpac;
/** Y轴间距 */
@property (assign, nonatomic) CGFloat yAxisSpac;

/** X轴节点坐标数组 */
@property (strong, nonatomic) NSMutableArray *xNodeCordAry;
/** 点的y坐标 */
@property (nonatomic, strong) NSMutableArray *yNodeCordAry;

/** Y 的最大值*/
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) NSInteger labelCountX;
@property (nonatomic, assign) NSInteger labelCountY;


@property (nonatomic, assign) CGFloat marginX;

@property (nonatomic, assign) CGFloat marginY;


/** 线的颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 点的颜色 */
@property (nonatomic, strong) UIColor *pointColor;

/** 包围圈的颜色 */
@property (nonatomic, strong) UIColor *coverColor;

/** 坐标颜色: 默认是灰色 */
@property (nonatomic, strong) UIColor *coordinateLineColor;



/** <#name#> */
@property (nonatomic, strong) NSArray *datas;

- (void)refreshData;

/** <#name#> */
@property (nonatomic, strong) OTMarkerImage *markerImage;

/** 画折线*/
- (void)drawBrokenLine:(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor;

@end
