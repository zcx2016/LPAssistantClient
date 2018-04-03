//
//  LPA_CRM_OrderDetailCell.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPA_CRM_GoodsView.h"

@interface LPA_CRM_OrderDetailCell : UITableViewCell

@property (nonatomic, assign) BOOL  flag;  // 控制标签
@property (nonatomic, assign) NSInteger count; // 控件个数

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *goToPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@end
