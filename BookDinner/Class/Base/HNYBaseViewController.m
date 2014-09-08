//
//  HNYBaseViewController.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"

@interface HNYBaseViewController ()

@end

@implementation HNYBaseViewController
@synthesize title = _subTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.naviBar = [[HNYNaviBar alloc] initWithFrame:CGRectZero];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];//[UIColor colorWithWhite:0.92 alpha:1.0];
    [self createNaviBar];
    [self createNaviBarItems];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - ini subview
- (void)createNaviBar{
    float height = 64;
    UIImage *image = [UIImage imageNamed:@"naviBar"];
    if ([[UIDevice currentDevice].systemVersion intValue] < 7){
        height = 44;
        image = nil;
    }
    
    self.naviBar.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    [self.view addSubview:self.naviBar];
}

- (void)createNaviBarItems{
    HNYNaviBarItem *barItem = [HNYNaviBarItem initWithNormalImage:[UIImage imageNamed:@"button_back"] downImage:[UIImage imageNamed:@"button_back"] target:self action:@selector(touchLeftBarItem:)];
    self.naviBar.leftItems = [NSArray arrayWithObjects:barItem, nil];
}

#pragma mark - IBAciton
- (void)touchLeftBarItem:(UIBarButtonItem*)sender{
    [self.customNaviController popViewControllerAnimated:YES];
}

#pragma mark - instance fun

- (void)setTitle:(NSString *)title{
    _subTitle = title;
    self.naviBar.title = title;
}

- (void)showRequestingTips:(NSString *)tips{
    self.hud.animationType = MBProgressHUDAnimationFade;
    self.hud.labelText = tips;
    if (![[self.view subviews] containsObject:self.hud]) {
        [self.view addSubview:self.hud];
        [self.view bringSubviewToFront:self.hud];
    }
    [self.hud show:YES];
}

- (void)showTips:(NSString *)tips{
    [self.hud removeFromSuperview];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = tips;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)popViewController{
    [self.customNaviController popViewControllerAnimated:YES];
}

#pragma mark - data request
- (void)requestData{
    
}
@end
