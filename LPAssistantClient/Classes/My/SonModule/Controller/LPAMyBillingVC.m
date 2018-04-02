//
//  LPAMyBillingVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//
#import "LPAMyBillingVC.h"
#import "LPAMyBillingCell.h"
#import "LPACommonSearchView.h"
#import "LPA_My_OrderDetailVC.h"

@interface LPAMyBillingVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPACommonSearchView *searchView;

@end

@implementation LPAMyBillingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单列表";
    
    [self tableView];
    [self searchView];
}

- (LPACommonSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[NSBundle mainBundle] loadNibNamed:@"LPACommonSearchView" owner:nil options:nil].lastObject;
        _searchView.frame = CGRectMake(0, 0, kScreenWidth, 114);
        _searchView.backgroundColor =ZCXColor(245, 245, 245);
        _searchView.searchTF.placeholder = @"点击选择用户姓名";
        _searchView.searchTF.delegate = self;
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码----注意：此处要return  NO
    NSLog(@"1111");
    return NO;
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
    LPAMyBillingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAMyBillingCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LPA_My_OrderDetailVC *vc = [LPA_My_OrderDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyBillingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyBillingCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
