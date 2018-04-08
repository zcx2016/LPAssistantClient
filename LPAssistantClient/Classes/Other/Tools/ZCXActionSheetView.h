//
//  ZCXActionSheetView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCXActionSheetView : UIView

@property (nonatomic, strong) UIButton *sureBtn;

- (instancetype)initWithActionSheet;

- (void)dismiss;

@end
