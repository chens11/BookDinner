//
//  HNYBaseViewController.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYRefreshTableViewController.h"
#import "HNYDetailTableViewController.h"
#import "PublicDefine.h"
#import "HNYDelegate.h"
#import "HNYNaviBar.h"
#import "HNYTabBar.h"
#import "NSData+Base64.h"
#import "JSON.h"
#import "HNYJSONUitls.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "PXAlertView.h"
#import "AppInfo.h"
#import "HNYPopoverView.h"
#import "HNYTools.h"
#import "HNYTextField.h"
#import "BDPersonModel.h"
#import "HNYDetailItemModel.h"

@interface HNYBaseViewController : UIViewController <HNYDelegate>
@property (nonatomic,strong) HNYNaviBar *naviBar;
@property (nonatomic,strong) HNYTabBar *tabBar;
@property (nonatomic,weak) id <HNYDelegate> delegate;
@property (nonatomic,strong) MBProgressHUD *hud;

- (void)requestData;
- (void)createNaviBar;
- (void)createNaviBarItems;
- (void)touchLeftBarItem:(UIBarButtonItem*)sender;
- (void)showRequestingTips:(NSString*)tips;
- (void)showTips:(NSString *)tips;
- (void)popViewController;

@end
