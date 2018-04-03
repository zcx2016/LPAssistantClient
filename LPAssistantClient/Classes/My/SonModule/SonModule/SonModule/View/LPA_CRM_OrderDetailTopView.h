//
//  LPA_CRM_OrderDetailTopView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPA_CRM_OrderDetailTopViewDelegate<NSObject>

@optional
- (void)fourBtnClick:(UIButton *)btn;

@end

@interface LPA_CRM_OrderDetailTopView : UIView

@property (weak, nonatomic) IBOutlet UITextField *startTF;
@property (weak, nonatomic) IBOutlet UITextField *endTF;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitPostBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitReceiveBtn;

@property (nonatomic, weak) id <LPA_CRM_OrderDetailTopViewDelegate> stateSelectedDelegate;

@end
