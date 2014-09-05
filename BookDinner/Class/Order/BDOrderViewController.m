//
//  BDOrderViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderViewController.h"
#import "BDOrderTableViewCell.h"
#import "BDOrderDetailViewController.h"
#import "BDOrderTopView.h"

@interface BDOrderViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HNYDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *orderState;

@end

@implementation BDOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.orderState = @"0,1,2,3,4";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的订单";
    [self createTopView];
    [self createTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create subview
- (void)createNaviBarItems{
    [super createNaviBarItems];
    HNYNaviBarItem *barItem = [HNYNaviBarItem initWithTitle:@"编辑" target:self action:@selector(touchDeleteBarItem:)];
    self.naviBar.rightItems = [NSArray arrayWithObjects:barItem, nil];
}

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
    sending.title = @"派送中";
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
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height + 44, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - 44);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.delegate = self;
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 5;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
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
    return 150.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDOrderTableViewCell";
    BDOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    [cell iniDataWithModel:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];

}

#pragma mark - HNYRefreshTableViewControllerDelegate
//下拉Table View
-(void)pullDownTable{
    [self.tableController.list removeAllObjects];
    [self.tableController.tableView reloadData];
    self.tableController.loadType = 0;
    self.tableController.pageNum = 1;
    self.tableController.enbleFooterLoad = YES;
    [self getOrderList];
    
}
//上拉Table View
-(void)pullUpTable{
    self.tableController.loadType = 1;
    self.tableController.pageNum += 1;
    [self getOrderList];
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDOrderTopView class]]) {
        BDMenuModel *model = [info valueForKey:@"subMenuSelected"];
        self.orderState = model.type;
        [self.tableController.list removeAllObjects];
        [self getOrderList];
    }
}

#pragma mark - http request

- (void)getOrderList{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:self.tableController.pageNum],@"pagenum",
                                  [NSNumber numberWithInt:self.tableController.pageSize],@"pagesize",
                                  self.orderState,@"state",
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetOrderList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetOrderList,HTTP_USER_INFO, nil];
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
        if ([ActionGetOrderList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {

            NSArray *value = [HNYJSONUitls mappingDicAry:[dictionary valueForKey:HTTP_VALUE] toObjectAryWithClassName:@"BDOrderModel"];
            [self.tableController doneRefresh];
            [self.tableController.list addObjectsFromArray:value];
            [self.tableController.tableView reloadData];
            if (value.count < self.tableController.pageSize)
                self.tableController.enbleFooterLoad = NO;
            else
                self.tableController.enbleFooterLoad = YES;
            
            if (self.tableController.list.count == 0)
                [self showTips:@"无订单"];
        }
    }
    
    else{
        if ([ActionGetOrderList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]])
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
    }
}

@end
