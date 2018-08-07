//
//  XBWaitingView.m
//  AnXin
//
//  Created by xxb on 2018/3/20.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBWaitingView.h"
#import "UIView+Animation.h"

@interface XBWaitingView ()
@property (nonatomic,strong) UIImageView *imgV_icon;
@end

@implementation XBWaitingView


- (void)dealloc
{
    NSLog(@"XBWaitingView销毁");
}

- (void)actionBeforeShow
{
    self.fadeInFadeOut = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
//    self.layer.masksToBounds = YES;
    self.hideWhileTouchOtherArea = NO;
    self.backgroundViewColor = [UIColor clearColor];
    
    self.layer.shadowColor = XBColor_gray_100_100_102.CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 8;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.imgV_icon.image = XBImage_tip加载;
    [self.imgV_icon xb_makeRotationFromAngle:0 toAngle:180 k_keyPath_rotation:k_keyPath_rotation_aroundY duration:1 repeatCount:100000];
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(alertView.superview);
            make.size.mas_equalTo(CGSizeMake(72, 72));
        }];
    };
    
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(alertView.superview);
            make.size.mas_equalTo(CGSizeMake(72, 72));
        }];
    };
    
    
}

- (UIImageView *)imgV_icon
{
    if (_imgV_icon == nil)
    {
        _imgV_icon = [UIImageView new];
        [self addSubview:_imgV_icon];
        [_imgV_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(42, 42));
        }];
    }
    return _imgV_icon;
}

@end
