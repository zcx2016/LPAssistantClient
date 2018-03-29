//
//  LPAFindPwdVC.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPAFindPwdVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;

@property (weak, nonatomic) IBOutlet UIView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;

@property (weak, nonatomic) IBOutlet UIView *inputNewPwdView;
@property (weak, nonatomic) IBOutlet UITextField *inputNewPwdTF;

@property (weak, nonatomic) IBOutlet UIView *sureNewPwdView;
@property (weak, nonatomic) IBOutlet UITextField *sureNewPwdTF;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
