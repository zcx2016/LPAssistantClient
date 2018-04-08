//
//  ZCX_PDF_DiscoutCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/8.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCX_PDF_DiscoutCell.h"

@implementation ZCX_PDF_DiscoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = ZCXColor(242, 242, 242);
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
