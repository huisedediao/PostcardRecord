//
//  UIView+Category.h
//  aw1_plus
//
//  Created by 孙录 on 2016/12/13.
//  Copyright © 2016年 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
- (void )CutCircleWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


-(CGFloat)x;
-(CGFloat)y;
-(CGFloat)max_y;
-(CGFloat)max_x;
-(CGFloat)width;
-(CGFloat)height;
-(CGFloat)center_x;
-(CGFloat)center_y;
-(CGPoint)boundsCenter;
-(CGPoint)frameCenter;
-(CGPoint)leftTopPoint;
-(CGPoint)rightTopPoint;
-(CGPoint)leftBottomPoint;
-(CGPoint)rightBottomPoint;
-(CGPoint)topCenterPoint;
-(CGPoint)bottomCenterPoint;
-(CGPoint)leftCenterPoint;
-(CGPoint)rightCenterPoint;
//画三角形
-(void)triangleViewPoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3 lineColor:(UIColor*)lineColor fillColor:(UIColor*)fillColor;
@end
