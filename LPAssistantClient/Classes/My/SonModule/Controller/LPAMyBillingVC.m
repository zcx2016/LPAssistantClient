//
//  LPAMyBillingVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//
#import "LPAMyBillingVC.h"
#import "LPAMyBillingCell.h"
#import "LPACommonSearchView.h"
#import "LPA_My_OrderDetailVC.h"

#import "ZCXActionSheetView.h"
#import "LPAAddVipVC.h"

@interface LPAMyBillingVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPACommonSearchView *searchView;

@property (nonatomic, strong) ZCXActionSheetView *sheetView;

@end

@implementation LPAMyBillingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单列表";
    
    [self tableView];
    [self searchView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideViewThenPushVcNoti:) name:@"hideViewThenPushVc" object:nil];
}

- (void)hideViewThenPushVcNoti:(NSNotification *)noti{
    [self.sheetView dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LPAAddVipVC *vc = [LPAAddVipVC new];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (LPACommonSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[NSBundle mainBundle] loadNibNamed:@"LPACommonSearchView" owner:nil options:nil].lastObject;
        _searchView.frame = CGRectMake(0, 0, kScreenWidth, 114);
        _searchView.backgroundColor =ZCXColor(245, 245, 245);
        _searchView.searchTF.placeholder = @"点击选择用户姓名";
        _searchView.searchTF.delegate = self;
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码
    self.sheetView = [[ZCXActionSheetView alloc] initWithActionSheet];
    //放在最上层
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.sheetView];
    //----注意：此处要return  NO
    return NO;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPAMyBillingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAMyBillingCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LPA_My_OrderDetailVC *vc = [LPA_My_OrderDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 左滑删除
//添加编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index===%ld",(long)indexPath.section);
    return UITableViewCellEditingStyleDelete;
}

//左滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//删除所做的动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 从数据源中删除
    //    [_data removeObjectAtIndex:indexPath.row];
    // 从列表中删除---不能直接写，要配合数据源刷新
    //    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAMyBillingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAMyBillingCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
