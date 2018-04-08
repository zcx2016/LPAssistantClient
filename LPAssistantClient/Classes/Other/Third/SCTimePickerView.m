//
//  SCTimePickerView.m
//  SceneCloudClient
//
//  Created by 张晨曦 on 17/7/19.
//  Copyright © 2017年 张晨曦. All rights reserved.
//

#import "SCTimePickerView.h"

@interface SCTimePickerView ()

@property (nonatomic, copy) NSString *timeString;
@end

@implementation SCTimePickerView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    self.datePickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [self.datePickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelBtnClick{
    //取消时，界面也要下移
    [self removeFromSuperview];
}

- (void)doneBtnClick{
    NSLog(@"self.identifierSt---%@",self.identifierStr);
    //  将新的日期传过去
    if (self.timeString != nil) {
        if ([self.identifierStr isEqualToString:@"会员生日"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"vipBirthday" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"门店排名开始时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"storeRankStart" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"门店排名结束时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"storeRankEnd" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"我的门店开始时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myStoreStart" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"我的门店结束时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myStoreEnd" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"我的KPI开始时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myKPIStart" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"我的KPI结束时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myKPIEnd" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"消费明细开始时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"spendDetailStart" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"消费明细结束时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"spendDetailEnd" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"订单明细开始时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailStart" object:nil userInfo:@{@"time" : self.timeString}];
        }
        if ([self.identifierStr isEqualToString:@"订单明细结束时间"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailEnd" object:nil userInfo:@{@"time" : self.timeString}];
        }

    }
    [self removeFromSuperview];
}

- (void)dateChange:(UIDatePicker *)datePicker{
    
    NSDate *theDate = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    self.timeString = [dateFormatter stringFromDate:theDate];
    NSLog(@"%@",self.timeString);
}

@end
