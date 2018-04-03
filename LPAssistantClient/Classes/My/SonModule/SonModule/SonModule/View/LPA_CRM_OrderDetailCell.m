//
//  LPA_CRM_OrderDetailCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_CRM_OrderDetailCell.h"

@implementation LPA_CRM_OrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@synthesize count = _count;
- (void)setCount:(NSInteger )count{
    if (count> 0 && _flag == NO) {
        _flag = YES;
        for (int i = 0; i < count; i++) {
            LPA_CRM_GoodsView *orderView = [[NSBundle mainBundle] loadNibNamed:@"LPA_CRM_GoodsView" owner:nil options:nil].lastObject;
            orderView.frame = CGRectMake(0, 110 + 120 *i, kScreenWidth, 0);
            [self addSubview:orderView];
        }
        
    }
}

@end
