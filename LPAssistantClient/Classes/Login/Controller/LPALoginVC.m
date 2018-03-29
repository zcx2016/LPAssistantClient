//
//  LPALoginVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPALoginVC.h"
#import "LPAFindPwdVC.h"

@interface LPALoginVC ()<UITextFieldDelegate>

@end

@implementation LPALoginVC

#pragma mark- 进入时状态栏字体设置为白色，退出时再设回黑色
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"loginBg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;

    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTF];
    
    [self.findPwdBtn addTarget:self action:@selector(findPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)findPwdBtnClick:(UIButton *)btn{
    LPAFindPwdVC *vc = [LPAFindPwdVC new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)loginBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTF{
    //设置TF的placeholder的颜色
    UIColor *color = [UIColor whiteColor];
    _accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_accountTF.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    _pwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_pwdTF.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    //设置键盘右下角 完成 键
    _accountTF.returnKeyType = UIReturnKeyDone;
    _accountTF.delegate = self;
    _pwdTF.returnKeyType = UIReturnKeyDone;
    _pwdTF.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification{
    [_accountTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
