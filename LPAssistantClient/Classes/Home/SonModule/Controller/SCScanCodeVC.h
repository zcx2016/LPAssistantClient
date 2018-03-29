//
//  SCScanCodeVC.h
//  SceneCloudClient
//
//  Created by 张晨曦 on 17/8/10.
//  Copyright © 2017年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCScanCodeVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *scanView;

@property (weak, nonatomic) IBOutlet UIButton *flashBtn;

@property (nonatomic, assign) BOOL isFromSmallScanCodeBtn;

@property (nonatomic, copy) NSString  *TPM_Item_ID;

@property (nonatomic, strong) UIButton *tempBtn;

@end
