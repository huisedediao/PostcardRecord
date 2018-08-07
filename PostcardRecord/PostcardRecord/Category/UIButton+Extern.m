//
//  UIButton+Extern.m
//  smanos
//
//  Created by sven on 3/2/16.
//  Copyright © 2016 sven. All rights reserved.
//

#import "UIButton+Extern.h"
#import "UIImage+ColorImage.h"
#import "UIColor+Extern.h"

@implementation UIButton (Extern)

+ (UIButton *)buttonWithImage:(NSString *)image
               highlightImage:(NSString *)highlightImage
                          tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    btn.tag = tag;
    return btn;
}

+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}



+ (UIButton *)buttonWithBgColor:(UIColor *)color titleColor:(UIColor *)titleColor title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#257DBD"]] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTintColor:[UIColor redColor]];

    return btn;
}

@end
