//
//  ZCXActionSheetTBCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetTBCell.h"

@implementation ZCXActionSheetTBCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
