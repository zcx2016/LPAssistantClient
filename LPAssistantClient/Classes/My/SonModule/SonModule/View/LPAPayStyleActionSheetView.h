//
//  LPAPayStyleActionSheetView.h
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPAPayStyleActionSheetViewDelegate<NSObject>

@optional
- (void)addPayStyleCell;

@end

@interface LPAPayStyleActionSheetView : UIView

- (instancetype)initWithActionSheet;

@property (nonatomic, weak) id<LPAPayStyleActionSheetViewDelegate> delegate;

@end
