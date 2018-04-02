//
//  LPAChangePwdVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAChangePwdVC.h"
#import "LPAChangePwdView.h"

@interface LPAChangePwdVC ()

@property (nonatomic, strong) LPAChangePwdView *changePwdView;

@end

@implementation LPAChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self changePwdView];
}

- (LPAChangePwdView *)changePwdView{
    if (!_changePwdView) {
        _changePwdView = [[NSBundle mainBundle] loadNibNamed:@"LPAChangePwdView" owner:nil options:nil].lastObject;
        _changePwdView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        [_changePwdView.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_changePwdView];
    }
    return _changePwdView;
}

- (void)saveBtnClick:(UIButton *)btn{
    NSLog(@"111");
}
@end
