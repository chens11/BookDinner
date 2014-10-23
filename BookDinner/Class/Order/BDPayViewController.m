//
//  BDPayViewController.m
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPayViewController.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"

@interface BDPayViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HNYDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *orderState;
@property (nonatomic, retain) NSString *subject;

@end

@implementation BDPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付方式";
    [self createTable];
    self.result = @selector(paymentResult:);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
#if ! __has_feature(objc_arc)
    [_products release];
    [super dealloc];
#endif
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    if (result)
    {
        
        if (result.statusCode == 9000)
        {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
            }
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

#pragma mark - UITableViewDataSource,UITableViewDelegate,UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableController scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
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
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"在线支付: ￥1",@"title", nil];
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
    [cell iniDataWithModel:dictionary];
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
        NSString* orderInfo = [self getOrderInfo:indexPath.row];
        NSString* signedStr = [self doRsa:orderInfo];
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        NSLog(@"result = %@",orderString);
        [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
    }
    
}

-(NSString*)getOrderInfo:(NSInteger)index
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
/*
 
 
partner="2088101568358171"&seller_id="alipay-test09@alipay.com"&out_trade_no="0819145412-6177"&subject="《暗黑破坏神3:凯恩之书》"&body="暴雪唯一官方授权中文版!玩家必藏!附赠暗黑精致手绘地图!绝不仅仅是一本暗黑的故事或画册，而是一个栩栩如生的游戏再现。是游戏玩家珍藏的首选。"&total_fee="0.01"&notify_url="http%3A%2F%2Fnotify.msp.hk%2Fnotify.htm"&service="mobile.securitypay.pay"&payment_type="1"&_input_charset="utf-8"&it_b_pay="30m"&show_url="m.alipay.com"&sign="lBBK%2F0w5LOajrMrji7DUgEqNjIhQbidR13GovA5r3TgIbNqv231yC1NksLdw%2Ba3JnfHXoXuet6XNNHtn7VE%2BeCoRO1O%2BR1KugLrQEZMtG5jmJIe2pbjm%2F3kb%2FuGkpG%2BwYQYI51%2BhA3YBbvZHVQBYveBqK%2Bh8mUyb7GM1HxWs9k4%3D"&sign_type="RSA"
 
 */
    order.tradeNO = [NSString stringWithFormat:@"%@",@"0819145412-6177"];//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = self.orderModel.title; //商品标题
    order.productDescription = @"ddd";//self.orderModel.description; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[self.orderModel.pricemoney floatValue]]; //商品价格
    order.notifyURL =  @"http%3A%2F%2Fnotify.msp.hk%2Fnotify.htm"; //回调URL
    
    return [order description];
}

- (NSString *)generateTradeNO
{
    const int N = 15;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand(time(0));
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"%@",result);
}


#pragma mark - HNYRefreshTableViewControllerDelegate
//下拉Table View
-(void)pullDownTable{
    
}
//上拉Table View
-(void)pullUpTable{
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
}

#pragma mark - http request
- (void)getPayDetail{
    [self showRequestingTips:nil];
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
//                                  [NSNumber numberWithInt:self.orderModel.id],@"id",
//                                  [AppInfo headInfo],HTTP_HEAD,nil];
//    
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetOrderDetail];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"url = %@ \n param = %@",urlString,param);
//    
//    NSString *jsonString = [param JSONRepresentation];
//    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
//    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetOrderDetail,HTTP_USER_INFO, nil];
//    [formRequest appendPostData:data];
//    [formRequest setDelegate:self];
//    [formRequest startAsynchronous];

}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",string);
    [self.hud removeFromSuperview];
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSArray class]] && value.count > 0) {
            }
        }
        else if ([ActionGetOrderDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            
        }
        
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
    }
    else{
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
