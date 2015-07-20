//
//  BDPersonViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPersonViewController.h"
#import "BDChangePasswordViewController.h"
#import "BDCouponViewController.h"
#import "BDAddressViewController.h"
#import "BDLuckyDrawViewController.h"
#import "HNYDetailTableViewController.h"
#import "BDOrderViewController.h"
#import "BDWalletViewController.h"

@interface BDPersonViewController ()<HNYDetailTableViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *menuAry;
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) UITextField *payTextField;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;
@property (nonatomic) BOOL needRefresh;

@end

@implementation BDPersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.needRefresh = NO;
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        self.menuAry = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginNotifcation:)
                                                 name:NotificationActionLogin object:nil];

    [self createTable];
    [self setContent];
    [self getPersonInfo];

    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(5, self.view.frame.size.height - 55, self.view.frame.size.width - 10, 40);
    [logoutBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = ButtonTitleFont;
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(touchLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.needRefresh) {
        self.needRefresh = NO;
        [self getPersonInfo];
    }
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

#pragma mark - create subview
- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 100;
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 50;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 65 - self.naviBar.frame.size.height);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}

- (void)setContent{
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = TextField;
    nameItem.editable = NO;
    nameItem.key = @"account";
    nameItem.textAlignment = NSTextAlignmentRight;
    nameItem.textValue = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ACCOUNT];
    nameItem.textColor = [UIColor lightGrayColor];
    nameItem.name = @"  账号";
    nameItem.height = @"one";
    nameItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:nameItem];
    
    HNYDetailItemModel *walletItem = [[HNYDetailItemModel alloc] init];
    walletItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    walletItem.viewType = Label;
    walletItem.editable = NO;
    walletItem.height = @"one";
    walletItem.textAlignment = NSTextAlignmentRight;
    walletItem.textColor = [UIColor lightGrayColor];
    walletItem.key = @"wallet";
    walletItem.name = @"  我的钱包";
    [_viewAry addObject:walletItem];
    
    HNYDetailItemModel *orderItem = [[HNYDetailItemModel alloc] init];
    orderItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    orderItem.viewType = Label;
    orderItem.editable = NO;
    orderItem.height = @"one";
    orderItem.key = @"order";
    orderItem.name = @"  我的订单";
    [_viewAry addObject:orderItem];
    

    HNYDetailItemModel *second = [[HNYDetailItemModel alloc] init];
    second.viewType = Label;
    second.backGroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    second.editable = NO;
    second.height = @"auto";
    second.maxheight = 35;
    second.minheight = 35;
    second.key = @"second";
    [_viewAry addObject:second];

    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Label;
    numItem.editable = NO;
    numItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    numItem.name = @"  账号密码 ";
    numItem.key = @"password";
    numItem.height = @"one";
    [_viewAry addObject:numItem];
    
    
    HNYDetailItemModel *typeItem = [[HNYDetailItemModel alloc] init];
    typeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    typeItem.viewType = Label;
    typeItem.editable = NO;
    typeItem.height = @"one";
    typeItem.key = @"address";
    typeItem.name = @"  管理地址";
    [_viewAry addObject:typeItem];
    
    
    HNYDetailItemModel *third = [[HNYDetailItemModel alloc] init];
    third.viewType = Label;
    third.backGroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    third.editable = NO;
    third.height = @"auto";
    third.maxheight = 35;
    third.minheight = 35;
    third.key = @"third";
    [_viewAry addObject:third];

    
    HNYDetailItemModel *couponItem = [[HNYDetailItemModel alloc] init];
    couponItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    couponItem.viewType = Label;
    couponItem.editable = NO;
    couponItem.height = @"one";
    couponItem.key = @"coupon";
    couponItem.name = @"  我的优惠券";
    couponItem.textAlignment = NSTextAlignmentRight;
    couponItem.textColor = [UIColor lightGrayColor];
    [_viewAry addObject:couponItem];
    
    HNYDetailItemModel *pointItem = [[HNYDetailItemModel alloc] init];
    pointItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    pointItem.viewType = Label;
    pointItem.editable = NO;
    pointItem.height = @"one";
    pointItem.textAlignment = NSTextAlignmentRight;
    pointItem.textColor = [UIColor lightGrayColor];
    pointItem.key = @"points";
    pointItem.name = @"  我的积分";
    [_viewAry addObject:pointItem];
    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

