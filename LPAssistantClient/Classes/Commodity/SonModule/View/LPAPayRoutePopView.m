//
//  LPAPayRoutePopView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAPayRoutePopView.h"

@implementation LPAPayRoutePopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    self.maskBgView.userInteractionEnabled = YES;
    self.lucencyView.userInteractionEnabled = YES;
    self.onlinePayLabel.userInteractionEnabled = YES;
    self.offlinePayLabel.userInteractionEnabled = YES;
    
    //设置圆角
    self.onlinePayLabel.layer.cornerRadius = 5;
    self.onlinePayLabel.layer.masksToBounds = YES;
    self.offlinePayLabel.layer.cornerRadius = 5;
    self.offlinePayLabel.layer.masksToBounds = YES;
    //增加手势
    [self.maskBgView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskBgView)]];
    [self.lucencyView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskBgView)]];
    //两种支付方式
    [self.onlinePayLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnlinePayLabel)]];
    [self.offlinePayLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOfflinePayLabel)]];
}

- (void)tapOnlinePayLabel{
    if ([self.delegate respondsToSelector:@selector(changePayRouteStyle:)]) {
        [self.delegate changePayRouteStyle:@"online"];
    }
}

- (void)tapOfflinePayLabel{
    if ([self.delegate respondsToSelector:@selector(changePayRouteStyle:)]) {
        [self.delegate changePayRouteStyle:@"offline"];
    }
}

#pragma mark - 显示和隐藏蒙版view
- (void)tapMaskBgView{
    [self dissMissView];
}

- (void)dissMissView{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)showView{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}
@end
