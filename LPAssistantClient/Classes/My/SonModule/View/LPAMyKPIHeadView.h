//
//  LPAMyKPIHeadView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/2.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPAMyKPIHeadView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *saleTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *saleDetailLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyDetailLabel;


@property (weak, nonatomic) IBOutlet UILabel *rateDetailLabel;


@end
