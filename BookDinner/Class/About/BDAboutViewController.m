//
//  BDAboutViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAboutViewController.h"
#import "HNYDetailTableViewController.h"
#import "BDContactBossViewController.h"

@interface BDAboutViewController ()<HNYDetailTableViewControllerDelegate,HNYDelegate>
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;
@property (nonatomic,strong) NSString *introduction;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextView *addressTextView;

@end

@implementation BDAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于";
    [self createTable];
    [self setContent];
    [self getDeclaration];
    [self getBossInfo];
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create subview
- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 90;
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 50;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.tableViewController.cellHeight*9);
    if (self.tableViewController.cellHeight * 9 > self.view.frame.size.height - self.naviBar.frame.size.height)
        self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}
- (void)setContent{
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = Customer;
    nameItem.key = @"logo";
    nameItem.height = @"three";
    [_viewAry addObject:nameItem];
    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Label;
    numItem.editable = YES;
    numItem.name = @"  欢迎页";
    numItem.key = @"welocome";
    numItem.height = @"one";
    numItem.textFont = [UIFont systemFontOfSize:15.0];
    numItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:numItem];
    
    HNYDetailItemModel *declareItem = [[HNYDetailItemModel alloc] init];
    declareItem.viewType = Label;
    declareItem.editable = YES;
    declareItem.name = @"  介绍";
    declareItem.key = @"declare";
    declareItem.height = @"one";
    declareItem.textFont = [UIFont systemFontOfSize:15.0];
    declareItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:declareItem];
    
    HNYDetailItemModel *typeItem = [[HNYDetailItemModel alloc] init];
    typeItem.viewType = Label;
    typeItem.editable = YES;
    typeItem.height = @"one";
    typeItem.key = @"check_version";
    typeItem.textValue = @"2.03";
    typeItem.name = @"  检查更新";
    typeItem.textFont = [UIFont systemFontOfSize:15.0];
    typeItem.textAlignment = NSTextAlignmentRight;
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:typeItem];
    
    HNYDetailItemModel *phoneItem = [[HNYDetailItemModel alloc] init];
    phoneItem.viewType = Label;
    phoneItem.editable = YES;
    phoneItem.height = @"one";
    phoneItem.key = @"phone";
    phoneItem.textValue = @"18988995051";
    phoneItem.value = @"18988995051";
    phoneItem.name = @"  客服电话";
    phoneItem.textFont = [UIFont systemFontOfSize:15.0];
    phoneItem.textAlignment = NSTextAlignmentRight;
    phoneItem.textColor = [UIColor lightGrayColor];
    phoneItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:phoneItem];
    
    HNYDetailItemModel *developItem = [[HNYDetailItemModel alloc] init];
    developItem.viewType = Label;
    developItem.editable = YES;
    developItem.height = @"one";
    developItem.key = @"developer";
    developItem.textValue = @"o.m.g@foxmail.com";
    developItem.value = @"o.m.g@foxmail.com";
    developItem.name = @"  开发者";
    developItem.textFont = [UIFont systemFontOfSize:15.0];
    developItem.textAlignment = NSTextAlignmentRight;
    developItem.textColor = [UIColor lightGrayColor];
    developItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:developItem];
    
    HNYDetailItemModel *bossItem = [[HNYDetailItemModel alloc] init];
    bossItem.viewType = Label;
    bossItem.editable = YES;
    bossItem.height = @"one";
    bossItem.key = @"contactBoss";
    bossItem.name = @"  联系老板";
    bossItem.textValue = @"老板会根据您的留言赠送积分哦";
    bossItem.textFont = [UIFont systemFontOfSize:14.0];
    bossItem.textColor = [UIColor lightGrayColor];
    bossItem.textAlignment = NSTextAlignmentRight;
    bossItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:bossItem];
    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([@"logo" isEqualToString:item.key]) {
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableViewController.cellHeight*3)];
        numView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];//[UIColor colorWithWhite:0.92 alpha:1.0];

        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.tableViewController.cellHeight*2)];
        imgView.contentMode = UIViewContentModeCenter;
        [imgView setImage:[UIImage imageNamed:@"AppIcon11"]];
        [numView addSubview:imgView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tableViewController.cellHeight*2+10, self.view.frame.size.width, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"禾美定食";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15.0];
        [numView addSubview:label];
        
        return numView;
    }
    return nil;
}
#pragma mark - HNYDetailTableViewControllerDelegate
//item值改变的时候，改delegate传出值
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    
}
- (void)tableViewController:(HNYDetailTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNYDetailItemModel *model = [self.tableViewController.viewAry objectAtIndex:indexPath.row];
    if ([@"contactBoss" isEqualToString:model.key]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
            [self login];
        }else{
            BDContactBossViewController *controller = [[BDContactBossViewController alloc] init];
            controller.customNaviController = self.customNaviController;
            [self.customNaviController pushViewController:controller animated:YES];
        }
    }
    else if ([@"declare" isEqualToString:model.key]){
        HNYBaseViewController *controller = [[HNYBaseViewController alloc] init];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height)];
        [webView loadHTMLString:self.introduction baseURL:nil];
        [controller.view addSubview:webView];
        controller.title = @"介绍";
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
    }
    else if ([@"check_version" isEqualToString:model.key]){
        [self checkVersion];
    }
    else if ([@"phone" isEqualToString:model.key]){
        [self.webView loadHTMLString:nil baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.value]]];
    }
    else if ([@"developer" isEqualToString:model.key]){
        [self.webView loadHTMLString:nil baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"mail:%@",model.value]]];
    }
    else if ([@"welocome" isEqualToString:model.key]){
        [BDTutorialView presentTutorialViewWith:nil completion:^(BOOL done) {
            
        }];
    }
}
#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}

#pragma mark - http request
- (void)getDeclaration{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetDeclaration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetDeclaration,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getBossInfo{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetBossInfo];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetBossInfo,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}


- (void)checkVersion{
    
    [self showRequestingTips:@"正在检查更新..."];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionCheckVersion];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionCheckVersion,HTTP_USER_INFO, nil];
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
        if ([ActionGetDeclaration isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSDictionary *value = [dictionary valueForKey:@"value"];
            if ([value isKindOfClass:[NSDictionary class]]) {
                self.introduction = [value valueForKey:@"content"];
            }
        }
        else  if ([ActionCheckVersion isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [PXAlertView showAlertWithTitle:nil message:@"更新信息" cancelTitle:@"取消" otherTitle:@"更新" completion:^(BOOL cancelled) {
                if (!cancelled) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/fifa/id756904853?l=en&mt=8"]];
                }
            }];
        }
        else  if ([ActionGetBossInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSLog(@"dd");
//            email = "admin@yaxinw.com";
//            icp = "\U7ca4ICP\U5907 0123456789-1";
//            name = "\U79be\U7f8e\U5b9a\U98df";
//            phone = 13800138000;
//            qq = 659599263;
//            tel = "0663-8888888";
//            username = "\U67d0\U751f";

        }
    }
    else{
        if ([ActionGetDeclaration isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else  if ([ActionCheckVersion isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else  if ([ActionGetBossInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
