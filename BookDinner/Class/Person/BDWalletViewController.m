//
//  BDWalletViewController.m
//  BookDinner
//
//  Created by zqchen on 26/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDWalletViewController.h"
#import "BDRechargeTableViewCell.h"
#import "BDPayViewController.h"
#import "BDLoginViewController.h"
#import "BDOrderTopView.h"
#import "HNYActionSheet.h"

@interface BDWalletViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HNYDelegate,HNYActionSheetDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSArray *moneyAry;
@property (nonatomic,strong) NSString *orderState;


@end

@implementation BDWalletViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.moneyAry = [NSArray arrayWithObjects:@"1",@"50",@"100",@"200",@"500",@"1000", nil];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"充值记录";
    [self createTopView];
    [self createTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNaviBarItems{
    [super createNaviBarItems];
    HNYNaviBarItem *barItem = [HNYNaviBarItem initWithTitle:@"充值" target:self action:@selector(touchAddRechargeBarItem:)];
    self.naviBar.rightItems = [NSArray arrayWithObjects:barItem, nil];
}
#pragma mark - create subview
- (void)createTopView{
    BDOrderTopView *topView = [[BDOrderTopView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, 44)];
    topView.delegate = self;
    [self.view addSubview:topView];
    //（0待付款，1已付款，2派送中，3成交，4失效）
    BDMenuModel *all = [[BDMenuModel alloc] init];
    all.title = @"全部";
    all.type = @"0,1,2,3,4";
    
    BDMenuModel *unPay = [[BDMenuModel alloc] init];
    unPay.title = @"待付款";
    unPay.type = @"0";
    
    BDMenuModel *payed = [[BDMenuModel alloc] init];
    payed.title = @"已付款";
    payed.type = @"1";
    
    BDMenuModel *sending = [[BDMenuModel alloc] init];
    sending.title = @"充值中";
    sending.type = @"2";
    
    BDMenuModel *done = [[BDMenuModel alloc] init];
    done.title = @"成交";
    done.type = @"3";
    
    BDMenuModel *out = [[BDMenuModel alloc] init];
    out.title = @"失效";
    out.type = @"4";
    NSMutableArray *array = [NSMutableArray arrayWithObjects:all,unPay,payed,sending,done,out, nil];
    topView.subMenuAry = array;
    topView.defaultSelectedIndex = 0;
}

- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height+44, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height-44);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.delegate = self;
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 20;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
}

#pragma mark - HNYActionSheetDelegate
// caled when select the String ary
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet didSelectStringAryAtIndex:(NSInteger)index{
    [actionSheet hide];
    if (actionSheet.tag == 100) {
        self.money = [self.moneyAry objectAtIndex:index];
        [self recharge];
    }
}


#pragma mark - IBAciton
- (void)touchDeleteBarItem:(UIBarButtonItem*)sender{
    self.tableController.tableView.editing = YES;
}


#pragma mark - UITableViewDataSource,UITableViewDelegate,UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableController scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableController.list.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDRechargeTableViewCell";
    BDRechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDRechargeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.delegate = self;
    [cell configureCellWith:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDOrderModel *model = [self.tableController.list objectAtIndex:indexPath.row];
    [self createPayViewController:model];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%d", indexPath.row);
        [self.tableController.list removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - HNYRefreshTableViewControllerDelegate
//下拉Table View
-(void)pullDownTable{
    [self.tableController.list removeAllObjects];
    [self.tableController.tableView reloadData];
    self.tableController.loadType = 0;
    self.tableController.pageNum = 1;
    self.tableController.enbleFooterLoad = YES;
    [self getRechargeList];
    
}
//上拉Table View
-(void)pullUpTable{
    self.tableController.loadType = 1;
    self.tableController.pageNum += 1;
    [self getRechargeList];
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - IBAction
- (void)touchAddRechargeBarItem:(HNYNaviBarItem*)item{
    HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择充值金额(元)"
                                            withStringAry:self.moneyAry
                                           cancelBtnTitle:nil
                                             sureBtnTitle:nil
                                                 delegate:self];
    sheet.tag = 100;
}

- (void)createPayViewController:(BDOrderModel*)model{
    model.pricemoney = model.money;
    model.type = 1;
    model.product = [[BDDinnerModel alloc] init];
    model.product.description = @"充值";
    model.title = @"充值";
    BDPayViewController *controller = [[BDPayViewController alloc] init];
    controller.orderModel = model;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDOrderTopView class]]) {
        BDMenuModel *model = [info valueForKey:@"subMenuSelected"];
        self.orderState = model.type;
        [self.tableController.list removeAllObjects];
        [self getRechargeList];
    }
    else if ([aView isKindOfClass:[BDRechargeTableViewCell class]]){
        NSIndexPath *indexPath = [self.tableController.tableView indexPathForCell:(UITableViewCell*)aView];
        BDOrderModel *model = [self.tableController.list objectAtIndex:indexPath.row];
        [self createPayViewController:model];
    }

}
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDPayViewController class]]) {
        if ([[info valueForKey:@"PayResult"] boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
            [self pullDownTable];
        }
    }
}

#pragma mark - http request

- (void)recharge{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:[self.money intValue]],@"money",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionRecharge];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionRecharge,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getRechargeList{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:self.tableController.pageNum],@"pagenum",
                                  [NSNumber numberWithInt:self.tableController.pageSize],@"pagesize",
                                  self.orderState,@"state",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetRechargeRecordList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetRechargeRecordList,HTTP_USER_INFO, nil];
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
        if ([ActionGetRechargeRecordList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *value = [HNYJSONUitls mappingDicAry:[dictionary valueForKey:HTTP_VALUE] toObjectAryWithClassName:@"BDOrderModel"];
            [self.tableController doneRefresh];
            [self.tableController.list addObjectsFromArray:value];
            [self.tableController.tableView reloadData];
            if (value.count < self.tableController.pageSize)
                self.tableController.enbleFooterLoad = NO;
            else
                self.tableController.enbleFooterLoad = YES;
            
            if (self.tableController.list.count == 0)
                [self showTips:@"无记录"];
        }
        else if ([ActionRecharge isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            NSDictionary *value = [dictionary valueForKey:@"value"];
            if ([value isKindOfClass:[NSDictionary class]]) {
                BDOrderModel *model = [[BDOrderModel alloc] init];
                model.money = self.money;
                model.id = [[value valueForKey:@"id"] intValue];
                [self createPayViewController:model];
            }

        }
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionGetRechargeRecordList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    
    else{
        if ([ActionRecharge isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}


@end
