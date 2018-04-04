//
//  LPAPayVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAPayVC.h"
#import "LPAPayTopCell.h"
#import "LPPCommonTBCell.h"
//
#import "LPAPayPopView.h"

@interface LPAPayVC ()<UITableViewDelegate,UITableViewDataSource,LPAPayPopViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) LPAPayTopCell *weak_TopCell;

@property (nonatomic, strong) LPAPayPopView *popView;

@end

@implementation LPAPayVC

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

    self.navigationItem.title = @"收钱";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"更换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changePayMethod) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self tableView];
}

#pragma mark - 改变支付方式
- (void)changePayMethod{
    self.popView = [[NSBundle mainBundle] loadNibNamed:@"LPAPayPopView" owner:nil options:nil].firstObject;
    self.popView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.popView.delegate = self;
    [self.popView showView];
}

- (void)changePayStyle:(NSString *)string{
    if ([string isEqualToString:@"wx"]) {
         [self.popView dissMissView];
        [self.weak_TopCell.payStyleImgView setImage:[UIImage imageNamed:@"goods"]];
        self.weak_TopCell.payStyleLabel.text = @"微信扫一扫，向我付钱";
    }else{
         [self.popView dissMissView];
        [self.weak_TopCell.payStyleImgView setImage:[UIImage imageNamed:@"zfbCode"]];
        self.weak_TopCell.payStyleLabel.text = @"支付宝扫一扫，向我付钱";
    }
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPAPayTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAPayTopCell" forIndexPath:indexPath];
        self.weak_TopCell = cell;
        return cell;
    }else{
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.diyTitleLabel.text = @"支付成功";
        cell.diyDetailLabel.text = @"￥9999";
        cell.diyDetailLabel.textColor = [UIColor lightGrayColor];
        cell.diyIndicatorBtn.hidden = YES;
        cell.diyDetailLabelTrailingConstraint.constant = 15;
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 330;
    }
    return 50;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAPayTopCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAPayTopCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
