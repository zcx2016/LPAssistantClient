//
//  SCScanCodeVC.m
//  SceneCloudClient
//
//  Created by 张晨曦 on 17/8/10.
//  Copyright © 2017年 张晨曦. All rights reserved.
//

#import "SCScanCodeVC.h"
#import <AVFoundation/AVFoundation.h>

@interface SCScanCodeVC ()<AVCaptureMetadataOutputObjectsDelegate,CALayerDelegate>

//设备
@property (nonatomic, strong) AVCaptureDevice *device;

//设备输入
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//数据输出
@property (nonatomic, strong) AVCaptureMetadataOutput *output;

//捕获会话
@property (nonatomic, strong) AVCaptureSession *session;

//预览图层，可以通过输出设备展示被捕获的数据流。
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/** 扫描的线 */
@property (nonatomic,strong) UIImageView *scanImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewW;
//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewH;

/** 非扫描区域的蒙版 */
@property(nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

//图片数组
@property (nonatomic, strong) NSArray *imgArray;

@end

@implementation SCScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"扫描二维码";
    // 设置扫描二维码
    [self setupScanQRCode];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self.flashBtn addTarget:self action:@selector(flashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 添加扫描线以及开启扫描线的动画
    [self startAnimate];
    
    // 开启二维码扫描
    [_session startRunning];
}

- (void)dealloc{
    // 删除预览图层
    if (_previewLayer) {
        [_previewLayer removeFromSuperlayer];
    }
    if (self.maskLayer) {
        self.maskLayer.delegate = nil;
    }
}
#pragma mark - <lazy - 懒加载>
/**
 *  懒加载设备
 */
- (AVCaptureDevice *)device {
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

/**
 *  懒加输入源
 */
- (AVCaptureDeviceInput *)input {
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

/**
 *  懒加载输出源
 */
- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _output;
}

/**
 *  添加扫描线以及开启扫描线的动画
 */
- (void)startAnimate {
    CGFloat scanImageViewX = self.scanView.frame.origin.x - 70;
    CGFloat scanImageViewY = self.scanView.frame.origin.y - 220 + 3;
    CGFloat scanImageViewW = self.scanViewW.constant + 8;
    CGFloat scanImageViewH = 7;
    
    _scanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanLine"]];
    _scanImageView.frame = CGRectMake(scanImageViewX, scanImageViewY, scanImageViewW, scanImageViewH);
    [self.scanView addSubview:_scanImageView];
    
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        _scanImageView.frame = CGRectMake(scanImageViewX, scanImageViewY + self.scanViewH.constant, scanImageViewW, scanImageViewH);
    } completion:nil];
}

/**
 *  设置扫描二维码
 */
- (void)setupScanQRCode {
    // 1、创建设备会话对象，用来设置设备数据输入
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset: AVCaptureSessionPresetHigh];    //高质量采集
    
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    // 设置条码类型为二维码
    [self.output setMetadataObjectTypes:self.output.availableMetadataObjectTypes];
    
    // 设置扫描范围
    [self setOutputInterest];
    
    // 3、实时获取摄像头原始数据显示在屏幕上
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //    _previewLayer.frame = self.view.layer.bounds;
    _previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
    self.view.layer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    self.maskLayer = [[CALayer alloc]init];
    //    self.maskLayer.frame = self.view.layer.bounds;
    self.maskLayer.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
    self.maskLayer.delegate = self;
    [self.view.layer insertSublayer:self.maskLayer above:_previewLayer];
    [self.maskLayer setNeedsDisplay];
}

/**
 *  设置二维码的扫描范围
 */
- (void)setOutputInterest {
    CGSize size = self.view.bounds.size;
    CGFloat scanViewWidth = 240;
    CGFloat scanViewHeight = 240;
    CGFloat scanViewX = (size.width - scanViewWidth) / 2;
    CGFloat scanViewY = (size.height - scanViewHeight) / 2;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.; //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        _output.rectOfInterest = CGRectMake((scanViewY + fixPadding) / fixHeight,
                                            scanViewX / size.width,
                                            scanViewHeight / fixHeight,
                                            scanViewWidth / size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        _output.rectOfInterest = CGRectMake(scanViewY / size.height,
                                            (scanViewX + fixPadding) / fixWidth,
                                            scanViewHeight / size.height,
                                            scanViewWidth / fixWidth);
    }
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate - 扫描二维码的回调方法>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *stringValue;
    // 显示遮盖
