//
//  LPAChangePwdView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPAChangePwdView : UIView

@property (weak, nonatomic) IBOutlet UIView *oldPwdView;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;

@property (weak, nonatomic) IBOutlet UIView *newsPwdView;
@property (weak, nonatomic) IBOutlet UITextField *newsPwdTF;

@property (weak, nonatomic) IBOutlet UIView *sureNewsPwdView;
@property (weak, nonatomic) IBOutlet UITextField *sureNewsPwdTF;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
