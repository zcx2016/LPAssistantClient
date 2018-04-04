//
//  LPAPayPopView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPAPayPopViewDelegate<NSObject>

@optional
- (void)changePayStyle:(NSString *)string;

@end

@interface LPAPayPopView : UIView

@property (weak, nonatomic) IBOutlet UIView *maskBgView;
@property (weak, nonatomic) IBOutlet UIView *payStyleView;
@property (weak, nonatomic) IBOutlet UIView *wxPayView;
@property (weak, nonatomic) IBOutlet UIView *zfbPayView;

- (void)dissMissView;
- (void)showView;

@property (nonatomic, weak) id <LPAPayPopViewDelegate> delegate;

@end
