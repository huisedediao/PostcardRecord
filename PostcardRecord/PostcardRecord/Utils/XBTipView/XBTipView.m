//
//  XBTipView.m
//  AnXin
//
//  Created by xxb on 2018/3/20.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBTipView.h"

@interface XBTipView ()
@property (nonatomic,strong) UIImageView *imgV_icon;
@property (nonatomic,strong) UILabel *lb_tip;
@property (nonatomic,assign) CGFloat f_hiddenTime;
@end

@implementation XBTipView

+ (void)showSuccessTip:(NSString *)tip onView:(UIView *)view hiddenTime:(CGFloat)hiddenTime
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].delegate window];
    }
    XBTipView *tipView = [[XBTipView alloc] initWithDisplayView:view];
    tipView.imgV_icon.image = XBImage_tip成功;
    tipView.lb_tip.text = tip;
    tipView.f_hiddenTime = hiddenTime;
    [tipView show];
}

+ (void)showFailureTip:(NSString *)tip onView:(UIView *)view hiddenTime:(CGFloat)hiddenTime
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].delegate window];
    }
    XBTipView *tipView = [[XBTipView alloc] initWithDisplayView:view];
    tipView.imgV_icon.image = XBImage_tip失败;
    tipView.lb_tip.text = tip;
    tipView.f_hiddenTime = hiddenTime;
    [tipView show];
}

+ (void)showBusyTip:(NSString *)tip onView:(UIView *)view hiddenTime:(CGFloat)hiddenTime
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].delegate window];
    }
    XBTipView *tipView = [[XBTipView alloc] initWithDisplayView:view];
    tipView.imgV_icon.image = XBImage_tip繁忙;
    tipView.lb_tip.text = tip;
    tipView.f_hiddenTime = hiddenTime;
    [tipView show];
}

+ (void)showWarnTip:(NSString *)tip onView:(UIView *)view hiddenTime:(CGFloat)hiddenTime
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].delegate window];
    }
    XBTipView *tipView = [[XBTipView alloc] initWithDisplayView:view];
    tipView.imgV_icon.image = XBImage_tip警示;
    tipView.lb_tip.text = tip;
    tipView.f_hiddenTime = hiddenTime;
    [tipView show];
}




+ (void)showSuccessTip:(NSString *)tip hiddenTime:(CGFloat)hiddenTime
{
    [XBTipView showSuccessTip:tip onView:nil hiddenTime:hiddenTime];
}

+ (void)showFailureTip:(NSString *)tip hiddenTime:(CGFloat)hiddenTime
{
    [XBTipView showFailureTip:tip onView:nil hiddenTime:hiddenTime];
}

+ (void)showBusyTip:(NSString *)tip hiddenTime:(CGFloat)hiddenTime
{
    [XBTipView showBusyTip:tip onView:nil hiddenTime:hiddenTime];
}

+ (void)showWarnTip:(NSString *)tip hiddenTime:(CGFloat)hiddenTime
{
    [XBTipView showWarnTip:tip onView:nil hiddenTime:hiddenTime];
}




+ (void)showSuccessTip:(NSString *)tip onView:(UIView *)view
{
    [XBTipView showSuccessTip:tip onView:view hiddenTime:k_tipHiddenTime];
}

+ (void)showFailureTip:(NSString *)tip onView:(UIView *)view
{
    [XBTipView showFailureTip:tip onView:view hiddenTime:k_tipHiddenTime];
}

+ (void)showBusyTip:(NSString *)tip onView:(UIView *)view
{
    [XBTipView showBusyTip:tip onView:view hiddenTime:k_tipHiddenTime];
}

+ (void)showWarnTip:(NSString *)tip onView:(UIView *)view
{
    [XBTipView showWarnTip:tip onView:view hiddenTime:k_tipHiddenTime];
}




+ (void)showSuccessTip:(NSString *)tip
{
    [XBTipView showSuccessTip:tip onView:nil];
}

+ (void)showFailureTip:(NSString *)tip
{
    [XBTipView showFailureTip:tip onView:nil];
}

+ (void)showBusyTip:(NSString *)tip
{
    [XBTipView showBusyTip:tip onView:nil];
}

+ (void)showWarnTip:(NSString *)tip
{
    [XBTipView showWarnTip:tip onView:nil];
}



- (void)dealloc
{
    NSLog(@"XBTipView销毁");
}

- (void)actionBeforeShow
{
    if (self.lb_tip.text.length == 0)
    {
        [self.imgV_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
    }
    self.fadeInFadeOut = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.hideWhileTouchOtherArea = NO;
    self.backgroundViewColor = [UIColor clearColor];
    
    CGFloat selfWidth = 80;
    NSString *title = self.lb_tip.text;
    UIFont *font = self.lb_tip.font;
    CGFloat tipStrWidth = getWidthWith_title_font(title, font) + 20;
    if (tipStrWidth > selfWidth)
    {
        selfWidth = tipStrWidth;
    }
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(alertView.superview);
            make.size.mas_equalTo(CGSizeMake(selfWidth, 80));
        }];
    };
    
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(alertView.superview);
            make.size.mas_equalTo(CGSizeMake(selfWidth, 80));
        }];
    };
    
    [self hiddenAfterSecond:self.f_hiddenTime == 0 ? k_tipHiddenTime : self.f_hiddenTime];
}


- (UIImageView *)imgV_icon
{
    if (_imgV_icon == nil)
    {
        _imgV_icon = [UIImageView new];
        [self addSubview:_imgV_icon];
        [_imgV_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(- 10);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
    }
    return _imgV_icon;
}
- (UILabel *)lb_tip
{
    if (_lb_tip == nil)
    {
        _lb_tip = [UILabel new];
        [self addSubview:_lb_tip];
        [_lb_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_imgV_icon.mas_bottom).offset(8.5);
        }];
        _lb_tip.font = UIFont(12);
        _lb_tip.textColor = [UIColor whiteColor];
    }
    return _lb_tip;
}
@end
