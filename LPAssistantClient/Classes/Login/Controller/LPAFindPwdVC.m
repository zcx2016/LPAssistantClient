//
//  LPAFindPwdVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAFindPwdVC.h"

@interface LPAFindPwdVC ()

@end

@implementation LPAFindPwdVC


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"找回密码";
    
    _accountView.layer.shadowOffset = CGSizeMake(0, 2);
    _accountView.layer.shadowOpacity = 0.20;
    
    _verifyCodeView.layer.shadowOffset = CGSizeMake(0, 2);
    _verifyCodeView.layer.shadowOpacity = 0.20;
    
    _inputNewPwdView.layer.shadowOffset = CGSizeMake(0, 2);
    _inputNewPwdView.layer.shadowOpacity = 0.20;
    
    _sureNewPwdView.layer.shadowOffset = CGSizeMake(0, 2);
    _sureNewPwdView.layer.shadowOpacity = 0.20;
    
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneBtnClick:(UIButton *)btn{
    NSLog(@"1");
}

@end