#pragma mark -
#pragma mark - ibaction
- (void)touchLogoutButton:(UIButton*)sender{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IS_LOGIN];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:HTTP_TOKEN];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationActionLogout object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
  
}
#pragma mark - HNYDetailTableViewControllerDelegate
//item值改变的时候，改delegate传出值
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    
}
- (void)tableViewController:(HNYDetailTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.personModel)
        return;
    HNYDetailItemModel *model = [self.tableViewController.viewAry objectAtIndex:indexPath.row];
    if ([@"account" isEqualToString:model.key]) {
        BDPersonDetailViewController *controller = [[BDPersonDetailViewController alloc] init];
        controller.personModel = self.personModel;
        [self.navigationController pushViewController:controller animated:YES];

    }
    else if ([@"password" isEqualToString:model.key]) {
        BDChangePasswordViewController *controller = [[BDChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"address" isEqualToString:model.key]) {
        BDAddressViewController *controller = [[BDAddressViewController alloc] init];
        controller.title = @"管理收货地址";
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"coupon" isEqualToString:model.key]) {
        BDCouponViewController *controller = [[BDCouponViewController alloc] init];
        controller.title = @"我的优惠券";
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"points" isEqualToString:model.key]) {
        BDLuckyDrawViewController *controller = [[BDLuckyDrawViewController alloc] init];
        controller.personModel = self.personModel;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"order" isEqualToString:model.key]) {
        BDOrderViewController *controller = [[BDOrderViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"wallet" isEqualToString:model.key]) {
        BDWalletViewController *controller = [[BDWalletViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    else{
        [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:indexPath,@"indexPath", nil]];
    }

}
///自定义view创建
- (id)createViewWith:(HNYDetailItemModel*)item{
    return nil;
}


#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)loginNotifcation:(NSNotification*)fication{
    self.needRefresh = YES;
}

#pragma mark - 
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDLuckyDrawViewController class]]) {
        HNYDetailItemModel *pointsItem = [self.tableViewController getItemWithKey:@"points"];
        
        pointsItem.textValue = [NSString stringWithFormat:@"%d 积分",self.personModel.score];
        pointsItem.value = [NSNumber numberWithInt:self.personModel.score];
        [self.tableViewController changeViewAryObjectWith:pointsItem atIndex:[self.viewAry indexOfObject:pointsItem]];
        [self.tableViewController.tableView reloadData];
    }
}


#pragma mark - http request

- (void)getPersonInfo{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetPersonInfo];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetPersonInfo,HTTP_USER_INFO, nil];
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
        if ([ActionGetPersonInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSDictionary *value = [dictionary valueForKey:HTTP_VALUE];
            self.personModel = [HNYJSONUitls mappingDictionary:value toObjectWithClassName:@"BDPersonModel"];
            self.personModel.account = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ACCOUNT];
            
            if ([value isKindOfClass:[NSDictionary class]]) {
                HNYDetailItemModel *walletItem = [self.tableViewController getItemWithKey:@"wallet"];
                HNYDetailItemModel *pointsItem = [self.tableViewController getItemWithKey:@"points"];
                
                walletItem.textValue = [NSString stringWithFormat:@"￥%@",self.personModel.money];
                walletItem.value = self.personModel.money;
                
                pointsItem.textValue = [NSString stringWithFormat:@"%d 积分",self.personModel.score];
                pointsItem.value = [NSNumber numberWithInt:self.personModel.score];
                
                
                [self.tableViewController changeViewAryObjectWith:walletItem atIndex:[self.viewAry indexOfObject:walletItem]];
                [self.tableViewController changeViewAryObjectWith:pointsItem atIndex:[self.viewAry indexOfObject:pointsItem]];
                [self.tableViewController.tableView reloadData];
            }
            
        }
        else if ([ActionSavePersonImg isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionGetPersonInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }

    else{
        if ([ActionGetPersonInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
