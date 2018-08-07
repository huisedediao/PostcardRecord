//
//  AddUnHaveViewController.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "AddUnHaveViewController.h"

@interface AddUnHaveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbv_content;

@end

@implementation AddUnHaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = XBText_添加;
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
    self.rightButtonItem.str_titleNormal = XBText_完成;
    WEAK_SELF
    self.rightButtonItem.bl_click = ^(XBButton *weakBtn) {
        [weakSelf addSeleteData];
        [weakSelf leftButtonItemAction:weakSelf.leftButtonItem];
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
    return self.arr_unHaveCity.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseID];
    }
    cell.tintColor = XBColor_nav;

    
    NSInteger row = indexPath.row;
    
    SeriesDetailModel *model = self.arr_unHaveCity[row];
    if (model.b_isSelected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = model.Name;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger row = indexPath.row;
    
    SeriesDetailModel *model = self.arr_unHaveCity[row];
    model.b_isSelected = !model.b_isSelected;
    [self.tbv_content reloadData];
}

- (void)addSeleteData
{
    for (SeriesDetailModel *model in self.arr_unHaveCity)
    {
        if (model.b_isSelected)
        {
            [[SeriesDetailTool shared] addSeriesDetailModel:model forSeriesKeyIndex:self.keyIndex];
        }
    }
}
@end
