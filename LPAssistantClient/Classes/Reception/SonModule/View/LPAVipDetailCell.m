//
//  LPAVipDetailCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAVipDetailCell.h"

@implementation LPAVipDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.diyDetailLabel.hidden = YES;
    
    self.inputTF.returnKeyType = UIReturnKeyDone;
    self.inputTF.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.inputTF resignFirstResponder];
}

//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
