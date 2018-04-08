//
//  ZCXPullDownFilterView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/8.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXPullDownFilterView.h"
#import "ZCX_PDF_BrandCategoryCell.h"
#import "ZCX_PDF_DiscoutCell.h"

@interface ZCXPullDownFilterView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *maskView;//背景

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger typeTag;

@end

@implementation ZCXPullDownFilterView

- (instancetype)initWithPullDownFilterView:(NSInteger)tag{
    self = [super init];
    if(self){
        self.frame = [UIScreen mainScreen].bounds;
        self.typeTag = tag;
        [self addSubview:self.maskView];
        [self collectionView];
    }
    return self;
}

- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight-104)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.userInteractionEnabled = YES;
        _maskView.alpha = 0.5;
        [self addSubview:_maskView];
    }
    return _maskView;
}

#pragma mark ------ 绘制视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}

//滑动弹出
- (void)show {
    
    _collectionView.frame = CGRectMake(0, 104, kScreenWidth, 500);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = _collectionView.frame;
//        rect.origin.y -=  _collectionView.bounds.size.height;
        _collectionView.frame = rect;
    }];
}

//滑动消失
- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _collectionView.frame;
//        rect.origin.y += _collectionView.bounds.size.height;
        _collectionView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ------ 触摸屏幕其他位置弹下
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"event---%@",event);
    [self dismiss];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.typeTag == 0) {
        return 9;
    }else if (self.typeTag == 1){
        return 6;
    }else{
        return 5;
    }
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeTag == 0) {
        ZCX_PDF_BrandCategoryCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCX_PDF_BrandCategoryCell" forIndexPath:indexPath] ;
        
        return cell;
    }else if (self.typeTag == 1){
        ZCX_PDF_BrandCategoryCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCX_PDF_BrandCategoryCell" forIndexPath:indexPath] ;
        
        return cell;
    }else{
        ZCX_PDF_DiscoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCX_PDF_DiscoutCell" forIndexPath:indexPath] ;
        
        return cell;
    }

}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (self.typeTag == 2) {
        return UIEdgeInsetsMake(5, 15, 0, 15);
    }
    return UIEdgeInsetsMake(2, 15, 0, 10);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeTag == 2) {
        return CGSizeMake(kScreenWidth-30, 50);
    }
    return CGSizeMake(110, 110);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, 500) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ZCX_PDF_BrandCategoryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ZCX_PDF_BrandCategoryCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZCX_PDF_DiscoutCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ZCX_PDF_DiscoutCell"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
@end