//    [SVProgressHUD showProgress:-1 status:@"读取数据中..."];
    
    if ([metadataObjects count ] > 0 ) {
        // 当扫描到数据时，停止扫描
        [ _session stopRunning ];
        
        // 将扫描的线从父控件中移除
        [_scanImageView removeFromSuperview];
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        
        if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSLog(@"--------%@-----",metadataObject.stringValue);
            
            stringValue = metadataObject.stringValue;
            // 当前延迟2.0秒
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 隐藏遮盖
//                [SVProgressHUD dismiss];
                
                //处理扫描结果，将扫描后的结果转换格式
                if (self.isFromSmallScanCodeBtn == YES) {
                    [self dealSmallScanResult:stringValue];
                }else{
                    [self dealScanResult:stringValue];
                }
            });
        }else{
//            [SVProgressHUD showWithStatus:@"请扫描正确的二维码！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
//                [SVProgressHUD dismiss];
            });
        }
    }
}

#pragma mark - 二级界面的小扫码
- (void)dealSmallScanResult:(NSString *)stringValue{
    NSDictionary *dict;
    NSLog(@"dict=====%@",dict);
    NSString *TPMItemID = dict[@"TPMItemID"];
    
    if ([TPMItemID isEqualToString:self.TPM_Item_ID]) {
        NSLog(@"扫描btn====%@",self.tempBtn);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD showSuccessWithStatus:@"扫描成功!"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"scanBtnClicked" object:self.tempBtn];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:@"请扫描正确的二维码!"];
            NSLog(@"11");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }
}

#pragma mark - 一级界面的大扫码
- (void)dealScanResult:(NSString *)stringValue{
    NSDictionary *dict;
    NSLog(@"dict+++++%@",dict);
    NSString *tpmItemGroupId = dict[@"TPMItemGroupID"];
    
    NSString *registerId = [self.userDefaults objectForKey:@"registerId"];
    NSString *finderId = [self.userDefaults objectForKey:@"finderId"];
    if (tpmItemGroupId.length != 0) {
        NSDictionary *paramDict = @{@"registerId": registerId , @"employeeId" : finderId , @"tpmItemGroupId" : tpmItemGroupId};
        
//        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/check/tpmPlanDetail.html"] parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//            if (responseObject[@"data"] != nil) {
//                NSArray *dataArray = responseObject[@"data"];
//
//                NSLog(@"--dataDict---%lu-----%@",(unsigned long)dataArray.count,dataArray);
//                SCAfterScanWriteVC *afterScanWriteVc = [SCAfterScanWriteVC new];
//                afterScanWriteVc.dataArray = dataArray;
//                [self.navigationController pushViewController:afterScanWriteVc animated:YES];
//
//            }else{
//                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"注意" message:responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }];
//                [alertVc addAction:actionYes];
//                [self presentViewController:alertVc animated:YES completion:nil];
//            }
//
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"----%@",error);
//        }];
    }else{
//        [SVProgressHUD showWithStatus:@"请扫描正确的二维码！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

#pragma mark - <CALayerDelegate - 图层的代理方法>
//   蒙板生成,需设置代理，并在退出页面时取消代理
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    if (layer == self.maskLayer) {
        UIGraphicsBeginImageContextWithOptions(self.maskLayer.frame.size, NO, 1.0);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
        CGContextFillRect(ctx, self.maskLayer.frame);
        CGRect scanFrame = [self.view convertRect:self.scanView.frame fromView:self.scanView.superview];
        CGContextClearRect(ctx, scanFrame);
    }
}

#pragma mark - 手电筒
- (void)flashBtnClick:(UIButton *)btn{
    if (btn.selected == NO) {
        [btn setImage:[UIImage imageNamed:@"openFlash"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        [self turnTorchOn:YES];
    }else{
        [btn setImage:[UIImage imageNamed:@"closeFlash"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        [self turnTorchOn:NO];
    }
}

- (void)turnTorchOn: (BOOL )on{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

@end

