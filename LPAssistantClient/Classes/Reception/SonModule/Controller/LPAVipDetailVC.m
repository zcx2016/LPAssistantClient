//
//  LPAVipDetailVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/30.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAVipDetailVC.h"
#import "LPAReceptionCell.h"
#import "LPAVipDetailCell.h"
#import "SCScanCodeVC.h"
#import "SCTimePickerView.h"

@interface LPAVipDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//自定义 联系电话 的inputAccessoryView
@property (nonatomic, strong) UIToolbar *customAccessoryView;

@property (nonatomic, weak) LPAVipDetailCell *weak_detailCell;

@property (nonatomic, weak) UITextField *tempTF;

@property (nonatomic, strong) SCTimePickerView *scTimePickerView;

@end

@implementation LPAVipDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"会员详情";
    
    //导航栏 右侧按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"开单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openNew) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self tableView];
    [self setBottomBtn];
    
    //生日通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vipBirthdayNoti:) name:@"vipBirthday" object:nil];
}

- (void)vipBirthdayNoti:(NSNotification *)noti{
    NSDictionary *timeDict = [noti userInfo];
    self.tempTF.text = [timeDict objectForKey:@"time"];
    [self.tempTF resignFirstResponder];
}

#pragma mark - 设置 底部按钮
- (void)setBottomBtn{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-55-64, kScreenWidth, 55)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 45)];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    //点击事件
    [bottomBtn addTarget:self action:@selector(saveEvents) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomBtn];
    [self.view addSubview:bottomView];
}

//保存按钮
- (void)saveEvents{
    NSLog(@"保存");
}

//开单
- (void)openNew{
    SCScanCodeVC *vc = [[UIStoryboard storyboardWithName:@"SCScanCodeVC" bundle:nil] instantiateViewControllerWithIdentifier:@"SCScanCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        LPAReceptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
        cell.indicatorBtn.hidden = YES;
        return cell;
    }else{
        LPAVipDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAVipDetailCell" forIndexPath:indexPath];
        cell.remindSwitch.hidden = YES;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.titleLabel.text = @"备注姓名";
                cell.inputTF.placeholder = @"请输入会员备注姓名";
            }else{
                cell.titleLabel.text = @"手机号";
                cell.inputTF.placeholder = @"请输入会员手机号码";
                self.weak_detailCell = cell;
                cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
                cell.inputTF.inputAccessoryView = self.customAccessoryView;
            }
        }else{
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"生日";
                cell.inputTF.placeholder = @"1988年8月8日";
                self.tempTF = cell.inputTF;
                self.scTimePickerView = [[[NSBundle mainBundle] loadNibNamed:@"SCTimePickerView" owner:self options:nil] firstObject];
                self.scTimePickerView.identifierStr = @"会员生日";
                cell.inputTF.inputView = self.scTimePickerView;
          
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"其他";
                cell.inputTF.placeholder = @"输入其他信息";
            }else{
                cell.titleLabel.text = @"生日提醒";
                cell.inputTF.hidden = YES;
                cell.remindSwitch.hidden = NO;
            }
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }
    return 50;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAReceptionCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAReceptionCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAVipDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAVipDetailCell"];
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
        UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_customAccessoryView setItems:@[cancel,space,search]];
    }
    return _customAccessoryView;
}

- (void)cancel{
    [self.weak_detailCell.inputTF resignFirstResponder];
}

- (void)done{
    [self.weak_detailCell.inputTF  resignFirstResponder];
}
@end
