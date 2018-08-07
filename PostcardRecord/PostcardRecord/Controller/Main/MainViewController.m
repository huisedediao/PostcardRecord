//
//  MainViewController.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "MainViewController.h"
#import "SeriesDetailViewController.h"
#import "LoginTool.h"
#import "XBFloatMenuView.h"
#import "XBAlertView_login.h"
#import "SyncTool.h"

@interface MainViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbv_content;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = XBText_系列列表;
    
    [self addNotice];
}

- (void)addNotice
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:XBNotice_loginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:XBNotice_loginOut object:nil];
}
- (void)removeNotice
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loginSuccess:(NSNotification *)noti
{
    [self regreshLeftTitle];
}

- (void)loginOut:(NSNotification *)noti
{
    [self regreshLeftTitle];
}
- (void)dealloc
{
    [self removeNotice];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tbv_content reloadData];
}

- (void)regreshLeftTitle
{
    if ([[LoginTool shared] isLogined])
    {
        self.leftButtonItem.str_titleNormal = XBText_同步;
    }
    else
    {
        self.leftButtonItem.str_titleNormal = XBText_登陆注册;
    }
}

- (void)buildUI
{
    [super buildUI];
    WEAK_SELF
    
    self.leftButtonItem.img_normal = nil;
    self.leftButtonItem.img_highlight = nil;
    
    self.leftButtonItem.font_title = UIFont(13);
    self.leftButtonItem.color_titleNormal = XBColor_white;
    self.leftButtonItem.color_titleHighlight = XBColor_textHightlight_white;
    
    [self regreshLeftTitle];
    self.leftButtonItem.bl_click = ^(XBButton *weakBtn) {
        CGFloat width = 66;
        if ([LoginTool shared].isLogined)
        {
            //同步（上传或者下载）
            XBFloatMenuView *menu = [[XBFloatMenuView alloc] initWithDisplayView:[AppDelegate shared].window titleArr:@[XBText_上传,XBText_下载] imgArr:nil width:width spaceToTop:StatusBarHeight + 40 spaceToRight:kScreenWidth - width - 10];
            menu.bl_click = ^(NSInteger index) {
                if (index == 0)
                {
                    [weakSelf showWaitting:nil];
                    [[SyncTool shared] uploadDataForUserName:[LoginTool shared].curUserName block:^(BOOL successed) {
                        [weakSelf hiddenWaitting];
                        if (successed)
                        {
                            [XBTipView showSuccessTip:XBText_成功];
                        }
                        else
                        {
                            [XBTipView showSuccessTip:XBText_失败];
                        }
                    }];
                }
                else
                {
                    [weakSelf showWaitting:nil];
                    [[SyncTool shared] downloadDataForUserName:[LoginTool shared].curUserName block:^(BOOL successed) {
                        [weakSelf hiddenWaitting];
                        if (successed)
                        {
                            [XBTipView showSuccessTip:XBText_成功];
                            [weakSelf.tbv_content reloadData];
                        }
                        else
                        {
                            [XBTipView showSuccessTip:XBText_失败];
                        }
                    }];
                }
            };
            [menu show];
        }
        else
        {
            //登陆或者注册
            XBAlertView_login *loginView = [[XBAlertView_login alloc] initWithTitle:XBText_登陆注册 message:XBText_未注册则自动注册 cancelButtonTitle:XBText_取消 otherButtonTitle:XBText_确定];
            [loginView showUsingBlock:^(XBAlertView *alertView, NSInteger index) {
                if (index == 0)
                {
                    
                }
                else if (index == 1)
                {
                    XBAlertView_login *alertView_l = (XBAlertView_login *)alertView;
                    NSString *userName = alertView_l.userName;
                    NSString *pwd = alertView_l.pwd;
                    if (userName.length == 0 || pwd.length == 0)
                    {
                        [XBTipView showFailureTip:XBText_用户名或者密码为空请重试];
                        return;
                    }
                    else
                    {
                        [weakSelf showWaitting:nil];
                        [[LoginTool shared] loginWithUserName:userName pwd:pwd block:^(BOOL succeeded, NSError * _Nullable error) {
                            [weakSelf hiddenWaitting];
                            if (succeeded)
                            {
                                [XBTipView showSuccessTip:XBText_成功];
                            }
                            else
                            {
                                [XBTipView showSuccessTip:XBText_失败];
                            }
                        }];
                    }
                }
            }];
        }
    };
    
    self.rightButtonItem.hidden = NO;
    self.rightButtonItem.str_titleNormal = XBText_添加;
    self.rightButtonItem.bl_click = ^(XBButton *weakBtn) {
        [weakSelf pushToVc:[NSClassFromString(@"AddSeriesViewController") new]];
    };
    [self createTableView];
}

- (void)createTableView
{
    self.tbv_content = ({
        UITableView *tableview = [UITableView new];
        [self.view addSubview:tableview];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(SafeAreaTopHeight);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
        }];
        tableview.delegate = self;
        tableview.dataSource = self;
        UIView *footView = [UIView new];
        tableview.tableFooterView = footView;
        [XBAppTool setTableViewDelaysContentTouchesNO:tableview];
        tableview;
    });
}

#pragma mark - tableView 代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SeriesTool shared].getSeriesModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSInteger row = indexPath.row;
    
    SeriesModel *model = [SeriesTool shared].getSeriesModelArr[row];
    
    cell.textLabel.text = model.str_name;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SeriesDetailViewController *vc = [SeriesDetailViewController new];
    vc.seriesModel = [SeriesTool shared].getSeriesModelArr[indexPath.row];
    [self pushToVc:vc];
}

@end
