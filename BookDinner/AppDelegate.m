//
//  AppDelegate.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "AppDelegate.h"
#import "BDMainViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

@interface AppDelegate()<HNYDelegate>
@property (nonatomic,strong) BDMainViewController *mainController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.mainController = [[BDMainViewController alloc] init];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:self.mainController];
    naviController.navigationBarHidden = YES;
    [self.window setRootViewController:naviController];
    [self.window makeKeyAndVisible];
    
    [UMSocialWechatHandler setWXAppId:WeiXinAppKey appSecret:@"test" url:@"http://www.umeng.com/social"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    //    __block UIBackgroundTaskIdentifier identifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    //        if (identifier != UIBackgroundTaskInvalid) {
    //            [[UIApplication sharedApplication] endBackgroundTask:identifier];
    //            identifier = UIBackgroundTaskInvalid;
    //        }
    //    }];
    //
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        for (int i=0; i < 20; i++) {
    //            NSLog(@"%d", i);
    //            sleep(1);
    //        }
    //        if (identifier != UIBackgroundTaskInvalid) {
    //            [[UIApplication sharedApplication] endBackgroundTask:identifier];
    //            identifier = UIBackgroundTaskInvalid;
    //        }
    //    });
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAppDidBecomeActive object:nil userInfo:nil ];
//    [PXAlertView showAlertWithTitle:@"fddd" message:nil cancelTitle:@"重试" otherTitle:nil contentView:nil delegate:self];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([sourceApplication hasPrefix:@"com.alipay"]) {
        [self parse:url application:application];
        return YES;
    }
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

#pragma mark - BMKGeneralDelegate

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[PXAlertView class]]) {
        PXAlertView *alert = (PXAlertView*)aView;
        if (0) {
            [alert hide];

        }
    }
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [self parse:url application:application];

//    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];

    return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
    if (result)
    {
        
        if (result.statusCode == 9000)
        {
/*
 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
 */

//交易成功
//            NSString* key = @"签约帐户后获取到的支付宝公钥";
//			id<DataVerifier> verifier;
//            verifier = CreateRSADataVerifier(key);
//
//			if ([verifier verifyString:result.resultString withSign:result.signString])
//            {
//                //验证签名成功，交易结果无篡改
//			}
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
    return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    
    return result;
}

@end
