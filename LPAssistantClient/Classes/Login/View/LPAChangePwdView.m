//
//  LPAChangePwdView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAChangePwdView.h"

@implementation LPAChangePwdView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _oldPwdView.layer.shadowOffset = CGSizeMake(0, 2);
    _oldPwdView.layer.shadowOpacity = 0.20;
    
    _newsPwdView.layer.shadowOffset = CGSizeMake(0, 2);
    _newsPwdView.layer.shadowOpacity = 0.20;
    
    _sureNewsPwdView.layer.shadowOffset = CGSizeMake(0, 2);
    _sureNewsPwdView.layer.shadowOpacity = 0.20;
}

@end
