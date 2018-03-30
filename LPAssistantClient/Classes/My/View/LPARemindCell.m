//
//  LPARemindCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPARemindCell.h"

@implementation LPARemindCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.agreeBtn.layer.cornerRadius = 5;
    self.agreeBtn.layer.masksToBounds = YES;

    self.refuseBtn.layer.borderWidth = 1;
    self.refuseBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.refuseBtn.layer.cornerRadius = 5;
    self.refuseBtn.layer.masksToBounds = YES;
}


@end
