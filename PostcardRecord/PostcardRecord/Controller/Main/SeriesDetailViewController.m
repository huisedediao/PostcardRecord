//
//  SeriesDetailViewController.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "CityModel.h"
#import "CountryModel.h"
#import "XBFloatMenuView.h"
#import "AddUnHaveViewController.h"
#import "SeriesDetailModel.h"

@interface SeriesDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbv_content;
@property (nonatomic,strong) NSArray *arr_seriesDetailModel;
@property (nonatomic,strong) NSArray *arr_city;
@property (nonatomic,assign) BOOL showUnHave;
@end

@implementation SeriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshTitle];
    
    self.arr_seriesDetailModel = [[SeriesDetailTool shared] getSeriesDetailModelsArrMForKeyIndex:self.seriesModel.keyIndex];

}

- (void)refreshTitle
{
    NSString *suffix = self.showUnHave ? XBText_未拥有 : XBText_已拥有;
    self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",self.seriesModel.str_name,suffix];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tbv_content reloadData];
}

- (void)buildUI
{
    [super buildUI];
    
    self.rightButtonItem.hidden = NO;
    self.rightButtonItem.img_normal = XBImage_添加默认;
    self.rightButtonItem.img_highlight = XBImage_添加按下;
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

- (NSArray *)getMenuTitle
{
    if (self.showUnHave)
    {
        return @[XBText_添加,XBText_显示已拥有];
    }
    else
    {
        return @[XBText_添加,XBText_显示未拥有];
    }
}

- (void)rightButtonItemAction:(XBButton *)sender
{
    XBFloatMenuView *menu = [[XBFloatMenuView alloc] initWithDisplayView:[AppDelegate shared].window titleArr:[self getMenuTitle] imgArr:nil width:GWidthFactorFun(100) spaceToTop:StatusBarHeight + 40 spaceToRight:GWidthFactorFun(7)];
    menu.bl_click = ^(NSInteger index) {
        NSLog(@"%zd",index);
        switch (index) {
            case 0:
            {
                AddUnHaveViewController *addVC = [AddUnHaveViewController new];
                addVC.arr_unHaveCity = [self getUnAddCity];
                addVC.keyIndex = self.seriesModel.keyIndex;
                [self pushToVc:addVC];
            }
                break;
            case 1:
            {
                self.showUnHave = !self.showUnHave;
                [self.tbv_content reloadData];
                [self refreshTitle];
            }
                break;
                
            default:
                break;
        }
    };
    [menu show];
}


#pragma mark - tableView 代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCurrentShowModels].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseID];
    }
    
    NSInteger row = indexPath.row;
    SeriesDetailModel *model = [self getCurrentShowModels][row];
    cell.textLabel.text = model.Name;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)getCurrentShowModels
{
    if (self.showUnHave)
    {
        return [self getUnAddCity];
    }
    else
    {
        return self.arr_seriesDetailModel;
    }
}

///获取还未添加的城市
- (NSArray *)getUnAddCity
{
    NSMutableArray *arrM = [NSMutableArray new];
    
    if (self.seriesModel.type == LimitsType_zh)
    {
        self.arr_city = [CityTool shared].getChinaCity;
        
        //            for (CityModel *model in self.arr_city)
        //            {
        //                NSLog(@"%@",model.Name);
        //            }
    }
    else
    {
        self.arr_city = [CityTool shared].getWorldCountry;
        
        //            for (CountryModel *model in self.arr_city)
        //            {
        //                NSLog(@"%@",model.Name);
        //            }
    }
    
    for (RegionModel *model in self.arr_city)
    {
        BOOL isExist = NO;
        for (SeriesDetailModel *detailModel in self.arr_seriesDetailModel)
        {
            if ([model.Code isEqualToString:detailModel.Code])
            {
                isExist = YES;
            }
        }
        
        if (isExist == NO)
        {
            SeriesDetailModel *detailModel = [SeriesDetailModel new];
            detailModel.Name = model.Name;
            detailModel.Code = model.Code;
            [arrM addObject:detailModel];
        }
    }

    return arrM;
}

@end
