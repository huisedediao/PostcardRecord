//
//  XBActionSheet.m
//  XBActionSheet
//
//  Created by XXB on 16/7/22.
//  Copyright © 2016年 XXB. All rights reserved.
//

#import "XBActionSheet.h"
#import "Masonry.h"

#define kLineViewSpaceToBorder 10
#define kDefaultSectionH 5
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface XBActionSheet ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *xbTbaleView;
@end

@implementation XBActionSheet

-(instancetype)init
{
    if (self=[super init])
    {
        self.destructiveButtonIndex=10000;
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithTitleArr:(NSArray *)titleArr cancelBtnTitle:(NSString *)cancelBtnTitle actionBlock:(XBActionSheetBlock)actionBlock
{
    if (self = [super initWithDisplayView:[[UIApplication sharedApplication].delegate window]])
    {
        self.titleArr = titleArr;
        self.cancelBtnTitle = cancelBtnTitle;
        self.bl_click = actionBlock;
    }
    return self;
}
-(void)setTitleArr:(NSArray *)titleArr
{
    _titleArr=titleArr;
    
    CGFloat buttonH=self.buttonHeight==0?44:self.buttonHeight;
    CGFloat spaceH=self.space==0?kDefaultSectionH:self.space;
    CGFloat selfHeight=(titleArr.count+1)*buttonH+spaceH;
    CGFloat selfWidth=kScreenW-self.gapToBorder*2;
    CGFloat selfX=self.gapToBorder;
    
    CGFloat safeBottomHeight = (kScreenHeight == 812.0 ? 34 : 0);
    
    CGRect showRect=CGRectMake(selfX, kScreenH - selfHeight - safeBottomHeight, selfWidth, selfHeight + safeBottomHeight);
    CGRect hiddenRect=CGRectMake(selfX, kScreenH - safeBottomHeight, selfWidth, selfHeight + safeBottomHeight);
    
    self.showLayoutBlock=^(XBAlertViewBase *alertView){
        alertView.frame=showRect;
    };
    self.hiddenLayoutBlock=^(XBAlertViewBase *alertView){
        alertView.frame=hiddenRect;
    };
}

-(void)show
{
    [self.xbTbaleView reloadData];
    [super show];
}

-(UITableView *)xbTbaleView
{
    if (_xbTbaleView==nil)
    {
        _xbTbaleView=[UITableView new];
        [self addSubview:_xbTbaleView];
        
        [_xbTbaleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _xbTbaleView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _xbTbaleView.delegate=self;
        _xbTbaleView.dataSource=self;
        
        [_xbTbaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _xbTbaleView;
}


#pragma mark - TableView代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)   return self.titleArr.count;
    else                return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    //添加分割线,按钮少,cell不会有复用问题
    if (indexPath.section==0 && indexPath.row != (self.titleArr.count-1)) {
        CALayer *line=[CALayer new];
        [cell.contentView.layer addSublayer:line];
        line.backgroundColor=[[[UIColor grayColor] colorWithAlphaComponent:0.1] CGColor];
        line.frame=CGRectMake(kLineViewSpaceToBorder, self.buttonHeight?(self.buttonHeight-0.5):(44-0.5), kScreenW-2*kLineViewSpaceToBorder, 0.5);
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell.textLabel.text=self.titleArr[indexPath.row];
        }
            break;
        case 1:
        {
            cell.textLabel.text = self.cancelBtnTitle.length ? self.cancelBtnTitle : @"取消";
        }
            break;
            
        default:
            break;
    }
    if (indexPath.section==0 && self.destructiveButtonIndex==indexPath.row)
    {
        cell.textLabel.textColor=self.destructiveButtonTextColor?self.destructiveButtonTextColor:[UIColor redColor];
    }
    else
    {
        cell.textLabel.textColor=self.buttonTextColor?self.buttonTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.buttonHeight==0?44:self.buttonHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[UIView new];
    view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (self.space==0)?kDefaultSectionH:self.space);
    view.backgroundColor=self.spaceColor?self.spaceColor:[[UIColor grayColor] colorWithAlphaComponent:0.1];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0;
    }
    else
    {
        return [self tableView:tableView viewForHeaderInSection:section].bounds.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hidden];
    
    if (indexPath.section==0)
    {
        if ([self.delegate respondsToSelector:@selector(actionSheet:clickedAtIndex:)])
        {
            [self.delegate actionSheet:self clickedAtIndex:indexPath.row];
        }
        if (self.bl_click)
        {
            self.bl_click(self, indexPath.row);
        }
    }
}
@end


