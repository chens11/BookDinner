//
//  BDLeftViewController.m
//  BookDinner
//
//  Created by zqchen on 13/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDLeftViewController.h"
#import "BDLoginViewController.h"
#import "UMSocial.h"
#import "BDSettingViewController.h"
#import "BDPersonViewController.h"
#import "BDAboutViewController.h"
#import "BDOrderViewController.h"
#import "BDCouponViewController.h"

@interface BDLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIImageView *logoMenu;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UITableView *menuTable;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) NSMutableArray *menuAry;
@property (nonatomic,strong) UIImageView *bgImageView;

@end

@implementation BDLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuAry = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginNotifcation:)
                                                 name:NotificationActionLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutNotifcation:)
                                                 name:NotificationActionLogout object:nil];

    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.bgImageView.image = [UIImage imageNamed:@"bg_black"];
    [self.view addSubview:self.bgImageView];
    
    BDMenuModel *model = [[BDMenuModel alloc] init];
    model.title = @"今日推荐";
    model.type = @"recommended";
    
    BDMenuModel *centermodel = [[BDMenuModel alloc] init];
    centermodel.title = @"个人中心";
    centermodel.type = @"center";
    
    BDMenuModel *ordermodel = [[BDMenuModel alloc] init];
    ordermodel.title = @"我的订单";
    ordermodel.type = @"order";
    
    BDMenuModel *settingmodel = [[BDMenuModel alloc] init];
    settingmodel.title = @"设置";
    settingmodel.type = @"setting";
    
    BDMenuModel *aboutmodel = [[BDMenuModel alloc] init];
    aboutmodel.title = @"关于";
    aboutmodel.type = @"about";
    
    BDMenuModel *pointsmodel = [[BDMenuModel alloc] init];
    pointsmodel.title = @"我的优惠券";
    pointsmodel.type = @"points";
    
    [self.menuAry addObject:model];
    [self.menuAry addObject:centermodel];
//    [self.menuAry addObject:ordermodel];
//    [self.menuAry addObject:settingmodel];
    [self.menuAry addObject:aboutmodel];
//    [self.menuAry addObject:pointsmodel];

    [self createTopView];
    [self createContentTable];
    [self createBottomView];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create subviews

- (void)createNaviBar{
    
}

- (void)createNaviBarItems{
    
}
- (void)createTopView{
    
    self.logoMenu = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.logoMenu.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/5);
    self.logoMenu.backgroundColor = [UIColor colorWithRed:79.0/255 green:89.0/255 blue:100.0/255 alpha:1.0];
    self.logoMenu.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    self.logoMenu.image = [UIImage imageNamed:@"AppIcon11"];
    [self.view addSubview:self.logoMenu];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height*2/5 - 35, 75, 40);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN])
        [self.loginBtn setTitle:@"签到" forState:UIControlStateNormal];
    else
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [self.loginBtn setTintColor:[UIColor whiteColor]];
    self.loginBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [self.loginBtn addTarget:self action:@selector(touchSginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setImage:[UIImage imageNamed:@"tmall_baby_info_edit"] forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
}

- (void)createContentTable{
    self.menuTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*2/5, self.view.frame.size.width, self.view.frame.size.height - self.view.frame.size.height*2/5 - 49) style:UITableViewStylePlain];
    self.menuTable.backgroundView = nil;
    self.menuTable.backgroundColor = [UIColor clearColor];
    self.menuTable.separatorColor = [UIColor clearColor];
    self.menuTable.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self.view addSubview:self.menuTable];
}

- (void)createBottomView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [button setBackgroundImage:[UIImage imageNamed:@"tabBar"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"iconShare"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49);
    [button addTarget:self action:@selector(touchShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UITableViewCell";
    BDLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell iniDataWithModel:[self.menuAry objectAtIndex:indexPath.row]];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDMenuModel *model = [self.menuAry objectAtIndex:indexPath.row];
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:indexPath,@"indexPath", nil];
    if ([@"setting" isEqualToString:model.type]) {
        BDSettingViewController *controller = [[BDSettingViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
    }
    else if ([@"center" isEqualToString:model.type]) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
            [self login];
        }
        else{
            [self.delegate viewController:self actionWitnInfo:info];

            BDPersonViewController *controller = [[BDPersonViewController alloc] init];
            controller.customNaviController = self.customNaviController;
            [self.customNaviController pushViewController:controller animated:YES];
        }
        
    }
    else if ([@"order" isEqualToString:model.type]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
            [self login];
        }
        else{

        BDOrderViewController *controller = [[BDOrderViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
        }
    }
    else if ([@"about" isEqualToString:model.type]) {
        [self.delegate viewController:self actionWitnInfo:info];

        BDAboutViewController *controller = [[BDAboutViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
    }
    else if ([@"points" isEqualToString:model.type]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
            [self login];
        }
        else{

        BDCouponViewController *controller = [[BDCouponViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
        }
        
    }
    else{
        [self.delegate viewController:self actionWitnInfo:info];
    }
}

#pragma mark - IBAction

- (void)touchSginButton:(UIButton *)sender{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
        [self login];
        return;
    }
    [self showRequestingTips:nil];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  token,HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionSing];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionSing,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",string);
    [self.hud removeFromSuperview];

    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionSing isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionSavePersonInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionSing isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionSing isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }

}
#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}
- (void)touchShareButton:(UIButton*)sender{
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.yaxinw.com/doc/";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.yaxinw.com/doc/";
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = @"http://www.yaxinw.com/doc/";
    NSString *msg = [NSString stringWithFormat:@"亲们，赶快来订餐吧！http://www.yaxinw.com/doc/"];
    [UMSocialSnsService presentSnsIconSheetView:self.parentViewController
                                         appKey:UMSocialAppKey
                                      shareText:msg
                                     shareImage:[UIImage imageNamed:@"dinner"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:nil];
}

#pragma mark - NSNoticefication
- (void)logoutNotifcation:(NSNotification*)fication{
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
}


- (void)loginNotifcation:(NSNotification*)fication{
    [self.loginBtn setTitle:@"签到" forState:UIControlStateNormal];
}
#pragma mark - UMSocialUIDelegate
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess){
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
