//
//  LPAPayRoutePopView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPAPayRoutePopViewDelegate<NSObject>

@optional
- (void)changePayRouteStyle:(NSString *)string;

@end

@interface LPAPayRoutePopView : UIView

@property (weak, nonatomic) IBOutlet UIView *maskBgView;
@property (weak, nonatomic) IBOutlet UIView *lucencyView;

@property (weak, nonatomic) IBOutlet UILabel *onlinePayLabel;
@property (weak, nonatomic) IBOutlet UILabel *offlinePayLabel;

- (void)dissMissView;
- (void)showView;

@property (nonatomic, weak) id <LPAPayRoutePopViewDelegate> delegate;
@end
