//
//  LPACouponCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPACouponCell.h"

@implementation LPACouponCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.pickBtn addTarget:self action:@selector(pickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pickBtnClick:(UIButton *)btn{
    if (!btn.selected) {
        [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
    }else{
        [btn setImage:[UIImage imageNamed:@"disSelect"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
    }
}

@end
