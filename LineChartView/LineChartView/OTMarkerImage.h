//
//  OTMarkerImage.h
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/16.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OTChatData.h"

@interface OTMarkerImage : NSObject


/** x轴起点距离 左边的距离*/
@property (nonatomic, assign) CGFloat marginX;
/** y轴起点距离 上边的距离*/
@property (nonatomic, assign) CGFloat marginY;

/** 弹泡泡颜色 */
@property (nonatomic, strong) UIColor *markerColor;

/** 泡泡内容颜色 */
@property (nonatomic, strong) UIColor *markerTextColor;


- (void)drawContentxt:(CAShapeLayer *)layer point:(CGPoint)point chatData:(OTChatData *)chatData rect:(CGRect)rect label:(UILabel *)label;

@end
