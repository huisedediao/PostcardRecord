//
//  BaseBackViewController.h
//  ip116_plus
//
//  Created by abovelink on 2017/2/16.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "BaseViewController.h"
#import "XBButton.h"

//已经登录的回调
typedef void (^BaseBackViewControllerLoginedBlock)(void);
//未登录的回调
typedef void (^BaseBackViewControllerUnLoginedBlock)(void);

@interface BaseBackViewController : BaseViewController

@property (nonatomic,strong) XBWaitingView *v_waitting;

@property (strong, nonatomic) UIView *headerView;

//底部的按钮，统一样式
@property (nonatomic,strong) XBButton *btn_bottom;

//@property (strong, nonatomic) UIButton *leftButtonItem;
//@property (strong, nonatomic) UIButton *rightButtonItem;
@property (strong, nonatomic) XBButton *leftButtonItem;
@property (strong, nonatomic) XBButton *rightButtonItem;


- (void)leftButtonItemAction:(XBButton *)sender;
- (void)rightButtonItemAction:(XBButton *)sender;
- (void)bottomBtnClick:(XBButton *)btn;
- (void)pushToVc:(UIViewController *)vc;


///统一背景、统一字体、统一弧度、统一颜色
- (XBButton *)createBtn_style_1;

- (void)showAlert:(NSString *)msg;
- (void)showAlert:(NSString *)msg block:(NoResultNoParamBlock)block;
- (void)showTip:(NSString *)msg;
- (void)showWaitting:(NSString *)msg;
- (void)showWaittingOnWindow:(NSString *)msg;
- (void)hiddenWaitting;

- (void)endRefreshStatus;
- (void)startRefreshStatus;
@end
