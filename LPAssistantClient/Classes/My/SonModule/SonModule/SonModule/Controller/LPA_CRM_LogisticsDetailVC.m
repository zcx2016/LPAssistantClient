//
//  LPA_CRM_LogisticsDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_LogisticsDetailVC.h"
#import "LPA_LogisticsTopCell.h"
#import "LPA_LogisticsProgressCell.h"

@interface LPA_CRM_LogisticsDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger rowCount;

@end

@implementation LPA_CRM_LogisticsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"物流详情";
    
    [self tableView];
    self.rowCount = 8;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.rowCount;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPA_LogisticsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPA_LogisticsTopCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPA_LogisticsProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPA_LogisticsProgressCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.upLineView.hidden = YES;
            cell.downLineView.hidden = NO;
            cell.pointView.backgroundColor = [UIColor redColor];
            cell.pointView.layer.borderColor = [UIColor redColor].CGColor;
            [cell.detailLabel setTextColor:[UIColor redColor]];
        }else if (indexPath.row == self.rowCount - 1){
            cell.upLineView.hidden = NO;
            cell.downLineView.hidden = YES;
            cell.pointView.backgroundColor = [UIColor whiteColor];
            cell.pointView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.detailLabel setTextColor:[UIColor darkGrayColor]];
        }else{
            cell.upLineView.hidden = NO;
            cell.downLineView.hidden = NO;
            cell.pointView.backgroundColor = [UIColor whiteColor];
            cell.pointView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.detailLabel setTextColor:[UIColor darkGrayColor]];
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }
    return 70;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPA_LogisticsTopCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPA_LogisticsTopCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPA_LogisticsProgressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPA_LogisticsProgressCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
