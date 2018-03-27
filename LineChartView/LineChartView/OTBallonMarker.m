//
//  OTBallonMarker.m
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/16.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import "OTBallonMarker.h"

@implementation OTBallonMarker


- (void)drawContentxt:(CAShapeLayer *)layer point:(CGPoint)point chatData:(OTChatData *)chatData rect:(CGRect)rect label:(UILabel *)label
{
    [super drawContentxt:layer point:point chatData:chatData rect:rect label:label];
    NSLog(@"drawContentxt123");
   
    
    self.markerWidth = rect.size.width;
    self.markerHeight = rect.size.height;

    self.arrowSize = CGSizeMake(15, 10);
   
    self.radius = 5;
    
    layer.fillColor = self.markerColor.CGColor;
    label.textColor = self.markerTextColor;

    // 画弹框
    CGFloat sepeLeftX = self.charViewSize.width * 0.3;
    CGFloat sepeRigthX = self.charViewSize.width * 0.9;
    CGFloat middleY = self.charViewSize.height * 0.5;

    CGFloat curentX = point.x - self.marginX;
    CGFloat curentY = point.y - self.marginY;
    if (curentX < sepeLeftX && curentY < middleY) {
       label.frame = [self drawLeftTopArrowWithLayer:layer point:point];
    } else if (curentX >= sepeLeftX && curentY < middleY && curentX < sepeRigthX) {
     label.frame = [self drawTopArrowWithLayer:layer point:point];
    } else if (curentX >= sepeRigthX && curentY < middleY ) {
       label.frame = [self drawRightTopWithLayer:layer point:point];
    } else if (curentX < sepeLeftX && curentY > middleY) {
       label.frame = [self drawLeftBottomArrowWithLayer:layer point:point];
    } else if (curentX >= sepeRigthX && curentY > middleY) {
       label.frame =[self drawRightBottomArrowWithLayer:layer point:point];
    } else {
       label.frame = [self drawBottomArrowWithLayer:layer point:point];
    }
 

}

- (CGRect)drawLeftTopArrowWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    
    CGFloat leftX = point.x;
    CGFloat rigthX = point.x + self.markerWidth;
    CGFloat topY = point.y + self.arrowSize.height;
    CGFloat bottomY = point.y +self.markerHeight;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
  
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
    [path addLineToPoint:CGPointMake(rigthX -self.radius, topY )];
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, topY + self.radius) radius:self.radius startAngle:(270*M_PI_2/90) endAngle:0 clockwise:YES];

    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];

    // 右底弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, bottomY - self.radius) radius:self.radius startAngle:0 endAngle:(180 * M_PI_2 / 180) clockwise:YES];
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];

    // 底线左弧
    [path addArcWithCenter:CGPointMake(leftX + self.radius, bottomY - self.radius) radius:self.radius startAngle:(90 * M_PI_2/ 90) endAngle:(180 * M_PI_2/ 90) clockwise:YES];

    [path addLineToPoint:CGPointMake(leftX, topY - self.radius)];
    [path addLineToPoint: CGPointMake(leftX + self.arrowSize.width, topY)];
    
    layer.path = path.CGPath;
    
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}

- (CGRect)drawTopArrowWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    CGFloat leftX = point.x - self.markerWidth * 0.5;
    CGFloat rigthX = leftX + self.markerWidth;
    CGFloat topY = point.y + self.arrowSize.height;
    CGFloat bottomY = point.y +self.markerHeight;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
     // 顶部中间三角
    [path addLineToPoint:CGPointMake(leftX + (self.markerWidth - self.arrowSize.width) * 0.5, topY )];
    [path addLineToPoint:CGPointMake(leftX + self.markerWidth * 0.5, topY - self.arrowSize.height )];
    [path addLineToPoint:CGPointMake(leftX + (self.markerWidth + self.arrowSize.width) * 0.5, topY)];
    [path addLineToPoint:CGPointMake(rigthX - self.radius, topY)];
    // 右弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, topY + self.radius) radius:self.radius startAngle:(270*M_PI_2/90) endAngle:0 clockwise:YES];
    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];
    // 右底弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, bottomY - self.radius) radius:self.radius startAngle:0 endAngle:(180 * M_PI_2 / 180) clockwise:YES];
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];
    // 底线左弧
    [path addArcWithCenter:CGPointMake(leftX + self.radius, bottomY - self.radius) radius:self.radius startAngle:(90 * M_PI_2/ 90) endAngle:(180 * M_PI_2/ 90) clockwise:YES];
    [path addLineToPoint:CGPointMake(leftX, topY + self.radius)];
    [path addArcWithCenter:CGPointMake(leftX + self.radius, topY + self.radius) radius:self.radius startAngle:(180 * M_PI_2/ 90) endAngle:(270 * M_PI_2/ 90) clockwise:YES];

    layer.path = path.CGPath;
    
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}


