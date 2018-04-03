//
//  LPA_CRM_OrderDetailTopView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_OrderDetailTopView.h"

@implementation LPA_CRM_OrderDetailTopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    [self.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitPayBtn addTarget:self action:@selector(waitPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitPostBtn addTarget:self action:@selector(waitPostBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitReceiveBtn addTarget:self action:@selector(waitReceiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)fourBtnClick:(UIButton *)sender {
    if ([self.stateSelectedDelegate respondsToSelector:@selector(fourBtnClick:)]) {
        [self.stateSelectedDelegate fourBtnClick:sender];
    }
}


#pragma mark - 4个按钮点击事件  
- (void)allBtnClick:(UIButton *)btn{
    [self.allBtn setTitleColor:ZCXColor(202, 169, 90) forState:UIControlStateNormal];
    [self.waitPayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitPostBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitReceiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (void)waitPayBtnClick:(UIButton *)btn{
    [self.waitPayBtn setTitleColor:ZCXColor(202, 169, 90) forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitPostBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitReceiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (void)waitPostBtnClick:(UIButton *)btn{
    [self.waitPostBtn setTitleColor:ZCXColor(202, 169, 90) forState:UIControlStateNormal];
    [self.waitPayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitReceiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (void)waitReceiveBtnClick:(UIButton *)btn{
    [self.waitReceiveBtn setTitleColor:ZCXColor(202, 169, 90)  forState:UIControlStateNormal];
    [self.waitPayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.waitPostBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}


@end
