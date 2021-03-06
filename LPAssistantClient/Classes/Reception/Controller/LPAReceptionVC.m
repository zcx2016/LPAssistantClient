//
//  LPAReceptionVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAReceptionVC.h"
#import "LPAReceptionCell.h"
#import "LPACommonSearchView.h"
#import "LPAVipDetailVC.h"
#import "YCXMenu.h"
//跳转
#import "LPAAddVipVC.h"
#import "SCScanCodeVC.h"

@interface LPAReceptionVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPACommonSearchView *searchView;

//自定义 联系电话 的inputAccessoryView
@property (nonatomic, strong) UIToolbar *customAccessoryView;
//右上角
@property (nonatomic , strong) NSMutableArray *items;
//右上角btn
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation LPAReceptionVC

//因为父类中有，此处必须再写一个，来手动生成 成员变量
@synthesize items = _items;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"客户接待";
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addBtn];
    
    [self tableView];
    [self searchView];
}

- (LPACommonSearchView *)searchView{
    if(!_searchView){
        _searchView = [[NSBundle mainBundle] loadNibNamed:@"LPACommonSearchView" owner:nil options:nil].lastObject;
        _searchView.frame = CGRectMake(0, 0, kScreenWidth, 114);
        _searchView.backgroundColor =ZCXColor(245, 245, 245);
        _searchView.searchTF.inputAccessoryView = self.customAccessoryView;
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (void)addBtnClick:(UIButton *)btn{

    if (!btn.selected) {
        btn.selected = !btn.selected;
       [YCXMenu setTintColor:[UIColor whiteColor]];
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(kScreenWidth-55, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            NSLog(@"index----%ld,item----%@",(long)index,item);
        }];
    }else{
        btn.selected = !btn.selected;
        [YCXMenu dismissMenu];
    }

}

#pragma mark - setter/getter
- (void)setItems:(NSMutableArray *)items {
    _items = items;
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [@[
                    [YCXMenuItem menuItem:@"绑定会员"
                                    image:[UIImage imageNamed:@"bindVip"]
                                   target:self
                                   action:@selector(clickItemOne)],
                    [YCXMenuItem menuItem:@"扫一扫开单"
                                    image:[UIImage imageNamed:@"scan"]
                                   target:self
                                   action:@selector(clickItemTwo)]
                    ] mutableCopy];
    }
    return _items;
}

- (void)clickItemOne{
    self.addBtn.selected = !self.addBtn.selected;
    LPAAddVipVC * vc = [LPAAddVipVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickItemTwo{
    self.addBtn.selected = !self.addBtn.selected;
    SCScanCodeVC *vc = [[UIStoryboard storyboardWithName:@"SCScanCodeVC" bundle:nil] instantiateViewControllerWithIdentifier:@"SCScanCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPAReceptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LPAVipDetailVC *vc = [LPAVipDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAReceptionCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAReceptionCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//自定义 电话 和 qq 的inputAccessoryView
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,kScreenWidth,45}];
        _customAccessoryView.barTintColor = [UIColor lightGrayColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(startSearch)];
        [_customAccessoryView setItems:@[cancel,space,search]];
    }
    return _customAccessoryView;
}

- (void)cancel{
    [self.searchView.searchTF resignFirstResponder];
}

- (void)startSearch{
    [self.searchView.searchTF resignFirstResponder];
}
@end