- (CGRect)drawRightTopWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    CGFloat leftX = point.x - self.markerWidth;
    CGFloat rigthX = point.x;
    CGFloat topY = point.y + self.arrowSize.height;
    CGFloat bottomY = point.y +self.markerHeight;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
    [path addLineToPoint:CGPointMake(rigthX - self.radius, topY )];
    [path addLineToPoint:CGPointMake(rigthX , topY - self.arrowSize.height)];
    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];
    // 右底弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, bottomY - self.radius) radius:self.radius startAngle:0 endAngle:(180 * M_PI_2 / 180) clockwise:YES];
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];
    // 底线左弧
    [path addArcWithCenter:CGPointMake(leftX + self.radius, bottomY - self.radius) radius:self.radius startAngle:(90 * M_PI_2/ 90) endAngle:(180 * M_PI_2/ 90) clockwise:YES];
    [path addLineToPoint:CGPointMake(leftX, topY + self.radius)];
    [path addArcWithCenter:CGPointMake(leftX + self.radius, topY + self.radius) radius:self.radius startAngle:(180 * M_PI_2/ 90) endAngle:(270 * M_PI_2/ 90) clockwise:YES];
    layer.path = path.CGPath;
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}


- (CGRect)drawRightBottomArrowWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    CGFloat leftX = point.x - self.markerWidth;
    CGFloat rigthX = point.x;
    CGFloat topY = point.y - self.markerHeight;
    CGFloat bottomY = topY + self.markerHeight -  self.arrowSize.height ;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
    [path addLineToPoint:CGPointMake(rigthX - self.radius, topY )];
 
    // 右弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, topY + self.radius) radius:self.radius startAngle:(270*M_PI_2/90) endAngle:0 clockwise:YES];
    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];
    // 右三角
   [path addLineToPoint:CGPointMake(rigthX, bottomY + self.arrowSize.height)];
    [path addLineToPoint:CGPointMake(rigthX - self.arrowSize.width, bottomY )];
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];
    // 底线左弧
    [path addArcWithCenter:CGPointMake(leftX + self.radius, bottomY - self.radius) radius:self.radius startAngle:(90 * M_PI_2/ 90) endAngle:(180 * M_PI_2/ 90) clockwise:YES];
    [path addLineToPoint:CGPointMake(leftX, topY + self.radius)];
    [path addArcWithCenter:CGPointMake(leftX + self.radius, topY + self.radius) radius:self.radius startAngle:(180 * M_PI_2/ 90) endAngle:(270 * M_PI_2/ 90) clockwise:YES];
    layer.path = path.CGPath;
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}

- (CGRect)drawBottomArrowWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    CGFloat leftX = point.x - self.markerWidth * 0.5;
    CGFloat rigthX = leftX + self.markerWidth;
    CGFloat topY = point.y - self.markerHeight;
    CGFloat bottomY = topY +self.markerHeight -  self.arrowSize.height;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
 
    [path addLineToPoint:CGPointMake(rigthX - self.radius, topY)];
    // 右弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, topY + self.radius) radius:self.radius startAngle:(270*M_PI_2/90) endAngle:0 clockwise:YES];
    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];
    // 右底弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, bottomY - self.radius) radius:self.radius startAngle:0 endAngle:(180 * M_PI_2 / 180) clockwise:YES];
    // 底中间三角
    [path addLineToPoint:CGPointMake(leftX + (self.markerWidth + self.arrowSize.width) / 2.0, bottomY )];
     [path addLineToPoint:CGPointMake( leftX + self.markerWidth / 2.0, bottomY + self.arrowSize.height )];
     [path addLineToPoint:CGPointMake(leftX + (self.markerWidth - self.arrowSize.width) / 2.0,bottomY)];
    
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];
    // 底线左弧
    [path addArcWithCenter:CGPointMake(leftX + self.radius, bottomY - self.radius) radius:self.radius startAngle:(90 * M_PI_2/ 90) endAngle:(180 * M_PI_2/ 90) clockwise:YES];
    [path addLineToPoint:CGPointMake(leftX, topY + self.radius)];
    [path addArcWithCenter:CGPointMake(leftX + self.radius, topY + self.radius) radius:self.radius startAngle:(180 * M_PI_2/ 90) endAngle:(270 * M_PI_2/ 90) clockwise:YES];
    
    layer.path = path.CGPath;
    
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}

- (CGRect)drawLeftBottomArrowWithLayer:(CAShapeLayer *)layer point:(CGPoint)point {
    CGFloat leftX = point.x;
    CGFloat rigthX = leftX + self.markerWidth;
    CGFloat topY = point.y - self.markerHeight;
    CGFloat bottomY = topY +self.markerHeight -  self.arrowSize.height;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(leftX + self.radius, topY)];
  
    [path addLineToPoint:CGPointMake(rigthX - self.radius, topY)];
    // 右弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, topY + self.radius) radius:self.radius startAngle:(270*M_PI_2/90) endAngle:0 clockwise:YES];
    // 右线
    [path addLineToPoint:CGPointMake(rigthX, bottomY - self.radius)];
    // 右底弧
    [path addArcWithCenter:CGPointMake(rigthX - self.radius, bottomY - self.radius) radius:self.radius startAngle:0 endAngle:(180 * M_PI_2 / 180) clockwise:YES];

    
    // 底线
    [path addLineToPoint:CGPointMake(leftX + self.radius, bottomY )];
     [path addLineToPoint:CGPointMake(leftX, bottomY + self.arrowSize.height)];

    // 左线左弧
    [path addLineToPoint:CGPointMake(leftX, topY + self.radius)];
    [path addArcWithCenter:CGPointMake(leftX + self.radius, topY + self.radius) radius:self.radius startAngle:(180 * M_PI_2/ 90) endAngle:(270 * M_PI_2/ 90) clockwise:YES];
    
    layer.path = path.CGPath;
    return CGRectMake(leftX, topY, rigthX - leftX, bottomY - topY);
}



@end
