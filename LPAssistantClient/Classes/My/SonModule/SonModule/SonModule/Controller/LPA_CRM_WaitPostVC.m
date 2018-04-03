//
//  LPA_CRM_WaitPostVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_WaitPostVC.h"
#import "LPA_CRM_OrderDetailCell.h"
#import "LPA_CRM_LogisticsDetailVC.h"

@interface LPA_CRM_WaitPostVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger subViewCount;

@end

@implementation LPA_CRM_WaitPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calculateViewCount];
    
    self.subViewCount = 2;
    
    [self tableView];
}

//计算view数量
- (void)calculateViewCount{
    
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPA_CRM_OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPA_CRM_OrderDetailCell" forIndexPath:indexPath];
    cell.count = self.subViewCount;
    cell.stateLabel.text = @"待发货";
    cell.cancelBtn.hidden = YES;
    [cell.goToPayBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [cell.goToPayBtn addTarget:self action:@selector(watchLogistics) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)watchLogistics{
    LPA_CRM_LogisticsDetailVC *vc = [LPA_CRM_LogisticsDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = self.subViewCount * 120+130;
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-50-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPA_CRM_OrderDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPA_CRM_OrderDetailCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
