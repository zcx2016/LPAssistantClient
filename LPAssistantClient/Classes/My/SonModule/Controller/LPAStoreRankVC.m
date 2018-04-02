//
//  LPAStoreRankVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAStoreRankVC.h"
#import "LPATimeSelectView.h"
#import "LPAStoreRankCell.h"
#import "LPAStoreRankBottomView.h"
#import "LPAMyStoreVC.h"

@interface LPAStoreRankVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPATimeSelectView *timeSelectView;

@property (nonatomic, strong) LPAStoreRankBottomView *bottomView;

@end

@implementation LPAStoreRankVC

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

    self.navigationItem.title = @"门店排名";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏右边 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [btn setTitle:@"我的门店" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(myStore) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self tableView];
    [self timeSelectView];
    [self bottomView];
}

- (LPATimeSelectView *)timeSelectView{
    if (!_timeSelectView) {
        _timeSelectView = [[NSBundle mainBundle] loadNibNamed:@"LPATimeSelectView" owner:nil options:nil].lastObject;
        _timeSelectView.frame = CGRectMake(0, 64, kScreenWidth, 60);
        [self.view addSubview:_timeSelectView];
    }
    return _timeSelectView;
}

- (LPAStoreRankBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPAStoreRankBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight-60, kScreenWidth, 60);
        [self.view addSubview:_bottomView];
        
    }
    return _bottomView;
}

- (void)myStore{
    LPAMyStoreVC *vc = [LPAMyStoreVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPAStoreRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAStoreRankCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.backgroundColor = ZCXColor(204, 204, 204);
        cell.storeLabel.text = @"门店";
        cell.saleLabel.text = @"销售额";
        cell.rankLabel.text = @"排名";
    }else{
        if (indexPath.row %2 == 1) {
            cell.backgroundColor = ZCXColor(245, 245, 245);
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
        cell.storeLabel.text = @"虹桥旗舰店";
        cell.saleLabel.text = @"￥888800";
        cell.rankLabel.text = @"01";
    }
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10+60, kScreenWidth-20, kScreenHeight-10-60 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        //去掉ios7 的separatorInset边距
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAStoreRankCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAStoreRankCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
