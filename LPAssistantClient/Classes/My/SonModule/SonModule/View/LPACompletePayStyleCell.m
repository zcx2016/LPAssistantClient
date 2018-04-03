//
//  LPACompletePayStyleCell.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPACompletePayStyleCell.h"

@implementation LPACompletePayStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputMoneyTF.inputAccessoryView = self.customAccessoryView;
}

//自定义 电话 和 qq 的inputAccessoryView
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,kScreenWidth,45}];
        _customAccessoryView.barTintColor = [UIColor lightGrayColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        [_customAccessoryView setItems:@[space,cancel]];
    }
    return _customAccessoryView;
}

- (void)cancel{
    [self.inputMoneyTF resignFirstResponder];
}


@end
