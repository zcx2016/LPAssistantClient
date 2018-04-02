//
//  LPA_CRM_BuyDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_BuyDetailVC.h"
#import "LPA_CRM_BuyDetailCell.h"
#import "LPATimeSelectView.h"

@interface LPA_CRM_BuyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPATimeSelectView *timeSelectView;

@end

@implementation LPA_CRM_BuyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"消费明细";
    
    [self tableView];
    
    [self timeSelectView];
}

- (LPATimeSelectView *)timeSelectView{
    if (!_timeSelectView) {
        _timeSelectView = [[NSBundle mainBundle] loadNibNamed:@"LPATimeSelectView" owner:nil options:nil].lastObject;
        _timeSelectView.frame = CGRectMake(0, 0, kScreenWidth, 124);
        [self.view addSubview:_timeSelectView];
    }
    return _timeSelectView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPA_CRM_BuyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPA_CRM_BuyDetailCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPA_CRM_BuyDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPA_CRM_BuyDetailCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
