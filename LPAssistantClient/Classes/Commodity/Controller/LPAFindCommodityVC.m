//
//  LPAFindCommodityVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/29.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAFindCommodityVC.h"
#import "LPPCommodityCell.h"
#import "LPAFCHeadPickerView.h"
#import "LPPNavSearchView.h"

#import "LPAPayOnlineVC.h"

@interface LPAFindCommodityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) LPAFCHeadPickerView *headPickerView;

@property (nonatomic, strong) LPPNavSearchView *navSearchView;

@end

@implementation LPAFindCommodityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.导航栏右侧 扩展 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"extern"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(externEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //4.导航栏 搜索框
    [self navSearchView];
    //
    [self collectionView];
    [self headPickerView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //1.去除 导航栏下面边界黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //1.显示 导航栏下面边界黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = NO;
}

- (LPPNavSearchView *)navSearchView{
    if (!_navSearchView) {
        _navSearchView = [[NSBundle mainBundle] loadNibNamed:@"LPPNavSearchView" owner:nil options:nil].lastObject;
        _navSearchView.frame = CGRectMake(40, 0, kScreenWidth-70, 35);
        self.navigationItem.titleView = _navSearchView;
        //搜索按钮
//        [_navSearchView.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navSearchView;
}

#pragma mark - 弹出右边筛选
- (void)externEvents:(UIButton *)btn{
//    [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
}

- (LPAFCHeadPickerView *)headPickerView{
    if (!_headPickerView) {
        _headPickerView = [[NSBundle mainBundle] loadNibNamed:@"LPAFCHeadPickerView" owner:nil options:nil].lastObject;
        _headPickerView.frame = CGRectMake(0, 0, kScreenWidth, 104);
        [self.view addSubview:_headPickerView];
    }
    return _headPickerView;
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPCommodityCell" forIndexPath:indexPath] ;
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 15, 0, 10);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(105, 170);
}

#pragma mark - 自定义headView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 170);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPAPayOnlineVC *vc = [LPAPayOnlineVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (self.imgView) {
            [self.imgView removeFromSuperview];
        }
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerCloth"]];
        //联通数据时用SDWebImg
        [headerView addSubview:self.imgView];
        return headerView;
    }
    return nil;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册头视图--代码注册
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPCommodityCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPCommodityCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
