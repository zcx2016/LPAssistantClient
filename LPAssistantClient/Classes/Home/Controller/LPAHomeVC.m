//
//  LPAHomeVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAHomeVC.h"
#import "ATCarouselView.h"
#import "LPAHomeCollectionCell.h"

@interface LPAHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,ATCarouselViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
//轮播图
@property (nonatomic, strong) ATCarouselView *carouselView;

@end

@implementation LPAHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self collectionView];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPAHomeCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPAHomeCollectionCell" forIndexPath:indexPath] ;
    if(indexPath.item == 0){
        [cell.imgView setImage:[UIImage imageNamed:@"bigScanNew"]];
        cell.nameLabel.text = @"扫一扫开单";
    }else if (indexPath.item == 1){
        [cell.imgView setImage:[UIImage imageNamed:@"bigFindCommodity"]];
        cell.nameLabel.text = @"找商品";
    }else if (indexPath.item == 2){
        [cell.imgView setImage:[UIImage imageNamed:@"bigVip"]];
        cell.nameLabel.text = @"添加会员";
    }else{
        [cell.imgView setImage:[UIImage imageNamed:@"bigVip"]];
        cell.nameLabel.text = @"查找我的会员";
    }
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 18, 15, 18);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(160, 140);
}

#pragma mark - 自定义headView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 170);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView addSubview:[self carouselView]];
        return headerView;
    }
    return nil;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = ZCXColor(245, 245, 245);
        //注册头视图--代码注册
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPAHomeCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPAHomeCollectionCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

//轮播图
- (void)carouselView:(ATCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger )index{
    NSLog(@"点击了第%ld张图片",index);
}

- (ATCarouselView *)carouselView{
    if (!_carouselView) {
        _carouselView = [[ATCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170)];
        _carouselView.delegate = self;
        _carouselView.images = @[
                                 [UIImage imageNamed:@"bannerHome"],
                                 [UIImage imageNamed:@"bannerHome"],
                                 [UIImage imageNamed:@"bannerHome"]
                                 ];
        //当前选中颜色
        _carouselView.currentPageColor = [UIColor blackColor];
        //普通状态颜色
        _carouselView.pageColor = [UIColor lightGrayColor];
    }
    return _carouselView;
}

@end
