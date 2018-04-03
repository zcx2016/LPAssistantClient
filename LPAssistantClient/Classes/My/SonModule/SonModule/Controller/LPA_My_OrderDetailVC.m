//
//  LPAOrderDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_My_OrderDetailVC.h"
#import "LPPCommonTBCell.h"
#import "LPAMyBillingCell.h"
//跳转
#import "LPACompletePayStyleVC.h"

@interface LPA_My_OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LPA_My_OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"订单详情";
    
    [self tableView];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPAMyBillingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAMyBillingCell" forIndexPath:indexPath];
        cell.clientLineView.hidden = YES;
        cell.clientNameLabel.hidden = YES;
        cell.clientTitleLabel.hidden = YES;
        cell.stateLabel.hidden = YES;
        return cell;
    }else{
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            cell.diyIndicatorBtn.hidden = YES;
            cell.diyDetailLabelTrailingConstraint.constant = 15;
            cell.diyDetailLabel.textColor = [UIColor lightGrayColor];
            if (indexPath.row == 0) {
                cell.diyTitleLabel.text = @"优惠";
                cell.diyDetailLabel.text = @"￥2000";
            }else{
                cell.diyTitleLabel.text = @"实付款";
                cell.diyDetailLabel.text = @"￥8000";
            }
        }else{
            cell.diyDetailLabel.hidden = YES;
            cell.diyTitleLabel.text = @"完善付款方式";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        LPACompletePayStyleVC *vc = [LPACompletePayStyleVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 190;
    }
    return 50;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyBillingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyBillingCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
