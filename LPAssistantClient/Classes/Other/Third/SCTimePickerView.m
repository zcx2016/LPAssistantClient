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
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewMoveDown" object:nil];
    [self removeFromSuperview];
}

- (void)doneBtnClick{
    //  将新的日期传过去
    if (self.timeString != nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"vipBirthday" object:nil userInfo:@{@"time" : self.timeString}];
//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"viewMoveDown" object:nil];
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
