//
//  LPACompletePayStyleVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/4/3.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPACompletePayStyleVC.h"
#import "LPACompletePayStyleCell.h"
#import "LPPCommonTBCell.h"
#import "LPAPayStyleActionSheetView.h"
//额外增加
#import "LPAPickStyleCell.h"

@interface LPACompletePayStyleVC ()<UITableViewDelegate,UITableViewDataSource,LPAPayStyleActionSheetViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger addCellCount;

@property (nonatomic, strong) UIImage *payImg;

@property (nonatomic, strong) NSString *payTitleStr;

@end

@implementation LPACompletePayStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"完善付款方式";
    self.addCellCount = 0;
    [self tableView];
    [self setBottomView];
}

- (void)setBottomView{
    //bottomView
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).with.offset(0);
        make.height.equalTo(@50);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    //具体金额
    UILabel *priceLabel = [UILabel new];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).with.offset(-15);
        make.centerY.equalTo(bottomView);
    }];
    priceLabel.text = @"￥4000";
    priceLabel.textColor = [UIColor redColor];
    
    //合计
    UILabel *sumLabel = [UILabel new];
    [bottomView addSubview:sumLabel];
    [sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(priceLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(bottomView);
    }];
    sumLabel.text = @"合计:";
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.addCellCount == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.addCellCount == 0) {
        return 2;
    }else{
        if (section == 0) {
            return 2;
        }else{
            return self.addCellCount;
        }
    }
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addCellCount == 0) {
        if (indexPath.row == 0) {
            LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
            cell.diyDetailLabel.hidden = YES;
            cell.lineView.hidden = YES;
            cell.diyTitleLabel.text = @"请选择支付方式";
            return cell;
        }else{
            LPACompletePayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACompletePayStyleCell" forIndexPath:indexPath];
            
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
                cell.diyDetailLabel.hidden = YES;
                cell.lineView.hidden = YES;
                cell.diyTitleLabel.text = @"请选择支付方式";
                return cell;
            }else{
                LPACompletePayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPACompletePayStyleCell" forIndexPath:indexPath];
                
                return cell;
            }
        }else{
            LPAPickStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPAPickStyleCell" forIndexPath:indexPath];
            cell.payIndicatorBtn.hidden = YES;
            cell.payMoneyLabel.hidden = NO;
            cell.payMoneyLabel.text = @"￥100";
            cell.payTitleLabel.text = self.payTitleStr;
            [cell.payImgView setImage:self.payImg];
            return cell;
        }
    }
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        LPAPayStyleActionSheetView  *sheetView = [[LPAPayStyleActionSheetView alloc] initWithActionSheet];
        //放在最上层
        sheetView.delegate = self;
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview:sheetView];
    }
}

- (void)addPayStyleCell:(NSInteger)row{
    if (row == 0) {  //微信
        self.payImg = [UIImage imageNamed:@"wxIcon"];
        self.payTitleStr = @"微信";
    }else if (row == 1){  //支付宝
        self.payImg = [UIImage imageNamed:@"zfbIcon"];
        self.payTitleStr = @"支付宝";
    }else if (row == 2){  //银行卡支付
        self.payImg = [UIImage imageNamed:@"bankCardIcon"];
        self.payTitleStr = @"银行卡支付";
    }else{  //现金支付
        self.payImg = [UIImage imageNamed:@"cash"];
        self.payTitleStr = @"现金";
    }
    self.addCellCount++;
    [self.tableView reloadData];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPACompletePayStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPACompletePayStyleCell"];
        //额外增加的
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPAPickStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPAPickStyleCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
