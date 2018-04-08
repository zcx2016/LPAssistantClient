//
//  LPAFCHeadPickerView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPAFCHeadPickerViewDelegate<NSObject>

@optional
- (void)filterBtnClick:(UIButton *)btn;

@end


@interface LPAFCHeadPickerView : UIView

@property (weak, nonatomic) IBOutlet UIButton *brandBtn;

@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;

@property (weak, nonatomic) IBOutlet UIButton *discountBtn;

@property (nonatomic, weak) id <LPAFCHeadPickerViewDelegate> delegate;

@end
