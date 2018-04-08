//
//  LPAGoodsDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAGoodsDetailVC.h"
#import "ATCarouselView.h"
#import "LPPCDPriceNameCell.h"
#import "LPPCDCommodityStyleCell.h"
#import "LPPCDComparePriceCell.h"
#import "LPPCommonTBCell.h"
//跳转
#import "LPAPayOnlineVC.h"
#import "ZCXActionSheetView.h"
#import "LPAAddVipVC.h"

@interface LPAGoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource,ATCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//轮播图
@property (nonatomic, strong) ATCarouselView *carouselView;

@property (nonatomic, strong) ZCXActionSheetView *sheetView;

@end

@implementation LPAGoodsDetailVC

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
    self.navigationItem.title = @"商品详情";
    [self tableView];
    [self setBottomBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideViewThenPushVcNoti:) name:@"hideViewThenPushVc" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushDiscountPickVcNoti:) name:@"pushDiscountPickVc" object:nil];
}

- (void)setBottomBtn{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 50)];
    [btn setTitle:@"开单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openNewGoods) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [self.view addSubview:view];
}

- (void)openNewGoods{
    NSLog(@"开单");

    self.sheetView = [[ZCXActionSheetView alloc] initWithActionSheet];
    //放在最上层
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.sheetView];
}


- (void)hideViewThenPushVcNoti:(NSNotification *)noti{
    [self.sheetView dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LPAAddVipVC *vc = [LPAAddVipVC new];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (void)pushDiscountPickVcNoti:(NSNotification *)noti{
    [self.sheetView dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LPAPayOnlineVC *vc = [LPAPayOnlineVC new];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPCDPriceNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDPriceNameCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        LPPCDCommodityStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDCommodityStyleCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 2){
        LPPCDComparePriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDComparePriceCell" forIndexPath:indexPath];
        return cell;
    }else{
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.diyTitleLabel.text = @"规格";
        cell.diyDetailLabel.text = @"黑色 XL";
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1){
        return 190;
    }else if (indexPath.section == 2){
        return 123;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self carouselView];
    }
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDPriceNameCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDPriceNameCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDCommodityStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDCommodityStyleCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDComparePriceCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDComparePriceCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];

        //注册headView
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//轮播图
- (void)carouselView:(ATCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger )index{
    NSLog(@"点击了第%ld张图片",index);
}

- (ATCarouselView *)carouselView{
    if (!_carouselView) {
        _carouselView = [[ATCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        _carouselView.delegate = self;
        _carouselView.images = @[
                                 [UIImage imageNamed:@"goods"],
                                 [UIImage imageNamed:@"goods"],
                                 [UIImage imageNamed:@"goods"]
                                 ];
        //当前选中颜色
        _carouselView.currentPageColor = [UIColor blackColor];
        //普通状态颜色
        _carouselView.pageColor = [UIColor lightGrayColor];
    }
    return _carouselView;
}
@end
