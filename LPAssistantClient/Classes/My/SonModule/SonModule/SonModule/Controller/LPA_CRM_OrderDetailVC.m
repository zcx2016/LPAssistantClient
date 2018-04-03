//
//  LPA_CRM_OrderDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_OrderDetailVC.h"
#import "LPA_CRM_OrderDetailTopView.h"
//子控制器
#import "LPA_CRM_AllOrderVC.h"
#import "LPA_CRM_WaitPayVC.h"
#import "LPA_CRM_WaitPostVC.h"
#import "LPA_CRM_WaitReceiveVC.h"

@interface LPA_CRM_OrderDetailVC ()<LPA_CRM_OrderDetailTopViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPA_CRM_OrderDetailTopView *topView;

@property (nonatomic, assign) NSInteger subViewCount;

//当前控制器
@property (nonatomic, weak) UIViewController *currentVC;

@end

@implementation LPA_CRM_OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"订单明细";
    
    [self tableView];
    
    self.subViewCount = 2;
     [self calculateViewCount];
    
    [self topView];
    
    //添加子控制器
    [self addChildViewController:[LPA_CRM_AllOrderVC new]];
    [self addChildViewController:[LPA_CRM_WaitPayVC new]];
    [self addChildViewController:[LPA_CRM_WaitPostVC new]];
    [self addChildViewController:[LPA_CRM_WaitReceiveVC new]];
    
    //默认选择第一个子控制器
    [self fourBtnClick:nil];
}

#pragma mark -代理
- (void)fourBtnClick:(UIButton *)btn{
    
    //移除当前显示的控制器
    [self.currentVC.view removeFromSuperview];
    //获得控制器的位置索引
    NSUInteger index = [btn.superview.subviews indexOfObject:btn];
    //设置当前控制器
    self.currentVC = self.childViewControllers[index];
    //设置尺寸
    self.currentVC.view.frame = CGRectMake(0, 90, kScreenWidth, kScreenHeight - 90 -64);
    //添加到控制器上
    [self.view addSubview:self.currentVC.view];
}


//计算view数量
- (void)calculateViewCount{
    
}


- (LPA_CRM_OrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"LPA_CRM_OrderDetailTopView" owner:nil options:nil].lastObject;
        _topView.frame = CGRectMake(0, 0, kScreenWidth, 64+50+40);
        //绑定 代理
        _topView.stateSelectedDelegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}


@end
