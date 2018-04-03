//
//  LPACompletePayStyleCell.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPACompletePayStyleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTF;

//自定义 搜索框 的inputAccessoryView
@property (nonatomic, strong) UIToolbar *customAccessoryView;

@end
