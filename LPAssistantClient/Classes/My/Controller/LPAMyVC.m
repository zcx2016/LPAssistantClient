//
//  LPAMyVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyVC.h"
#import "LPAMyFirstCell.h"
#import "LPPCommonTBCell.h"
//点击事件
#import "LPAMyInfoVC.h"
#import "LPAChatRemindVC.h"

@interface LPAMyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPAMyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人中心";
    [self tableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"bell"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)bellBtnClick:(UIButton *)btn{
    LPAChatRemindVC *vc = [LPAChatRemindVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 3){
        return 2;
    }
    return 1;
}

#pragma mark - tableView DataSource LPAMyFirstCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LPAMyFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAMyFirstCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.diyDetailLabel.hidden = YES;
        if(indexPath.section == 1){
            cell.diyTitleLabel.text = @"门店排名";
        }else if (indexPath.section == 2){
            cell.diyTitleLabel.text = @"我的开单";
        }else{
            if(indexPath.row == 0){
                cell.diyTitleLabel.text = @"我的KPI";
            }else{
                cell.diyTitleLabel.text = @"我的CMR";
            }
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 100;
    }
    return 50;
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

#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LPAMyInfoVC *vc = [LPAMyInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyFirstCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyFirstCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];

        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
