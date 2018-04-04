//
//  ZCXActionSheetTopView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetTopView.h"
#import "LPAAddVipVC.h"

@implementation ZCXActionSheetTopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.addNewVipBtn addTarget:self action:@selector(addNewVipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNewVipBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideViewThenPushVc" object:nil];
}

- (void)searchBtnClick{
    NSLog(@"查询");
}

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
