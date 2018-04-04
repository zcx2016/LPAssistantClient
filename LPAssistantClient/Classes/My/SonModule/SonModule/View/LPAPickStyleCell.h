//
//  LPAPickStyleCell.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPAPickStyleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *payImgView;
@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payIndicatorBtn;

@end
