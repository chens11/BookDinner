//
//  BDCouponViewController.m
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDCouponViewController.h"

@interface BDCouponViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSString *orderState;

@end

@implementation BDCouponViewController

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
    
    self.title = @"我的优惠券";
    [self createTopView];
    [self createTable];
    UIButton *defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    defaultBtn.frame = CGRectMake(15, self.view.frame.size.height - 50 , self.view.frame.size.width - 30, 40);
    defaultBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    defaultBtn.titleLabel.font = ButtonTitleFont;
    [defaultBtn setBackgroundColor:ButtonNormalColor];
    [defaultBtn setTitle:@"删除" forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(touchLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:defaultBtn];


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
    unPay.title = @"待使用";
    unPay.type = @"0";
    
    BDMenuModel *used = [[BDMenuModel alloc] init];
    used.title = @"已使用";
    used.type = @"0";
    
    BDMenuModel *payed = [[BDMenuModel alloc] init];
    payed.title = @"已过期";
    payed.type = @"1";
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:all,unPay,used,payed, nil];
    topView.subMenuAry = array;
    topView.defaultSelectedIndex = 0;
}

- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height + 44, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - 65 - 44);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.view.backgroundColor = [UIColor clearColor];
    self.tableController.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableController.delegate = self;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
    for (int i = 0; i < 38 ; i++) {
        [self.tableController.list addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];
    }
    [self.tableController.tableView reloadData];
}
#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDOrderTopView class]]) {
        BDMenuModel *model = [info valueForKey:@"subMenuSelected"];
        self.orderState = model.type;
        [self.tableController.list removeAllObjects];
//        [self getCouponList];
    }

}

#pragma mark - IBAciton
- (void)touchDeleteBarItem:(UIBarButtonItem*)sender{
    
    if (self.tableController.tableView.isEditing) {
        [self.tableController.tableView setEditing:NO animated:YES];
    }
    else{
        [self.tableController.tableView setEditing:YES animated:YES];
    }
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
    return 95;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDCouponTableViewCell";
    BDCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell iniDataWithModel:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - HNYRefreshTableViewControllerDelegate
- (void)pullDownTable{
    [self.tableController.list removeAllObjects];
    [self.tableController.tableView reloadData];
    for (int i = 0; i < 20 ; i++) {
        [self.tableController.list addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];
    }
    self.tableController.headerIsUpdateing = NO;
    [self.tableController.tableView reloadData];
}

- (void)pullUpTable{
    for (int i = 0; i < 5 ; i++) {
        [self.tableController.list addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];
    }
    self.tableController.footerIsLoading = NO;
    [self.tableController.tableView reloadData];
    
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - IBAction
- (void)touchLoginButton:(UIButton*)sender{
    
}
- (void)getCouponList{
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
