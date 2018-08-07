//
//  BaseBackViewController.m
//  ip116_plus
//
//  Created by abovelink on 2017/2/16.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "BaseBackViewController.h"
#import "AppDelegate.h"


@interface BaseBackViewController ()

@end

@implementation BaseBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    setNavigationBarBackgroundImg

    
    [self.leftButtonItem setNeedsDisplay];
    [self.rightButtonItem setNeedsDisplay];
}

- (void)buildUI
{
    [super buildUI];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:XBColor_white}];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self buildButtonItem];
}

-(void)buildButtonItem
{
    self.leftButtonItem = [XBButton new];
    
    self.leftButtonItem.backgroundColor = [UIColor clearColor];
    if (SystemVersion >= 11)
    {
        [self.leftButtonItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 44));
        }];
    }
    else
    {
        self.leftButtonItem.frame = CGRectMake(0, 0, 70, 44);
    }
    self.leftButtonItem.img_normal = XBImage_返回默认;
    self.leftButtonItem.img_highlight = XBImage_返回按下;
    self.leftButtonItem.size_image = CGSizeMake(18, 18);
    self.leftButtonItem.enum_contentSide = XBBtnSideLeft;
    self.leftButtonItem.f_spaceToContentSide = 16;
    [self.leftButtonItem addTarget:self action:@selector(leftButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:self.leftButtonItem];
    
    self.rightButtonItem = [XBButton new];
    self.rightButtonItem.backgroundColor = [UIColor clearColor];
    if (SystemVersion >= 11)
    {
        [self.rightButtonItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 44));
        }];
    }
    else
    {
        self.rightButtonItem.frame = CGRectMake(0, 0, 70, 44);
    }
    self.rightButtonItem.img_normal = UIImageName(@"nav_icon_add");
    self.rightButtonItem.size_image = CGSizeMake(18, 18);
    [self.rightButtonItem addTarget:self action:@selector(rightButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButtonItem.enum_contentSide = XBBtnSideRight;
    self.rightButtonItem.f_spaceToContentSide = 16;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButtonItem];
    self.rightButtonItem.font_title = UIFont(13);
    self.rightButtonItem.color_titleNormal = XBColor_white;
    self.rightButtonItem.color_titleHighlight = XBColor_textHightlight_white;
    
    self.rightButtonItem.hidden = YES;
}
#pragma mark - btn action
-(void)leftButtonItemAction:(UIButton *)sender
{
    [self hiddenWaitting];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)rightButtonItemAction:(UIButton *)sender
{
    
}

#pragma mark -
-(UIStatusBarStyle)preferredStatusBarStyle
{
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}


- (void)pushToVc:(UIViewController *)vc
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (XBButton *)btn_bottom
{
    if (_btn_bottom == nil)
    {
        _btn_bottom = [self createBtn_style_1];
        [self.view addSubview:_btn_bottom];
        
        [_btn_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(- kLeftSpaceToScreen);
            make.bottom.equalTo(self.view).offset(- GHeightFactorFun(10) - SafeAreaBottomHeight);
            make.left.equalTo(self.view).offset(kLeftSpaceToScreen);
            make.height.mas_equalTo(GHeightFactorFun(40));
        }];
        _btn_bottom.font_title = UIFont(GWidthFactorFun(15));
        
        WEAK_SELF

        _btn_bottom.bl_click = ^(XBButton *weakBtn) {
            [weakSelf bottomBtnClick:weakBtn];
        };
    }
    return _btn_bottom;
}
- (void)bottomBtnClick:(XBButton *)btn
{}

- (void)showAlert:(NSString *)msg
{
    XBAlertView *alertView = [[XBAlertView alloc] initWithMessage:msg cancelButtonTitle:XBText_好的];
    [alertView show];
}
- (void)showAlert:(NSString *)msg block:(NoResultNoParamBlock)block
{
    XBAlertView *alertView = [[XBAlertView alloc] initWithMessage:msg cancelButtonTitle:XBText_好的];
    [alertView showUsingBlock:^(XBAlertView *alertView, NSInteger index) {
        if (block)
        {
            block();
        }
    }];
}
- (void)showTip:(NSString *)msg
{
    
}
- (void)showWaitting:(NSString *)msg
{
    if ([self.v_waitting isShowState])
    {
        return;
    }
    self.v_waitting = [[XBWaitingView alloc] initWithDisplayView:self.view];
    [self.v_waitting show];
}
- (void)hiddenWaitting
{
    if ([self.v_waitting isShowState] == NO)
    {
        return;
    }
    [self.v_waitting hidden];
    self.v_waitting = nil;
}
- (void)showWaittingOnWindow:(NSString *)msg
{
    if ([self.v_waitting isShowState])
    {
        return;
    }
    self.v_waitting = [[XBWaitingView alloc] initWithDisplayView:[[UIApplication sharedApplication].delegate window]];
    [self.v_waitting show];
}


- (void)endRefreshStatus
{
    
}
- (void)startRefreshStatus
{
    
}



#pragma mark - 工厂方法
///统一背景、统一字体、统一弧度、统一颜色
- (XBButton *)createBtn_style_1
{
    XBButton *btn = [XBButton new];
    btn.layer.cornerRadius = 3;
    btn.backgroundColor = XBColor_nav;
    btn.str_titleNormal = XBText_新增送餐地址;
    btn.color_titleNormal = XBColor_white;
    btn.font_title = UIFont(15);
    btn.color_backgroundHighlight = [XBColor_nav colorWithAlphaComponent:0.7];
    return btn;
}


@end
