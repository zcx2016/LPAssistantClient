//
//  SCTimePickerView.h
//  SceneCloudClient
//
//  Created by 张晨曦 on 17/7/19.
//  Copyright © 2017年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTimePickerView : UIView

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@end
