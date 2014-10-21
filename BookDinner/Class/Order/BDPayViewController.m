//
//  BDPayViewController.m
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPayViewController.h"

@interface BDPayViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HNYDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *orderState;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        if ([ActionPlaceOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionGetOrderDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
