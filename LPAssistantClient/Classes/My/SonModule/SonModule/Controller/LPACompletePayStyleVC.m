//
//  LPACompletePayStyleVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPACompletePayStyleVC.h"
#import "LPACompletePayStyleCell.h"
#import "LPPCommonTBCell.h"

@interface LPACompletePayStyleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPACompletePayStyleVC

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

    self.navigationItem.title = @"完善付款方式";
    [self tableView];
    [self setBottomView];
}

- (void)setBottomView{
    UIView  *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-10-70, 10, 70, 30)];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"￥4000";
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-10-70 -40-1, 10, 40, 30)];
    sumLabel.text = @"合计:";
    [bottomView addSubview:priceLabel];
    [bottomView addSubview:sumLabel];
    [self.view addSubview:bottomView];
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
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.diyDetailLabel.hidden = YES;
        cell.diyTitleLabel.text = @"请选择支付方式";
        return cell;
    }else{
        LPACompletePayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACompletePayStyleCell" forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPACompletePayStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPACompletePayStyleCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
