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
@property (nonatomic,strong) BDOrderTopView *topView;

@end

@implementation BDCouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.orderState = @"1";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTopView];
    [self createTable];
//    if (!self.selector) {
//        UIButton *defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        defaultBtn.frame = CGRectMake(15, self.view.frame.size.height - 50 , self.view.frame.size.width - 30, 40);
//        defaultBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//        defaultBtn.titleLabel.font = ButtonTitleFont;
//        [defaultBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
//        [defaultBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [defaultBtn addTarget:self action:@selector(touchLoginButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:defaultBtn];
//    }


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
//    HNYNaviBarItem *barItem = [HNYNaviBarItem initWithTitle:@"编辑" target:self action:@selector(touchDeleteBarItem:)];
//    self.naviBar.rightItems = [NSArray arrayWithObjects:barItem, nil];
}

- (void)createTopView{
    self.topView = [[BDOrderTopView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, 44)];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    //（0待付款，1已付款，2派送中，3成交，4失效）
    BDMenuModel *all = [[BDMenuModel alloc] init];
    all.title = @"全部";
    all.type = @"0,1,2,3,4";
    
    BDMenuModel *unPay = [[BDMenuModel alloc] init];
    unPay.title = @"待使用";
    unPay.type = @"1";
    
    BDMenuModel *used = [[BDMenuModel alloc] init];
    used.title = @"已使用";
    used.type = @"2";
    
    BDMenuModel *payed = [[BDMenuModel alloc] init];
    payed.title = @"已过期";
    payed.type = @"3";
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:unPay,used,payed, nil];
    self.topView.subMenuAry = array;
    self.topView.defaultSelectedIndex = 0;
}

- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height + self.topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.topView.frame.size.height);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 10;
    self.tableController.delegate = self;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
}
#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDOrderTopView class]]) {
        BDMenuModel *model = [info valueForKey:@"subMenuSelected"];
        self.orderState = model.type;
        [self.tableController.list removeAllObjects];
        [self getCouponList];
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
    }
    [cell configureCellWith:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selector) {
        BDCouponModel *model = [self.tableController.list objectAtIndex:indexPath.row];
        if (model.state == 2) {
            [self showTips:@"该优惠券已使用"];
            return;
        }
        else if (model.state == 3) {
            [self showTips:@"该优惠券过期"];
            return;
        }
        if (self.using == 0 && model.using == 1) {
            [self showTips:@"该订单不是赠送朋友不能使用朋友卷"];
        }
        else if (self.using == 1 && model.using == 0) {
            [self showTips:@"该订单不是赠送朋友只能使用朋友卷"];
        }
        else{
            [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:model,@"BDCouponModel", nil]];
            [self.customNaviController popViewControllerAnimated:YES];
        }
    }
    
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
    [self getCouponList];
    
}
//上拉Table View
-(void)pullUpTable{
    self.tableController.loadType = 1;
    self.tableController.pageNum += 1;
    [self getCouponList];
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}

#pragma mark - IBAction
- (void)touchLoginButton:(UIButton*)sender{
    
}
- (void)getCouponList{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:self.tableController.pageNum],@"pagenum",
                                  [NSNumber numberWithInt:self.tableController.pageSize],@"pagesize",
                                  [NSNumber numberWithInt:[self.orderState intValue]],@"state",
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionLuckyDrawList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionLuckyDrawList,HTTP_USER_INFO, nil];
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
        if ([ActionLuckyDrawList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            
            NSArray *value = [HNYJSONUitls mappingDicAry:[dictionary valueForKey:HTTP_VALUE] toObjectAryWithClassName:@"BDCouponModel"];
            [self.tableController doneRefresh];
            [self.tableController.list addObjectsFromArray:value];
            [self.tableController.tableView reloadData];
            if (value.count < self.tableController.pageSize)
                self.tableController.enbleFooterLoad = NO;
            else
                self.tableController.enbleFooterLoad = YES;
            
            if (self.tableController.list.count == 0)
                [self showTips:@"无优惠券"];
        }
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionLuckyDrawList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionLuckyDrawList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]])
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
    }
}

@end
