//
//  UIView+Category.m
//  aw1_plus
//
//  Created by 孙录 on 2016/12/13.
//  Copyright © 2016年 sven. All rights reserved.
//

#import "UIView+Category.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (Category)
- (void )CutCircleWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //切圆半径
    self.layer.cornerRadius = radius;
    //给图层添加一个有色边框
    self.layer.borderWidth = borderWidth;
    //有色边框颜色
    self.layer.borderColor = borderColor.CGColor;//(__bridge CGColorRef _Nullable)(borderColor);
    //开启切圆功能
    self.layer.masksToBounds = YES;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(CGFloat)max_y
{
    return (self.y+self.height);
}
-(CGFloat)max_x
{
    return (self.x+self.width);
}
-(CGFloat)center_x
{
    return (self.width/2.0);
}
-(CGFloat)center_y
{
    return (self.height/2.0);
}
-(CGPoint)boundsCenter
{
    return CGPointMake(self.center_x, self.center_y);
}
-(CGPoint)frameCenter
{
    return CGPointMake(self.x+self.center_x, self.y+self.center_y);
}
-(CGPoint)leftTopPoint
{
    return CGPointMake(self.x, self.y);
}
-(CGPoint)rightTopPoint
{
    return CGPointMake(self.max_x, self.y);
}
-(CGPoint)leftBottomPoint
{
    return CGPointMake(self.x, self.max_y);
}
-(CGPoint)rightBottomPoint
{
    return CGPointMake(self.max_x, self.max_y);
}
-(CGPoint)topCenterPoint
{
    return CGPointMake(self.center_x, self.y);
}
-(CGPoint)bottomCenterPoint
{
    return CGPointMake(self.center_x, self.max_y);
}
-(CGPoint)leftCenterPoint
{
    return CGPointMake(self.x, self.center_y);
}
-(CGPoint)rightCenterPoint
{
    return CGPointMake(self.max_x, self.center_y);
}

-(void)triangleViewPoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3 lineColor:(UIColor*)lineColor fillColor:(UIColor*)fillColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);//画笔线的颜色;
    CGContextSetLineWidth(context, 1.0);//线的宽度
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =p1;//坐标1
    sPoints[1] =p2;//坐标2
    sPoints[2] =p3;//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}

@end
