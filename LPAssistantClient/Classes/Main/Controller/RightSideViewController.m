//
//  RightSideViewController.m
//  ViewDeckStudy
//
//  Created by Mr_M on 2017/6/19.
//  Copyright © 2017年 Mr_M. All rights reserved.
//

#import "RightSideViewController.h"
#import "AppDelegate.h"
#import "LPPFilterBottomView.h"
#import "LPPFilterHeadView.h"
#import "LPPFiltCategoryCell.h"

@interface RightSideViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPFilterBottomView *bottomView;
@end

@implementation RightSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置尺寸
    self.preferredContentSize = CGSizeMake(kScreenWidth/6*5, kScreenHeight);
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //设置左右BarButtonItem
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"filtCloseBtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(closePopView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self bottomView];
    
    [self tableView];
}

- (LPPFilterBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPFilterBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

// 关闭抽屉
-(void)closePopView{
//
//    [self.viewDeckController closeSide:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPPFiltCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPFiltCategoryCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 3){
        return 180;
    }else {
        return 240;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        LPPFilterHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPFilterHeadView"];
        if (!headView) {
            headView = [[LPPFilterHeadView alloc] initWithReuseIdentifier:@"LPPFilterHeadView"];
        }
        
        if (section == 0) {
            headView.titleLabel.text = @"价格";
        }
        else if (section == 1) {
            headView.titleLabel.text = @"品牌";
        }else if (section == 2) {
            headView.titleLabel.text = @"类别";
        }else{
            headView.titleLabel.text = @"服务折扣";
        }
        return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/6*5, kScreenHeight-50-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFiltCategoryCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPFiltCategoryCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFilterHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPFilterHeadView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
