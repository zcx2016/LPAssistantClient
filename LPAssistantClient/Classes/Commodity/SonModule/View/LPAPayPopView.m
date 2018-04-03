//
//  LPAPayPopView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAPayPopView.h"

@implementation LPAPayPopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    self.maskBgView.userInteractionEnabled = YES;
    self.payStyleView.userInteractionEnabled = YES;
    self.wxPayView.userInteractionEnabled = YES;
    self.zfbPayView.userInteractionEnabled = YES;
    
    //设置圆角
    self.payStyleView.layer.cornerRadius = 5;
    self.payStyleView.layer.masksToBounds = YES;
    //增加手势
    [self.maskBgView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskBgView)]];
}

- (void)tapMaskBgView{
    [self dissMissView];
}

- (void)dissMissView{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)showView{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
}
@end
