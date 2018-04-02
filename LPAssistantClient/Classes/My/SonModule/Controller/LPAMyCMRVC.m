//
//  LPAMyCMRVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyCMRVC.h"
#import "LPAReceptionCell.h"
#import "LPAMyCMRHeadView.h"
//点击跳转
#import "LPA_CRM_VipDetailVC.h"

@interface LPAMyCMRVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPAMyCMRHeadView *CMRHeadView;

@end

@implementation LPAMyCMRVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的CRM";
    
    [self tableView];
    [self CMRHeadView];
}

- (LPAMyCMRHeadView *)CMRHeadView{
    if (!_CMRHeadView) {
        _CMRHeadView = [[NSBundle mainBundle] loadNibNamed:@"LPAMyCMRHeadView" owner:nil options:nil].lastObject;
        _CMRHeadView.frame = CGRectMake(0, 0, kScreenWidth, 124);
        _CMRHeadView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_CMRHeadView];
    }
    return _CMRHeadView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPAReceptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LPA_CRM_VipDetailVC *vc = [LPA_CRM_VipDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 120, 35)];
    label.text = @"我的会员(25)";
    label.textColor = [UIColor darkGrayColor];
    [headView addSubview:label];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAReceptionCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAReceptionCell"];
//        //注册headView
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([<#type#> class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"<#type#>"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}




@end
