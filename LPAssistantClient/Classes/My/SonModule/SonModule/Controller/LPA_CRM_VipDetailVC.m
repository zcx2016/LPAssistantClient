//
//  LPA_CRM_VipDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_VipDetailVC.h"
#import "LPAReceptionCell.h"
#import "LPAVipDetailCell.h"
#import "LPA_CRM_bottomView.h"

@interface LPA_CRM_VipDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPA_CRM_bottomView *bottomView;

@end

@implementation LPA_CRM_VipDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"会员详情";
    
    [self tableView];
    [self bottomView];
}

- (LPA_CRM_bottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPA_CRM_bottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight-55, kScreenWidth, 55);
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 4;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPAReceptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
        cell.indicatorBtn.hidden = YES;
        return cell;
    }else{
        LPAVipDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAVipDetailCell" forIndexPath:indexPath];
        if (indexPath.section == 1 && indexPath.row == 3) {
            cell.inputTF.hidden = YES;
            cell.titleLabel.text = @"生日提醒";
        }else{
            cell.diyDetailLabel.hidden = NO;
            cell.remindSwitch.hidden = YES;
            cell.inputTF.hidden = YES;
            if (indexPath.section == 2) {
                cell.titleLabel.text = @"其他";
                cell.diyDetailLabel.text = @"重要会员";
            }else{
                if (indexPath.row == 0) {
                    cell.titleLabel.text = @"备注姓名";
                    cell.diyDetailLabel.text = @"周星驰";
                }else if (indexPath.row == 1){
                    cell.titleLabel.text = @"手机号";
                    cell.diyDetailLabel.text = @"18655180036";
                }else{
                    cell.titleLabel.text = @"生日";
                    cell.diyDetailLabel.text = @"1990/03/01";
                }
            }
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }else if (section == 2){
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = ZCXColor(239, 239, 244);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        label.text = @"详细信息";
        [view addSubview:label];
        return view;
    }
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
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAReceptionCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAReceptionCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAVipDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAVipDetailCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
