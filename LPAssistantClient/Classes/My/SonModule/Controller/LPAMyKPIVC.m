//
//  LPAMyKPIVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyKPIVC.h"
#import "LPAMyKPICell.h"
#import "LPAMyKPIHeadView.h"
#import "LPATimeSelectView.h"
#import "SCTimePickerView.h"

@interface LPAMyKPIVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTB;

@property (nonatomic, strong) UITableView *rightTB;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) LPATimeSelectView *timeSelectView;

@property (nonatomic, strong) SCTimePickerView *startTimePickerView;

@property (nonatomic, strong) SCTimePickerView *endTimePickerView;

@end

@implementation LPAMyKPIVC

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

    self.view.backgroundColor = [UIColor whiteColor];
    [self createSegMentController];
    
    [self setHeadTimePickView];
    [self leftTB];
    [self rightTB];
    
    //生日通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myKPIStartNoti:) name:@"myKPIStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myKPIEndNoti:) name:@"myKPIEnd" object:nil];
}

- (void)myKPIStartNoti:(NSNotification *)noti{
    NSDictionary *timeDict = [noti userInfo];
    _timeSelectView.startTF.text = [timeDict objectForKey:@"time"];
    [_timeSelectView.startTF resignFirstResponder];
}

- (void)myKPIEndNoti:(NSNotification *)noti{
    NSDictionary *timeDict = [noti userInfo];
    _timeSelectView.endTF.text = [timeDict objectForKey:@"time"];
    [_timeSelectView.endTF resignFirstResponder];
}

- (void)setHeadTimePickView{
    _timeSelectView = [[NSBundle mainBundle] loadNibNamed:@"LPATimeSelectView" owner:nil options:nil].lastObject;
    [self.view addSubview:_timeSelectView];
    [_timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(64);
        make.height.equalTo(@60);
    }];

    self.startTimePickerView = [[[NSBundle mainBundle] loadNibNamed:@"SCTimePickerView" owner:self options:nil] firstObject];
    self.startTimePickerView.identifierStr = @"我的KPI开始时间";
    _timeSelectView.startTF.inputView = self.startTimePickerView;
    
    self.endTimePickerView = [[[NSBundle mainBundle] loadNibNamed:@"SCTimePickerView" owner:self options:nil] firstObject];
    self.endTimePickerView.identifierStr = @"我的KPI结束时间";
    _timeSelectView.endTF.inputView = self.endTimePickerView;
}

//创建导航栏分栏控件
-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"销售业绩",@"会员业绩",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor blackColor];
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:segmentedControl];
}

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    //记录当前选择的是分段控件的左边还是右边。
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            self.leftTB.hidden = NO;
            self.rightTB.hidden = YES;
            sender.selectedSegmentIndex=0;
            self.tag = 0;
            [self.leftTB reloadData];
            break;
            
        case 1:
            self.leftTB.hidden = YES;
            self.rightTB.hidden = NO;
            sender.selectedSegmentIndex = 1;
            self.tag=1;
            [self.rightTB reloadData];
            break;
            
        default:
            break;
    }
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 0) {
        return 20;
    }
    return 20;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        LPAMyKPICell *cell = [self.leftTB dequeueReusableCellWithIdentifier:@"LPAMyKPICell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.backgroundColor = ZCXColor(204, 204, 204);
            cell.dateLabel.text = @"日期";
            cell.saleLabel.text = @"销售额";
         
        }else{
            if (indexPath.row %2 == 1) {
                cell.backgroundColor = ZCXColor(245, 245, 245);
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
            cell.dateLabel.text = @"2017.08.01";
            cell.saleLabel.text = @"￥888800";
        }
        return cell;
    }else{
        LPAMyKPICell *cell = [self.rightTB dequeueReusableCellWithIdentifier:@"LPAMyKPICell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.backgroundColor = ZCXColor(204, 204, 204);
            cell.dateLabel.text = @"日期";
            cell.saleLabel.text = @"销售额";
            
        }else{
            if (indexPath.row %2 == 1) {
                cell.backgroundColor = ZCXColor(245, 245, 245);
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
            cell.dateLabel.text = @"2017.08.01";
            cell.saleLabel.text = @"￥888800";
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.tag == 0) {
        LPAMyKPIHeadView *headView = [self.leftTB dequeueReusableHeaderFooterViewWithIdentifier:@"LPAMyKPIHeadView"];
        if (!headView) {
            headView = [[LPAMyKPIHeadView alloc] initWithReuseIdentifier:@"LPAMyKPIHeadView"];
        }
        headView.saleTitleLabel.text = @"销售业绩指标:";
        headView.moneyTitleLabel.text = @"完成销售额:";
        return headView;
    }else{
        LPAMyKPIHeadView *headView = [self.rightTB dequeueReusableHeaderFooterViewWithIdentifier:@"LPAMyKPIHeadView"];
        if (!headView) {
            headView = [[LPAMyKPIHeadView alloc] initWithReuseIdentifier:@"LPAMyKPIHeadView"];
        }
        headView.saleTitleLabel.text = @"会员业绩指标:";
        headView.moneyTitleLabel.text = @"所属会员数:";
        return headView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)leftTB{
    if (!_leftTB) {
        _leftTB = [[UITableView alloc] initWithFrame:CGRectMake(10, 10+60+64, kScreenWidth-20, kScreenHeight-10-60-64) style:UITableViewStyleGrouped];
        _leftTB.delegate = self;
        _leftTB.dataSource = self;
        //去掉ios7 的separatorInset边距
        _leftTB.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_leftTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyKPICell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyKPICell"];
        //注册headView
        [_leftTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyKPIHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPAMyKPIHeadView"];
        
        [self.view addSubview:_leftTB];
    }
    return _leftTB;
}

- (UITableView *)rightTB{
    if (!_rightTB) {
        _rightTB = [[UITableView alloc] initWithFrame:CGRectMake(10, 10+60+64, kScreenWidth-20, kScreenHeight-10-60-64) style:UITableViewStyleGrouped];
        _rightTB.delegate = self;
        _rightTB.dataSource = self;
        //去掉ios7 的separatorInset边距
        _rightTB.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_rightTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyKPICell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyKPICell"];
        //注册headView
        [_rightTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyKPIHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPAMyKPIHeadView"];
        [self.view addSubview:_rightTB];
    }
    return _rightTB;
}

@end
