//
//  LPAMyStoreVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyStoreVC.h"
#import "LPATimeSelectView.h"
#import "LPAStoreRankCell.h"
#import "LPAStoreRankBottomView.h"
#import "SCTimePickerView.h"

@interface LPAMyStoreVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPATimeSelectView *timeSelectView;

@property (nonatomic, strong) LPAStoreRankBottomView *bottomView;

@property (nonatomic, strong) SCTimePickerView *startTimePickerView;

@property (nonatomic, strong) SCTimePickerView *endTimePickerView;

@end

@implementation LPAMyStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"店员排名";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setHeadTimePickView];
    [self tableView];
    [self setBottomView];
    
    //生日通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myStoreStartNoti:) name:@"myStoreStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myStoreEndNoti:) name:@"myStoreEnd" object:nil];
}

- (void)myStoreStartNoti:(NSNotification *)noti{
    NSDictionary *timeDict = [noti userInfo];
    _timeSelectView.startTF.text = [timeDict objectForKey:@"time"];
    [_timeSelectView.startTF resignFirstResponder];
}

- (void)myStoreEndNoti:(NSNotification *)noti{
    NSDictionary *timeDict = [noti userInfo];
    _timeSelectView.endTF.text = [timeDict objectForKey:@"time"];
    [_timeSelectView.endTF resignFirstResponder];
}

- (void)setHeadTimePickView{
    _timeSelectView = [[NSBundle mainBundle] loadNibNamed:@"LPATimeSelectView" owner:nil options:nil].lastObject;
    [self.view addSubview:_timeSelectView];
    [_timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(0);
        make.height.equalTo(@60);
    }];

    self.startTimePickerView = [[[NSBundle mainBundle] loadNibNamed:@"SCTimePickerView" owner:self options:nil] firstObject];
    self.startTimePickerView.identifierStr = @"我的门店开始时间";
    _timeSelectView.startTF.inputView = self.startTimePickerView;
    
    self.endTimePickerView = [[[NSBundle mainBundle] loadNibNamed:@"SCTimePickerView" owner:self options:nil] firstObject];
    self.endTimePickerView.identifierStr = @"我的门店结束时间";
    _timeSelectView.endTF.inputView = self.endTimePickerView;
}

- (void)setBottomView{
    _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPAStoreRankBottomView" owner:nil options:nil].lastObject;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).with.offset(0);
        make.height.equalTo(@60);
    }];
    _bottomView.myStoreTitleLabel.text = @"我";
    _bottomView.myStoreDetailLabel.text = @"周星驰";
    _bottomView.saleDetailLabel.text = @"￥18000";
    _bottomView.rankDetailLabel.text = @"第1名";
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
        cell.storeLabel.text = @"店员";
        cell.saleLabel.text = @"销售额";
        cell.rankLabel.text = @"排名";
    }else{
        if (indexPath.row %2 == 1) {
            cell.backgroundColor = ZCXColor(245, 245, 245);
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
        cell.storeLabel.text = @"周星驰";
        cell.saleLabel.text = @"￥888800";
        cell.rankLabel.text = @"1";
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10+60, kScreenWidth-20, kScreenHeight-10-60 - 64-60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAStoreRankCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAStoreRankCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
