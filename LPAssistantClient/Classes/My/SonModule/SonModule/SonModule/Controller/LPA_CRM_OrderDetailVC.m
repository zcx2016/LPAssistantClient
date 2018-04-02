//
//  LPA_CRM_OrderDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_OrderDetailVC.h"
#import "LPATimeSelectView.h"

@interface LPA_CRM_OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPATimeSelectView *timeSelectView;

@end

@implementation LPA_CRM_OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"订单明细";
    
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

@end
