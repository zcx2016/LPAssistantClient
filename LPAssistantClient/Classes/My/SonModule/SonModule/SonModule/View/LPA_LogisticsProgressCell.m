//
//  LPA_LogisticsProgressCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPA_LogisticsProgressCell.h"

@implementation LPA_LogisticsProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.pointView.layer.borderWidth = 1;
    self.pointView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.pointView.layer.cornerRadius = 8;
    self.pointView.layer.masksToBounds = YES;
}


@end
