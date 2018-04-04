//
//  LPAPayStyleActionSheetView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAPayStyleActionSheetView.h"


@interface LPAPayStyleActionSheetView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *maskView;//背景

@end

@implementation LPAPayStyleActionSheetView

- (instancetype)initWithActionSheet{
    self = [super init];
    if(self){
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self tableView];
    }
    return self;
}

//背景
- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.userInteractionEnabled = YES;
        _maskView.alpha = 0.5;
        [self addSubview:_maskView];
    }
    return _maskView;
}

#pragma mark ------ 绘制视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}

//滑动弹出
- (void)show {
    
    _tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 500);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = _tableView.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        _tableView.frame = rect;
    }];
}

//滑动消失
- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y += _tableView.bounds.size.height;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ------ 触摸屏幕其他位置弹下
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"event---%@",event);
    [self dismiss];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (indexPath.row == 0) {
        [cell.imageView setImage:[UIImage imageNamed:@""]];
        cell.textLabel.text = @"微信";
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }else{
        
    }
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([<#type#> class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"<#type#>"];

        [self addSubview:_tableView];
    }
    return _tableView;
}


@end
