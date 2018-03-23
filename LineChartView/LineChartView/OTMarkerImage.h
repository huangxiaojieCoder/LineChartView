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

- (void)drawContentxt:(CAShapeLayer *)layer point:(CGPoint)point chatData:(OTChatData *)chatData rect:(CGRect)rect label:(UILabel *)label;

@end
