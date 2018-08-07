//
//  XBFloatMenuView.h
//  AnXin
//
//  Created by xxb on 2018/2/15.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBAlertViewBase.h"

@class XBFloatMenuView;

typedef void (^XBFloatMenuViewClickBlock)(NSInteger index);

@interface XBFloatMenuView : XBAlertViewBase
- (instancetype)initWithDisplayView:(id)displayView titleArr:(NSArray <NSString *>*)titleArr imgArr:(NSArray <UIImage *>*)imgArr width:(CGFloat)width spaceToTop:(CGFloat)spaceToTop spaceToRight:(CGFloat)spaceToRight;
@property (nonatomic,copy) XBFloatMenuViewClickBlock bl_click;
@end
