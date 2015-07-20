//
//  BDPayViewController.m
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPayViewController.h"

@interface BDPayViewController ()<UITableViewDataSource,UITableViewDelegate,HNYDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *orderState;
@property (nonatomic,retain) NSString *subject;

@end

@implementation BDPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.result = @selector(paymentResult:);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(payNotifcation:)
                                                     name:KNotification_Pay_Sucess object:nil];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付方式";
    [self createTable];
    if (self.orderModel.type == 0)
        [self getPayDetail];
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

#pragma mark - - (void)createTable{
- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, 220);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.enbleFooterLoad = NO;
    self.tableController.enbleHeaderRefresh = NO;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (self.orderModel.type == 1) {
        return 2;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }
    return 45.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDOrderTableViewCell";
    BDPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dictionary;
    cell.tag = indexPath.row;
    if (indexPath.section == 0) {
        NSString *title = [NSString stringWithFormat:@"在线支付: ￥%.2f",[self.orderModel.pricemoney floatValue]];
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title", nil];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if (indexPath.row == 0){
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"微信支付",@"title",@"持有微信账号的用户使用",@"content", nil];
    }
    else if (indexPath.row == 1){
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"支付宝支付",@"title",@"持有支付宝账号的用户使用",@"content", nil];
    }
    else if (indexPath.row == 2){
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"我的钱包支付",@"title",@"钱包余额充足可使用",@"content", nil];
    }
    [cell configureCellWith:dictionary];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     *生成订单信息及签名
     *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
     */
    
    if (indexPath.row == 1) {
        NSString *appScheme = @"ihomy2014";
        NSString* orderInfo = [BDAlixpay getOrderInfo:self.orderModel];
        NSString* signedStr = [BDAlixpay doRsa:orderInfo];
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        NSLog(@"result = %@",orderString);
        [AlixLibService payOrder:orderString AndScheme:appScheme seletor:self.result target:self];
    }
    else if (indexPath.row == 2){
        [self payByMyWallet];
    }
    
}




#pragma mark -
#pragma mark - alipay

-(void)paymentResultDelegate:(NSString *)result{
    NSLog(@"%@",result);
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd{
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
    if (result){
        if (result.statusCode == 9000){
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Pay_Sucess object:nil userInfo:nil ];

//            if ([verifier verifyString:result.resultString withSign:result.signString]){
//                //验证签名成功，交易结果无篡改
//            }
        }
        else{
            //交易失败
        }
    }
    else{
        //失败
    }
}
#pragma mark - NSNoticefication
- (void)payNotifcation:(NSNotification*)fication{
    [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"PayResult", nil]];
}

#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
}

#pragma mark - http request
- (void)payByMyWallet{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:self.orderModel.id],@"id",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionPayByWallet];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionPayByWallet,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getPayDetail{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:self.orderModel.id],@"id",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetOrderDetail];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetOrderDetail,HTTP_USER_INFO, nil];
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
        if ([KAPI_ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSArray class]] && value.count > 0) {
            }
        }
        else if ([KAPI_ActionGetOrderDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSDictionary *value = [dictionary valueForKey:@"value"];
            if ([value isKindOfClass:[NSDictionary class]]) {
                [HNYJSONUitls mappingDictionary:value toObject:self.orderModel];
                [self.tableController.tableView reloadData];
            }
        }
        
        else if ([KAPI_ActionPayByWallet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(payNotifcation:) withObject:nil afterDelay:1];
        }
        
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
    }
    else{
        if ([KAPI_ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        if ([KAPI_ActionPayByWallet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
