//
//  AppDelegate.m
//  LPAssistantClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "AppDelegate.h"
#import "RightSideViewController.h"

@interface AppDelegate ()<IIViewDeckControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
//    //先设置根控制器
//    self.window.rootViewController = [NSClassFromString(@"LPAMainTabBarC") new];
//    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    _rootTabbarCtrV = [NSClassFromString(@"LPAMainTabBarC") new];
    //右边
    RightSideViewController *rightView=[[RightSideViewController alloc]init];
    UINavigationController *rightNvi=[[UINavigationController alloc]initWithRootViewController:rightView];

    IIViewDeckController *viewDeckController =[[IIViewDeckController alloc]initWithCenterViewController:_rootTabbarCtrV leftViewController:nil rightViewController:rightNvi];
    viewDeckController.delegate=self;
    //由于项目需要---禁止抽屉的左滑右滑效果！
//    [viewDeckController.view removeGestureRecognizer:viewDeckController.leftEdgeGestureRecognizer];
//    [viewDeckController.view removeGestureRecognizer:viewDeckController.rightEdgeGestureRecognizer];

    self.window.rootViewController=viewDeckController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
