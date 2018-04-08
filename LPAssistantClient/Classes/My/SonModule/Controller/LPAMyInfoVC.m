//
//  LPAMyInfoVC.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPAMyInfoVC.h"
#import "LPAReceptionCell.h"
#import "LPPCommonTBCell.h"
#import "LPALoginVC.h"
#import "LPAChangePwdVC.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LPAMyInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, weak) LPAReceptionCell *weak_headCell;

@end

@implementation LPAMyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的资料";
    
    [self tableView];
    [self setBottomBtn];
    
    //照片选择器
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.imagePickerController.allowsEditing = YES;
}

#pragma mark - 设置 底部按钮
- (void)setBottomBtn{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-55-64, kScreenWidth, 55)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 45)];
    [bottomBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"redBtnBg"] forState:UIControlStateNormal];
    //点击事件
    [bottomBtn addTarget:self action:@selector(quitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomBtn];
    [self.view addSubview:bottomView];
}

- (void)quitLogin:(UIButton *)btn{
    LPALoginVC *vc = [LPALoginVC new];
    [self presentViewController:vc animated:YES completion:nil] ;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    return 4;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        LPAReceptionCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LPAReceptionCell" forIndexPath:indexPath];
        self.weak_headCell = cell;
        cell.headImgView.userInteractionEnabled = YES;
        [cell.headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgEvents:)]];
        cell.indicatorBtn.hidden = YES;
        cell.nameLabel.hidden = YES;
        cell.nickNameLabel.text = @"Stephen";
        cell.moneyLabel.text = @"金牌店员";
        return cell;
    }else{
        LPPCommonTBCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];
        cell.lineView.hidden = YES;
        if(indexPath.section == 1 && indexPath.row == 2){
            cell.diyDetailLabel.hidden = YES;
            cell.diyTitleLabel.text = @"修改密码";
        }else if (indexPath.section == 1&& indexPath.row == 3){
            cell.diyIndicatorBtn.hidden = YES;
            cell.diyTitleLabel.text = @"我的邀请码";
            cell.diyDetailLabel.text = @"AXSDFE";
            cell.diyDetailLabelTrailingConstraint.constant = 10;
            [cell.diyDetailLabel setFont:[UIFont systemFontOfSize:17]];
        }else{
            cell.diyIndicatorBtn.hidden = YES;
            cell.diyDetailLabelTrailingConstraint.constant = 10;
            if(indexPath.section == 0){
                if(indexPath.row == 1){
                    cell.diyTitleLabel.text = @"登录账号";
                    cell.diyDetailLabel.text = @"蜘蛛侠";
                }else{
                    cell.diyTitleLabel.text = @"所属门店";
                    cell.diyDetailLabel.text = @"虹口旗舰店";
                }
            }else{
                if(indexPath.row == 0){
                    cell.diyTitleLabel.text = @"职称";
                    cell.diyDetailLabel.text = @"金牌店员";
                }else{
                    cell.diyTitleLabel.text = @"姓名";
                    cell.diyDetailLabel.text = @"Stephen";
                }
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2) {
        LPAChangePwdVC * vc = [LPAChangePwdVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 更换头像
- (void)tapImgEvents:(UITapGestureRecognizer *)recognize{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"选择本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击调用相册
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController.allowsEditing = YES;
        //相册权限
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus ==ALAuthorizationStatusDenied){
            //无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        [self  presentViewController:self.imagePickerController animated:YES completion:nil];
    }]];
    
    //判断设备是否有具有摄像头(相机)功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击调用照相机
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.allowsEditing = YES;
            //相机权限
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus ==AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied ){
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self  presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 相机／相册 代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过key值获取到图片
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    //转换成jpg格式，并压缩，0.5比例最好
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
    //
    //    //将图片上传到服务器
    //    NSDictionary *dict = @{@"registerId" : self.registerId , @"employeeId" : self.employeeId};
    //
    //    [[LCHTTPSessionManager sharedInstance] upload:[kUrlReqHead stringByAppendingString:@"/app/users/updatePhoto.do"] parameters:dict name:@"imgarray0" fileName:imageName data:imageData completion:^(id  _Nonnull result, BOOL isSuccess) {
    //
    //        //存头像
    //        [UserDefautsLhm setObject:result[@"data"] forKey:KeyUserHeadImg];
    //    }];
    //
    //    //判断数据源类型
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {    //相册
        self.weak_headCell.headImgView.image = image;
        
        [self  dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {   //相机
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        self.weak_headCell.headImgView.image = image;
        [self  dismissViewControllerAnimated:YES completion:nil];
    }
}

//当用户取消选取时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
