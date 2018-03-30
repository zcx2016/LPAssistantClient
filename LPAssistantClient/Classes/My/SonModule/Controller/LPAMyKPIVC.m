//
//  LPAMyKPIVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyKPIVC.h"

@interface LPAMyKPIVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTB;

@property (nonatomic, strong) UITableView *rightTB;

@property (nonatomic, assign) NSInteger tag;

@end

@implementation LPAMyKPIVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSegMentController];
    
    [self leftTB];
    [self rightTB];
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
@end
