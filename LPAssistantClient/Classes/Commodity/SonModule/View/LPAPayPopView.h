//
//  LPAPayPopView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPAPayPopView : UIView

- (void)dissMissView;
- (void)showView;

@property (weak, nonatomic) IBOutlet UIView *maskBgView;
@property (weak, nonatomic) IBOutlet UIView *payStyleView;
@property (weak, nonatomic) IBOutlet UIView *wxPayView;
@property (weak, nonatomic) IBOutlet UIView *zfbPayView;

@end
