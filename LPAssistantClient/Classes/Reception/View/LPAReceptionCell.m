//
//  LPAReceptionCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAReceptionCell.h"

@implementation LPAReceptionCell

- (void)awakeFromNib{
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.headImgView.layer setCornerRadius:CGRectGetHeight([self.headImgView bounds]) / 2];
    self.headImgView.layer.masksToBounds = YES;
}

@end
