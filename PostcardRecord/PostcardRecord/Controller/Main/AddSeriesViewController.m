//
//  AddSeriesViewController.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "AddSeriesViewController.h"
#import "XBActionSheet.h"
#import "XBAlertView_inputPWD.h"

@interface AddSeriesViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbv_content;
@property (nonatomic,strong) NSArray *arr_titles;
@property (nonatomic,strong) NSArray *arr_limits;
@property (nonatomic,strong) SeriesModel *seriesModel;
@end

@implementation AddSeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = XBText_添加系列;
}

- (void)buildUI
{
    [super buildUI];
    
    self.rightButtonItem.hidden = NO;
    self.rightButtonItem.str_titleNormal = XBText_完成;
    [self createTableView];
}

- (void)rightButtonItemAction:(XBButton *)sender
{
    if (self.seriesModel.str_name.length == 0 || self.seriesModel.type == 0)
    {
        [XBTipView showWarnTip:XBText_请完善信息];
        return;
    }
    
    [[SeriesTool shared] addSeriesModel:self.seriesModel];
    [self leftButtonItemAction:self.leftButtonItem];
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseID];
    }

    NSInteger row = indexPath.row;
    
    cell.textLabel.text = self.arr_titles[row];
    
    if (row == 0)
    {
        if (self.seriesModel.str_name.length)
        {
            cell.detailTextLabel.text = self.seriesModel.str_name;
        }
        else
        {
            cell.detailTextLabel.text = XBText_请输入;
        }
    }
    else if (row == 1)
    {
        if (self.seriesModel.type != 0)
        {
            cell.detailTextLabel.text = self.arr_limits[self.seriesModel.type - 1];
        }
        else
        {
            cell.detailTextLabel.text = XBText_请选择;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        XBAlertView_inputPWD *alertView = [[XBAlertView_inputPWD alloc] initWithTitle:XBText_名称 message:@"" cancelButtonTitle:XBText_取消 otherButtonTitle:XBText_确定];
        alertView.bl_ok = ^(XBAlertView_inputPWD *alertView) {
            self.seriesModel.str_name = alertView.str_text;
            [self.tbv_content reloadData];
        };
        [alertView show];
    }
    else if (indexPath.row == 1)
    {
        XBActionSheet *actionSheet = [[XBActionSheet alloc] initWithDisplayView:[AppDelegate shared].window];
        actionSheet.titleArr = self.arr_limits;
        actionSheet.bl_click = ^(XBActionSheet *actionSheet, NSInteger index) {
            if (index == 0)
            {
                self.seriesModel.type = LimitsType_zh;
            }
            else if (index == 1)
            {
                self.seriesModel.type = LimitsType_world;
            }
            [self.tbv_content reloadData];
        };
        [actionSheet show];
    }
}

- (NSArray *)arr_titles
{
    if (_arr_titles == nil)
    {
        _arr_titles = @[XBText_名称,XBText_范围];
    }
    return _arr_titles;
}
- (NSArray *)arr_limits
{
    if (_arr_limits == nil)
    {
        _arr_limits = @[XBText_中国,XBText_全球];
    }
    return _arr_limits;
}
- (SeriesModel *)seriesModel
{
    if (_seriesModel == nil)
    {
        _seriesModel = [SeriesModel new];
    }
    return _seriesModel;
}

@end
