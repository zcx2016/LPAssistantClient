//
//  LPAMyInfoVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyInfoVC.h"
#import "LPAReceptionCell.h"
#import "LPPCommonTBCell.h"
#import "LPALoginVC.h"
#import "LPAChangePwdVC.h"

@interface LPAMyInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPAMyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的资料";
    
    [self tableView];
    [self setBottomBtn];
}

#pragma mark - 设置 底部按钮
- (void)setBottomBtn{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-55-64, kScreenWidth, 55)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 45)];
    [bottomBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    //点击事件
    [bottomBtn addTarget:self action:@selector(quitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomBtn];
    [self.view addSubview:bottomView];
}

- (void)quitLogin:(UIButton *)btn{
    NSLog(@"33");
    LPALoginVC *vc = [LPALoginVC new];
//    UINavigationController *pushNavVc = [[UINavigationController alloc] initWithRootViewController:vc];
//    pushNavVc.navigationBar.barTintColor = [UIColor whiteColor];
//    [self presentViewController:pushNavVc animated:YES completion:nil] ;
    [self presentViewController:vc animated:YES completion:nil] ;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    return 4;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        LPAReceptionCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
        cell.nameLabel.hidden = YES;
        cell.nickNameLabel.text = @"Stephen";
        cell.moneyLabel.text = @"金牌店员";
        return cell;
    }else{
        LPPCommonTBCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.lineView.hidden = YES;
        if(indexPath.section == 1 && indexPath.row == 2){
            cell.diyDetailLabel.hidden = YES;
            cell.diyTitleLabel.text = @"修改密码";
        }else if (indexPath.section == 1&& indexPath.row == 3){
            cell.diyIndicatorBtn.hidden = YES;
            cell.diyTitleLabel.text = @"我的邀请码";
            cell.diyDetailLabel.text = @"AXSDFE";
            cell.diyDetailLabelTrailingConstraint.constant = 10;
            [cell.diyDetailLabel setFont:[UIFont systemFontOfSize:17]];
        }else{
            cell.diyIndicatorBtn.hidden = YES;
            cell.diyDetailLabelTrailingConstraint.constant = 10;
            if(indexPath.section == 0){
                if(indexPath.row == 1){
                    cell.diyTitleLabel.text = @"登录账号";
                    cell.diyDetailLabel.text = @"蜘蛛侠";
                }else{
                    cell.diyTitleLabel.text = @"所属门店";
                    cell.diyDetailLabel.text = @"虹口旗舰店";
                }
            }else{
                if(indexPath.row == 0){
                    cell.diyTitleLabel.text = @"职称";
                    cell.diyDetailLabel.text = @"金牌店员";
                }else{
                    cell.diyTitleLabel.text = @"姓名";
                    cell.diyDetailLabel.text = @"彼得帕克";
                }
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2) {
        LPAChangePwdVC * vc = [LPAChangePwdVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
