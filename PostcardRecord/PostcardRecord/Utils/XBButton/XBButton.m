//
//  XBButton.m
//  DrawTest
//
//  Created by xxb on 2017/11/2.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "XBButton.h"
#import "Masonry.h"
#import <objc/message.h>

@interface XBButton ()
@property (nonatomic,strong) UIImageView *imgv_background;
@property (nonatomic,strong) UIView *v_content;
@end

@implementation XBButton

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initParams];
        [self createSubviews];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initParams];
        [self createSubviews];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setContentViewSubviewsParams];
    [self setContentViewSubviewsLayout];
    [self setContentLayout];
    
    if (self.isHighlighted)
    {
        if(self.color_backgroundHighlight)
        {
            [self.color_backgroundHighlight set];
            UIRectFill(rect);
        }
    }
    else if (self.isSelected)
    {
        if(self.color_backgroundselected)
        {
            [self.color_backgroundselected set];
            UIRectFill(rect);
        }
    }
}
- (void)dealloc
{
    NSLog(@"%@销毁",NSStringFromClass([self class]));
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self removeObserver:self forKeyPath:[keyPath substringFromIndex:1]];
    }
}

#pragma mark - 初始化
- (void)initParams
{
    self.layer.masksToBounds = YES;
    [self addTarget:self action:@selector(selfClick) forControlEvents:UIControlEventTouchUpInside];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self addObserver:self forKeyPath:[keyPath substringFromIndex:1] options:NSKeyValueObservingOptionNew context:nil];
    }
    self.backgroundColor = [UIColor clearColor];
}
- (void)createSubviews
{
    self.imgv_background = [UIImageView new];
    self.imgv_background.userInteractionEnabled = NO;
    [self addSubview:self.imgv_background];
    [self.imgv_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.v_content = [UIView new];
    [self addSubview:self.v_content];
    self.v_content.userInteractionEnabled = NO;

    self.lb_title = [UILabel new];
    [self.v_content addSubview:self.lb_title];

    self.imgv_image = [UIImageView new];
    [self.v_content addSubview:self.imgv_image];
}

#pragma mark - 观察者回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self setNeedsDisplay];
}


#pragma mark - 设置参数
- (void)setContentViewSubviewsParams
{
    if (self.str_title_attributed)
    {
        self.lb_title.attributedText = self.str_title_attributed;
    }
    else
    {
        self.lb_title.text = [self getTitle];
        self.lb_title.textColor = [self getTitleColor];
        self.lb_title.font = self.font_title;
    }

    self.imgv_image.image = [self getImage];
    self.imgv_background.image = [self getBackgroundImage];
}


#pragma mark - 其他方法
- (UIImage *)getImage
{
    UIImage *image = self.isHighlighted ? self.img_highlight : (self.selected ? self.img_selected : self.img_normal);
    return image ? image : self.img_normal;
}
- (NSString *)getTitle
{
    NSString *title = self.isHighlighted ? self.str_titleHighlight : (self.selected ? self.str_titleSelected : self.str_titleNormal);
    return title ? title : self.str_titleNormal;
}
- (UIColor *)getTitleColor
{
    UIColor *color = self.isHighlighted ? self.color_titleHighlight : (self.selected ? self.color_titleSelected : self.color_titleNormal);
    return color ? color : self.color_titleNormal;
}
- (UIImage *)getBackgroundImage
{
    UIImage *image = self.isHighlighted ? self.img_backgroundHighlight : (self.selected ? self.img_backgroundSelected : self.img_backgroundNormal);
    return image ? image : self.img_backgroundNormal;
}


#pragma mark - 方法重写
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsLayout];
}

#pragma mark - 点击事件
-(void)selfClick{}
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.bl_click)
    {
        typeof(self) __weak weakSelf = self;
        XBActionBlock block = [self.bl_click copy];
        block(weakSelf);
    }
    else
    {
        [super sendAction:action to:target forEvent:event];
    }
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (target == self)
    {
        if ([self actionsForTarget:self forControlEvent:controlEvents])
        {
            return;
        }
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
    else
    {
        if ([self actionsForTarget:self forControlEvent:controlEvents])
        {
            [self removeTarget:self action:action forControlEvents:controlEvents];
        }
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
}

#pragma mark - 布局

- (void)setContentViewSubviewsLayout
{
    [self.imgv_image mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.lb_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    CGSize imageSize = CGSizeZero;
    if (CGSizeEqualToSize(self.size_image, CGSizeZero) == false)
    {
        if ([self getImage])
        {
            imageSize = self.size_image;
        }
    }
    else
    {
        imageSize = [self getImage].size;
    }
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imageSize);
    }];
    
    switch (self.enum_contentType)
    {
        case XBBtnTypeImageLeft:
        {
            [self contentSubviewsLayoutForType_left];
        }
            break;
        case XBBtnTypeImageRight:
        {
            [self contentSubviewsLayoutForType_right];
        }
            break;
        case XBBtnTypeImageTop:
        {
            [self contentSubviewsLayoutForType_top];
        }
            break;
        case XBBtnTypeImageBottom:
        {
            [self contentSubviewsLayoutForType_bottom];
        }
            break;
            
        default:
            break;
    }
}
- (void)setContentLayout
{
    switch (self.enum_contentSide)
    {
        case XBBtnSideCenter:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        }
            break;
        case XBBtnSideLeft:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(self.f_spaceToContentSide);
            }];
        }
            break;
        case XBBtnSideRight:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(- self.f_spaceToContentSide);
            }];
        }
            break;
        case XBBtnSideTop:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(self.f_spaceToContentSide);
            }];
        }
            break;
        case XBBtnSideBottom:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self).offset(- self.f_spaceToContentSide);
            }];
        }
            break;
            
        default:
            break;
    }
    
    CGFloat offset_v_content = 0;
    if (self.enum_contentType == XBBtnTypeImageLeft || self.enum_contentType == XBBtnTypeImageRight)
    {
        offset_v_content = self.f_spaceToContentSide;
    }
    [self.v_content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self).offset(- offset_v_content).priority(1000);
    }];
}
- (void)contentSubviewsLayoutForType_left
{
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.imgv_image.mas_right).offset(self.f_spaceOfImageAndTitle);
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_right
{
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
    }];
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.lb_title.mas_right).offset(self.f_spaceOfImageAndTitle);
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_top
{
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.top.equalTo(self.v_content);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.top.equalTo(self.imgv_image.mas_bottom).offset(self.f_spaceOfImageAndTitle);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_bottom
{
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.bottom.equalTo(self.v_content);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.bottom.equalTo(self.imgv_image.mas_top).offset(- self.f_spaceOfImageAndTitle);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
    }];
}
@end
