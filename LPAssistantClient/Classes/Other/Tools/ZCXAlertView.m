//
//  ZCXAlertView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/8.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXAlertView.h"

@implementation ZCXAlertView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.diyContentView.layer.borderColor = ZCXColor(235, 235, 235).CGColor;
    self.diyContentView.layer.cornerRadius = 5;
    self.diyContentView.layer.borderWidth = 1;
    self.diyContentView.layer.masksToBounds = YES;
    
    [self.skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.verifyCodeTF.returnKeyType = UIReturnKeyDone;
    self.verifyCodeTF.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)skipBtnClick{
    [self dissMissView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushDiscountPickVc" object:nil];
}

- (void)sureBtnClick{
    [self dissMissView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushDiscountPickVc" object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.verifyCodeTF resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

//#pragma mark - 显示和隐藏蒙版view
//- (void)tapMaskBgView{
//    [self dissMissView];
//}

- (void)dissMissView{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

//- (void)showView{
//    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
//    [window addSubview:self];
//}

@end
