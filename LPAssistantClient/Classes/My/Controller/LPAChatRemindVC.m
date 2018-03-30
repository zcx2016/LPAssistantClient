//
//  LPAChatRemindVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAChatRemindVC.h"
#import "LPAChatCell.h"
#import "LPARemindCell.h"

@interface LPAChatRemindVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTB;

@property (nonatomic, strong) UITableView *rightTB;

@property (nonatomic, assign) NSInteger tag;

@end

@implementation LPAChatRemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createSegMentController];
    [self leftTB];
    [self rightTB];
}

//创建导航栏分栏控件
-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"聊天",@"提醒",nil];
    
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
        return 4;
    }
    return 2;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        LPAChatCell *cell = [self.leftTB dequeueReusableCellWithIdentifier:@"LPAChatCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPARemindCell *cell = [self.rightTB dequeueReusableCellWithIdentifier:@"LPARemindCell" forIndexPath:indexPath];
        if (indexPath.row %2 == 0) {
            cell.msgTypeLabel.text = @"系统消息:";
            cell.contentLabel.text = @"刘德华 今天生日，送上祝福吧！";
            cell.refuseBtn.hidden = YES;
            cell.agreeBtn.hidden = YES;
        }else{
            cell.msgTypeLabel.text = @"价格调整申请:";
            cell.contentLabel.text = @"比尔盖茨 申请修改A商品价格下调500元！";
            cell.refuseBtn.hidden = NO;
            cell.agreeBtn.hidden = NO;
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        return 100;
    }else{
        if (indexPath.row %2 == 0) {
            return 70;
        }else{
            return 105;
        }
    }
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
- (UITableView *)leftTB{
    if (!_leftTB) {
        _leftTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _leftTB.delegate = self;
        _leftTB.dataSource = self;
        //去掉ios7 的separatorInset边距
        _leftTB.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_leftTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPAChatCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAChatCell"];
        
        [self.view addSubview:_leftTB];
    }
    return _leftTB;
}

- (UITableView *)rightTB{
    if (!_rightTB) {
        _rightTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _rightTB.delegate = self;
        _rightTB.dataSource = self;
        //去掉ios7 的separatorInset边距
        _rightTB.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_rightTB registerNib:[UINib nibWithNibName:NSStringFromClass([LPARemindCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPARemindCell"];
        
        [self.view addSubview:_rightTB];
    }
    return _rightTB;
}

@end
