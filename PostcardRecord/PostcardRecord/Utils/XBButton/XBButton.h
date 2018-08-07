//
//  XBButton.h
//  DrawTest
//
//  Created by xxb on 2017/11/2.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XBBtnTypeImageLeft,//图片在左
    XBBtnTypeImageRight,//文字在左
    XBBtnTypeImageTop,//图片在上
    XBBtnTypeImageBottom//文字在上
} XBBtnContentType;

typedef enum : NSUInteger {
    XBBtnSideCenter,
    XBBtnSideLeft,
    XBBtnSideRight,
    XBBtnSideTop,
    XBBtnSideBottom
} XBBtnContentSide;

@class XBButton;

typedef void(^XBActionBlock)(XBButton *weakBtn);

@interface XBButton : UIControl

@property (nonatomic,strong) UILabel *lb_title;
@property (nonatomic,strong) UIImageView *imgv_image;

/** 图片和文字排布样式 ，默认图片在左*/
@property (nonatomic,assign) XBBtnContentType enum_contentType;

/** 内容（图片和文字）是靠哪个方向对齐，上下左右，默认居中 */
@property (nonatomic,assign) XBBtnContentSide enum_contentSide;

/** 图片和文字的间距 */
@property (nonatomic,assign) CGFloat f_spaceOfImageAndTitle;

/** 内容（图片和文字）到对齐方向边缘的距离，内容在中间时不起作用 */
@property (nonatomic,assign) CGFloat f_spaceToContentSide;

@property (nonatomic,assign) CGSize size_image;

@property (nonatomic,strong) UIImage *img_normal;
@property (nonatomic,strong) UIImage *img_selected;
@property (nonatomic,strong) UIImage *img_highlight;

@property (nonatomic,copy) NSString *str_titleNormal;
@property (nonatomic,copy) NSString *str_titleSelected;
@property (nonatomic,copy) NSString *str_titleHighlight;

@property (nonatomic,copy) NSMutableAttributedString *str_title_attributed;

@property (nonatomic,strong) UIColor *color_titleNormal;
@property (nonatomic,strong) UIColor *color_titleSelected;
@property (nonatomic,strong) UIColor *color_titleHighlight;

@property (nonatomic,strong) UIImage *img_backgroundNormal;
@property (nonatomic,strong) UIImage *img_backgroundSelected;
@property (nonatomic,strong) UIImage *img_backgroundHighlight;

@property (nonatomic,strong) UIColor *color_backgroundHighlight;
@property (nonatomic,strong) UIColor *color_backgroundselected;

@property (nonatomic,strong) UIFont *font_title;

/** 点击回调 */
@property (nonatomic,copy) XBActionBlock bl_click;

@end
