//
//  OTBallonMarker.h
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/16.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import "OTMarkerImage.h"

@interface OTBallonMarker : OTMarkerImage

/** 点击弹出的泡泡框宽度*/
@property (nonatomic, assign) CGFloat markerWidth;
/** 点击弹出泡泡框的高度*/
@property (nonatomic, assign) CGFloat markerHeight;
/** 尖头的大小*/
@property (nonatomic, assign) CGSize arrowSize;
/** 弧度的半径*/
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) CGSize charViewSize;

@property (nonatomic, assign) CGFloat marginX;

@property (nonatomic, assign) CGFloat marginY;


@end
