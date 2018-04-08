//
//  LPAFCHeadPickerView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAFCHeadPickerView.h"

@implementation LPAFCHeadPickerView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 64, kScreenWidth, 40);
    [self.brandBtn addTarget:self action:@selector(brandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryBtn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.discountBtn addTarget:self action:@selector(discountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)brandBtnClick:(UIButton *)btn{
    [self.brandBtn setTitleColor:ZCXColor(189, 169, 104)  forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.discountBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(filterBtnClick:)]) {
        [self.delegate filterBtnClick:btn];
    }
}

- (void)categoryBtnClick:(UIButton *)btn{
    [self.brandBtn setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:ZCXColor(189, 169, 104) forState:UIControlStateNormal];
    [self.discountBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(filterBtnClick:)]) {
        [self.delegate filterBtnClick:btn];
    }
}

- (void)discountBtnClick:(UIButton *)btn{
    [self.brandBtn setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.discountBtn setTitleColor:ZCXColor(189, 169, 104) forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(filterBtnClick:)]) {
        [self.delegate filterBtnClick:btn];
    }
}
@end
