//
//  BDMainViewController.m
//  BookDinner
//
//  Created by zqchen on 13/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDMainViewController.h"
#import "BDLeftViewController.h"
#import "PXAlertView.h"
#import "BDHomeViewController.h"
#import "BDNewsViewController.h"


@interface BDMainViewController ()<UITabBarControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic) CGPoint beginPoint;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) BDLeftViewController *leftNaviController;
@property (nonatomic,strong) UINavigationController *contentNaviController;
@property (nonatomic,strong) NSMutableArray *viewControllers;
@property (nonatomic,strong) NSURL *updateUrl;

@end

@implementation BDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShowLeftNotification:) name:@"handleShowLeftNotification" object:nil];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self.view addGestureRecognizer:pan];
    self.title = @"禾美定食";

    [self createContentNaviController];
    [self createCoverView];
    [self createLeftNaviController];
    [self createTutorialView];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:KAPPINFO_AutoLogin]){
        [self autoLogin];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init sub view
- (void)createNaviBar{
    
}

- (void)createCoverView{
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.coverView.backgroundColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView:)];
    [self.coverView addGestureRecognizer:pan];
    self.coverView.alpha = 0.0;
    [self.view addSubview:self.coverView];

}


- (void)createContentNaviController{
    self.contentNaviController = [[UINavigationController alloc] init];
    self.contentNaviController.view.backgroundColor = [UIColor whiteColor];
    self.contentNaviController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.contentNaviController.navigationBarHidden = YES;
    [self.view addSubview:self.contentNaviController.view];
    [self addChildViewController:self.contentNaviController];
    
    BDMenuModel *model = [[BDMenuModel alloc] init];
    model.title = @"订餐";
    model.type = @"recommended";

    HNYBaseViewController *controller = [self getViewController:model];
    [self.contentNaviController setViewControllers:[NSArray arrayWithObjects:controller, nil]];
}

- (void)createTabBar{
}

- (void)createTabBarItems{
}

- (void)createLeftNaviController{
    self.leftNaviController = [[BDLeftViewController alloc] init];
    self.leftNaviController.delegate = self;
    self.leftNaviController.customNaviController = self.navigationController;
    self.leftNaviController.view.frame = CGRectMake(-self.view.frame.size.width *3/4, 0, self.view.frame.size.width *3/4, self.view.frame.size.height);
    [self.view addSubview:self.leftNaviController.view];
    [self addChildViewController:self.leftNaviController];
    
}

- (void)createTutorialView{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:KAPPINFO_HadShowTutorial]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KAPPINFO_HadShowTutorial];
        [BDTutorialView presentTutorialViewWith:nil completion:^(BOOL done) {
            
        }];
        
    }
    
}
#pragma mark - notification
- (void)handleShowLeftNotification:(NSNotification*)fication{
    [self showLeftView];
}

#pragma mark - UIGestureRecognizer
- (void)panGestureRecognizer:(UIPanGestureRecognizer*)gesture{
    CGPoint translation = [gesture translationInView:self.view];
    NSLog(@"x = %f,y = %f",translation.x,translation.y);
    if ((gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled)) {
        if (translation.x > 20 && self.leftNaviController.view.frame.origin.x < -100) {
            [self showLeftView];
        }
    }
    else if (translation.x < -20 && self.leftNaviController.view.frame.origin.x > -10) {
        [self hideLeftView];
    }
}

- (void)tapCoverView:(UIGestureRecognizer *)gesture{
    //    if (self.rightPersonController.view.frame.origin.x < self.view.frame.size.width) {
    //
    //        __weak UIView *leftView = self.rightPersonController.view;
    //        __weak UIView *cover = self.coverView;
    //
    //        [UIView animateWithDuration:0.5 animations:^{
    //            cover.alpha = 0.0;
    //            CGRect frame = leftView.frame;
    //            frame.origin = CGPointMake(self.view.frame.size.width*3/4 + self.view.frame.size.width, 0);
    //            leftView.frame = frame;
    //        } completion:^(BOOL finished) {
    //
    //        }];
    //    }
    if (self.leftNaviController.view.frame.origin.x > -1){
        [self hideLeftView];
    }
}
#pragma mark - Get tht key Window top view
- (UIView*)getTopViewOfTheWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return [[window subviews] objectAtIndex:0];
}

#pragma mark - IBAction
- (void)touchLeftBarItem:(UIBarButtonItem*)sender{
    [self showLeftView];
}
#pragma mark - data request

- (void)autoLogin{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:KUSER_ACCOUNT],KUSER_ACCOUNT,
                                  [[NSUserDefaults standardUserDefaults] valueForKey:KUSER_PASSWORD],KUSER_PASSWORD,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionLogin];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionLogin,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",dictionary);
    [self.hud removeFromSuperview];
    
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([KAPI_ActionLogin isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {

            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Action_Login object:nil userInfo:nil ];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KUSER_IS_LOGIN];
            if ([[dictionary objectForKey:HTTP_VALUE] isKindOfClass:[NSDictionary class]])
            {
                [[NSUserDefaults standardUserDefaults] setValue:[[dictionary valueForKey:HTTP_VALUE] valueForKey:HTTP_TOKEN] forKey:HTTP_TOKEN];
            }
        }
    }
    else{
        if ([KAPI_ActionLogin isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSLog(@"auto login failed");
        }
    }
    
}

#pragma mark - data request
- (void)updateMenu:(NSNotification*)fication{
    [self createTabBarItems];
}

#pragma mark - HBPublicDelegate
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDLeftViewController class]]) {
        HNYBaseViewController *controller = [self getViewController:[info valueForKey:@"model"]];
        if (self.leftNaviController.view.frame.origin.x > -1){
            [self hideLeftView];
            if (![[self.contentNaviController.viewControllers objectAtIndex:0] isEqual:controller]) {
                [self.contentNaviController setViewControllers:@[controller] animated:YES];
            }
        }
    }
}
- (HNYBaseViewController*)getViewController:(BDMenuModel*)model
{
    if ([@"recommended" isEqualToString:model.type]) {
        BDHomeViewController *controller = [[BDHomeViewController alloc] init];
        controller.customNaviController = self.contentNaviController;
        return controller;
    }
    else if ([@"news" isEqualToString:model.type]){
        BDNewsViewController *controller = [[BDNewsViewController alloc] init];
        controller.customNaviController = self.contentNaviController;
        return controller;
    }
    BDHomeViewController *controller = [[BDHomeViewController alloc] init];
    controller.customNaviController = self.contentNaviController;
    return controller;
}

#pragma mark - show or hide left view
- (void)showLeftView{
    __weak UIView *leftView = self.leftNaviController.view;
    __weak UIView *cover = self.coverView;
    
    [UIView animateWithDuration:0.3 animations:^{
        cover.alpha = 0.3;
        CGRect frame = leftView.frame;
        frame.origin = CGPointZero;
        leftView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideLeftView{
    __weak UIView *leftView = self.leftNaviController.view;
    __weak UIView *cover = self.coverView;
    
    [UIView animateWithDuration:0.5 animations:^{
        cover.alpha = 0.0;
        CGRect frame = leftView.frame;
        frame.origin = CGPointMake(-self.view.frame.size.width*3/4, 0);
        leftView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
    }
}

@end
