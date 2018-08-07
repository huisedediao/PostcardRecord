//
//  XBFloatMenuView.m
//  AnXin
//
//  Created by xxb on 2018/2/15.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBFloatMenuView.h"
#import "UIView+FrameLayout.h"

#define btnTagBase (133453)

@interface XBFloatMenuView ()
@property (nonatomic,strong) NSArray *arr_img;
@property (nonatomic,strong) NSArray *arr_title;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat spaceToTop;
@property (nonatomic,assign) CGFloat spaceToRight;
@end

@implementation XBFloatMenuView

- (void)dealloc
{
    NSLog(@"XBFloatMenuView销毁");
}

- (instancetype)initWithDisplayView:(id)displayView titleArr:(NSArray <NSString *>*)titleArr imgArr:(NSArray <UIImage *>*)imgArr width:(CGFloat)width spaceToTop:(CGFloat)spaceToTop spaceToRight:(CGFloat)spaceToRight
{
    if (self = [super initWithDisplayView:displayView])
    {
        self.backgroundViewColor = XBColor_clear;
        self.layer.cornerRadius = 3;
        self.fadeInFadeOut = YES;
        
        self.layer.shadowColor = XBColor_gray_100_100_102.CGColor;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        
        self.arr_title = titleArr;
        self.arr_img = imgArr;
        self.width = width;
        self.spaceToTop = spaceToTop;
        self.spaceToRight = spaceToRight;
    }
    return self;
}

- (void)actionBeforeShow
{
    UIView *lastView = nil;
    WEAK_SELF
    for (int i = 0; i < self.arr_title.count; i++)
    {
        XBButton *btn = [XBButton new];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(GHeightFactorFun(36));
            make.left.right.equalTo(self);
            if (i == 0)
            {
                make.top.equalTo(self);
            }
            else
            {
                make.top.equalTo(lastView.mas_bottom);
            }
        }];
        
        btn.str_titleNormal = self.arr_title[i];
        btn.tag = i + btnTagBase;
        
        btn.img_normal = self.arr_img[i];
        btn.size_image = CGSizeMake(GHeightFactorFun(20), GHeightFactorFun(20));
        btn.f_spaceToContentSide = GWidthFactorFun(9);
        btn.f_spaceOfImageAndTitle = GWidthFactorFun(6);
        btn.font_title = UIFont(GWidthFactorFun(12));
        btn.color_titleNormal = XBColor_black_51_51_51;
        btn.enum_contentSide = XBBtnSideLeft;
        btn.bl_click = ^(XBButton *weakBtn) {
            [weakSelf hidden];
            if (weakSelf.bl_click)
            {
                weakSelf.bl_click(weakBtn.tag - btnTagBase);
            }
        };
        lastView = btn;
        
        //分割线
        UIView *line = [UIView new];
        [self addSubview:line];
        line.backgroundColor = XBColor_gray_230_230_230;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(SINGLE_LINE_WIDTH);
        }];
    }
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView xb_size:CGSizeMake(weakSelf.width, GHeightFactorFun(36 * weakSelf.arr_title.count))];
        [alertView xb_top:weakSelf.spaceToTop];
        [alertView xb_left:kScreenWidth - [alertView xb_width] - weakSelf.spaceToRight];
    };
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView xb_size:CGSizeMake(weakSelf.width, GHeightFactorFun(36 * weakSelf.arr_title.count))];
        [alertView xb_top:weakSelf.spaceToTop];
        [alertView xb_left:kScreenWidth - [alertView xb_width] - weakSelf.spaceToRight];
    };
}


@end
