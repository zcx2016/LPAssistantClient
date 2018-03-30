//
//  LPAFindMyVipVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAFindMyVipVC.h"
#import "LPPNavSearchView.h"

@interface LPAFindMyVipVC ()

@property (nonatomic, strong) LPPNavSearchView *navSearchView;

@end

@implementation LPAFindMyVipVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTempView];
    //4.导航栏 搜索框
    [self navSearchView];
}

- (LPPNavSearchView *)navSearchView{
    if (!_navSearchView) {
        _navSearchView = [[NSBundle mainBundle] loadNibNamed:@"LPPNavSearchView" owner:nil options:nil].lastObject;
        _navSearchView.frame = CGRectMake(0, 0, kScreenWidth-60, 35);
        self.navigationItem.titleView = _navSearchView;
        [_navSearchView.searchBtn setTitle:@"输入会员手机号后4位" forState:UIControlStateNormal];
        //搜索按钮
        //        [_navSearchView.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navSearchView;
}

- (void)setTempView{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tempView];
}
@end
