//
//  XBAlertView_sharePay.m
//  AnXin
//
//  Created by xxb on 2018/2/1.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBAlertView_sharePay.h"

#define btnTagBase (100112)

@implementation XBAlertView_sharePay

- (void)actionBeforeShow
{
    self.color_btnTitle_prominent = XBColor_gray_204_204_204;
    
    __block UIView *contentView = [UIView new];
    
//    NSArray *arr_image_nor = @[XBImage_微信,XBImage_QQ];
    NSArray *arr_image_nor = @[XBImage_微信];
    NSArray *arr_image_hl = @[XBImage_微信,XBImage_QQ];
    NSArray *arr_title = @[XBText_微信好友,XBText_QQ好友];
    
    CGFloat btnWidth = 65;
    CGFloat selfWidth = 70 + arr_image_nor.count * btnWidth;
    if (selfWidth < 150)
    {
        selfWidth = 150;
    }
    
    WEAK_SELF
    __block UIView *lastView = nil;
    NSInteger count = arr_image_nor.count;
    for (int i = 0; i < count; i++)
    {
        CGFloat offset = 10;
        XBButton *btn = [XBButton new];
        [contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(btnWidth, 70));
            make.centerY.equalTo(contentView);
            if (lastView == nil)
            {
                make.left.equalTo(contentView).offset(10);
            }
            else
            {
                make.left.equalTo(lastView.mas_right).offset(10);
            }
            if (i == count - 1)
            {
                make.right.lessThanOrEqualTo(contentView).offset(- offset);
            }
        }];
        lastView = btn;
        btn.str_titleNormal = arr_title[i];
        btn.img_normal = arr_image_nor[i];
        btn.img_highlight = arr_image_hl[i];
        btn.tag = btnTagBase + i;
        btn.enum_contentType = XBBtnTypeImageTop;
        btn.size_image = CGSizeMake(40, 40);
        btn.f_spaceOfImageAndTitle = 8;
        btn.font_title = UIFont(11);
        btn.color_titleNormal = XBColor_black_51_51_51;
        btn.color_titleHighlight = XBColor_textHightlight_gray;
        btn.bl_click = ^(XBButton *weakBtn) {
            if ([weakSelf.delegate respondsToSelector:@selector(alertView:clickedBtnAtIndex:)])
            {
                //1：微信好友 2：qq好友
                [weakSelf.delegate alertView:weakSelf clickedBtnAtIndex:weakBtn.tag - btnTagBase + 1];
            }
            [weakSelf hidden];
        };
    }
    
    
    [self customView:contentView size:contentView.frame.size];
    
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.v_customViewBG);
        make.height.mas_equalTo(70);
        make.centerX.equalTo(self.v_customViewBG);
        make.bottom.lessThanOrEqualTo(self.v_customViewBG).offset(0);
        make.trailing.lessThanOrEqualTo(self.v_customViewBG).offset(0);
    }];
    
    [super actionBeforeShow];
    
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(selfWidth);
            make.center.equalTo(alertView.superview);
        }];
    };
    
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(selfWidth);
            make.center.equalTo(alertView.superview);
        }];
    };
}

- (CGFloat)getSpaceOfTitleAndMsg
{
    return 7.5;
}

- (CGFloat)getSpaceOfTopAndTitle
{
    return 12.5;
}
- (CGFloat)getSpaceOfCustomViewAndButton
{
    return 10;
}
@end
