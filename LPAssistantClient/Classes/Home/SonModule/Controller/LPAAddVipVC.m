//
//  LPAAddVipVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAAddVipVC.h"
#import "LPACommonSearchCell.h"
#import "LPABindVipResultCell.h"
#import "SCScanCodeVC.h"

@interface LPAAddVipVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPAAddVipVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"绑定会员";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scanEvents) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self tableView];
}

- (void)scanEvents{
    SCScanCodeVC *vc = [[UIStoryboard storyboardWithName:@"SCScanCodeVC" bundle:nil] instantiateViewControllerWithIdentifier:@"SCScanCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LPACommonSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACommonSearchCell" forIndexPath:indexPath];
        cell.backgroundColor = ZCXColor(245, 245, 245);
        return cell;
    }else{
        LPABindVipResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPABindVipResultCell" forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPACommonSearchCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPACommonSearchCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPABindVipResultCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPABindVipResultCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
