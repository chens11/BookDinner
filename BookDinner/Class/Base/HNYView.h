//
//  HNYView.h
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
#import "HNYDelegate.h"
#import "NSData+Base64.h"
#import "JSON.h"
#import "HNYJSONUitls.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "HNYTools.h"

@interface HNYView : UIView <HNYDelegate>
@property (nonatomic,strong) UINavigationController *customNaviController;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,weak) id <HNYDelegate> delegate;
- (void)showTips:(NSString *)tips inView:(UIView*)aView;

@end
