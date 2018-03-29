//
//  LPAPayOnlineVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAPayOnlineVC.h"
#import "LPACommonSearchCell.h"
#import "LPAPayOnlineCell.h"
#import "LPABottomBtnView.h"
#import "LPACouponCell.h"
//跳转vc
#import "LPAOrderDetailVC.h"

@interface LPAPayOnlineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPABottomBtnView *bottomBtnView;

//自定义 搜索框 的inputAccessoryView
@property (nonatomic, strong) UIToolbar *customAccessoryView;

@property (nonatomic, weak) LPACommonSearchCell *weak_searchCell;

@end

@implementation LPAPayOnlineVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"线上支付";
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
        [_bottomBtnView.redBtn addTarget:self action:@selector(redBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomBtnView];
    }
    return _bottomBtnView;
}

- (void)redBtnClick:(UIButton *)btn{
    LPAOrderDetailVC *vc = [LPAOrderDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPAPayOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAPayOnlineCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            LPACommonSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACommonSearchCell" forIndexPath:indexPath];
            cell.outView.backgroundColor = ZCXColor(238, 238, 238);
            
            cell.searchTF.inputAccessoryView = self.customAccessoryView;
            self.weak_searchCell = cell;
            return cell;
        }else{
            LPACouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACouponCell" forIndexPath:indexPath];
            
            return cell;
        }
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 90;
        }
    }
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPACommonSearchCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPACommonSearchCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAPayOnlineCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAPayOnlineCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPACouponCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPACouponCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//自定义 电话 和 qq 的inputAccessoryView
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,kScreenWidth,45}];
        _customAccessoryView.barTintColor = [UIColor lightGrayColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(startSearch)];
        [_customAccessoryView setItems:@[cancel,space,search]];
    }
    return _customAccessoryView;
}

- (void)cancel{
    [self.weak_searchCell.searchTF resignFirstResponder];
}

- (void)startSearch{
    [self.weak_searchCell.searchTF resignFirstResponder];
}

@end
