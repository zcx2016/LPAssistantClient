//
//  ZCXActionSheetView.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/4.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetView.h"
#import "ZCXActionSheetTopView.h"
#import "ZCXActionSheetTBCell.h"
//
#import "ZCXAlertView.h"

@interface ZCXActionSheetView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *maskView;//背景

@property (nonatomic, strong) ZCXActionSheetTopView *topView;

@property (nonatomic, strong) UIView *contentView;
@end

@implementation ZCXActionSheetView

- (instancetype)initWithActionSheet{
    self = [super init];
    if(self){
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.contentView];
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    [self setTopView];
    [self setTableView];
    [self setBottomView];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [_topView.inputTF resignFirstResponder];
}

//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)setTopView{
    _topView = [[NSBundle mainBundle] loadNibNamed:@"ZCXActionSheetTopView" owner:nil options:nil].lastObject;
    _topView.inputTF.returnKeyType = UIReturnKeyDone;
    _topView.inputTF.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self.contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).with.offset(0);
        make.height.equalTo(@90);
    }];
}

- (void)setTableView{
    _tableView = [UITableView new];
    [self.contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).with.offset(0);
        make.top.equalTo(self.contentView).with.offset(90);
        make.bottom.equalTo(self.contentView).with.offset(-55);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //去掉ios7 的separatorInset边距
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCXActionSheetTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZCXActionSheetTBCell"];
    //注册headView
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headView"];
}

- (void)setBottomView{
    UIView *botView = [UIView new];
    botView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:botView];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView).with.offset(0);
        make.height.equalTo(@55);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ZCXColor(239, 239, 239);
    [botView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(botView).with.offset(0);
        make.height.equalTo(@1);
    }];
    
    self.sureBtn = [UIButton new];
    [botView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(botView).with.offset(10);
        make.right.equalTo(botView).with.offset(-10);
        make.top.equalTo(botView).with.offset(5);
        make.bottom.equalTo(botView).with.offset(-5);
    }];
    [self.sureBtn setTitle:@"选择会员" forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(pickVip) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
}

- (void)pickVip{

    ZCXAlertView  *alertView = [[NSBundle mainBundle] loadNibNamed:@"ZCXAlertView" owner:nil options:nil].lastObject;
    //放在最上层
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:alertView];
}

//背景
- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.userInteractionEnabled = YES;
        _maskView.alpha = 0.5;
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-500, kScreenWidth, 500)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark ------ 绘制视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}

//滑动弹出
- (void)show {

    _contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 500);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = _contentView.frame;
        rect.origin.y -= _contentView.bounds.size.height;
        _contentView.frame = rect;
    }];
}

//滑动消失
- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _contentView.frame;
        rect.origin.y += _contentView.bounds.size.height;
        _contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ------ 触摸屏幕其他位置弹下
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"event---%@",event);
    [self dismiss];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZCXActionSheetTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZCXActionSheetTBCell" forIndexPath:indexPath];

    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 120, 35)];
    label.text = @"我的会员(25)";
    label.textColor = [UIColor darkGrayColor];
    [headView addSubview:label];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZCXActionSheetTBCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.pickBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZCXActionSheetTBCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.pickBtn setImage:[UIImage imageNamed:@"disSelect"] forState:UIControlStateNormal];
}

@end
