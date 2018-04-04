//
//  LPAOrderDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAOrderDetailVC.h"
#import "LPAPayOnlineCell.h"
#import "LPABottomBtnView.h"
//跳转
#import "LPAPayVC.h"
#import "LPAPayRoutePopView.h"

@interface LPAOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource,LPAPayRoutePopViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPABottomBtnView *bottomBtnView;

@property (nonatomic, strong) LPAPayRoutePopView *popView;

@end

@implementation LPAOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"订单详情";
    [self tableView];
    [self bottomBtnView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (LPABottomBtnView *)bottomBtnView{
    if (!_bottomBtnView) {
        _bottomBtnView = [[NSBundle mainBundle] loadNibNamed:@"LPABottomBtnView" owner:nil options:nil].lastObject;
        _bottomBtnView.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
        _bottomBtnView.backgroundColor = [UIColor whiteColor];
        [_bottomBtnView.redBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_bottomBtnView.redBtn addTarget:self action:@selector(redBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomBtnView];
    }
    return _bottomBtnView;
}

- (void)redBtnClick:(UIButton *)btn{

    self.popView = [[NSBundle mainBundle] loadNibNamed:@"LPAPayRoutePopView" owner:nil options:nil].firstObject;
    self.popView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.popView.delegate = self;
    [self.popView showView];
}

- (void)changePayRouteStyle:(NSString *)string{
    if ([string isEqualToString:@"online"]) {
        [self.popView dissMissView];
        LPAPayVC *vc = [LPAPayVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.popView dissMissView];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"订单已在收银台生成，请前往付款" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:okAction];
        //通过控制器弹出对话框
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPAPayOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAPayOnlineCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"优惠券";
            cell.detailTextLabel.text = @"￥300";
        }else{
            cell.textLabel.text = @"实付款";
            cell.detailTextLabel.text = @"￥630";
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAPayOnlineCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAPayOnlineCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
