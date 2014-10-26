//
//  BDWalletViewController.m
//  BookDinner
//
//  Created by zqchen on 26/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDWalletViewController.h"
#import "BDRechargeTableViewCell.h"

@interface BDWalletViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HNYDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;


@end

@implementation BDWalletViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.title = @"充值记录";
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
- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height + 44, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - 44);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.delegate = self;
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 10;
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
    static NSString *cellIdentify = @"BDRechargeTableViewCell";
    BDRechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDRechargeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    [cell iniDataWithModel:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BDOrderModel *model = [self.tableController.list objectAtIndex:indexPath.row];
//    BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
//    controller.customNaviController = self.customNaviController;
//    controller.orderModel = model;
//    controller.editAble = NO;
//    controller.delegate = self;
//    controller.orderState = [NSString stringWithFormat:@"%d",model.state];
//    [self.customNaviController pushViewController:controller animated:YES];
    
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
    
}

#pragma mark - http request

- (void)getRechargeList{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:self.tableController.pageNum],@"pagenum",
                                  [NSNumber numberWithInt:self.tableController.pageSize],@"pagesize",
                                  @"0,1,2,3,4",@"state",
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
        if ([ActionGetPersonInfo isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
//            NSDictionary *value = [dictionary valueForKey:HTTP_VALUE];
//            self.personModel = [HNYJSONUitls mappingDictionary:value toObjectWithClassName:@"BDPersonModel"];
//            self.personModel.account = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ACCOUNT];
//            
//            if ([value isKindOfClass:[NSDictionary class]]) {
//                HNYDetailItemModel *walletItem = [self.tableViewController getItemWithKey:@"wallet"];
//                HNYDetailItemModel *pointsItem = [self.tableViewController getItemWithKey:@"points"];
//                
//                walletItem.textValue = [NSString stringWithFormat:@"￥%@",self.personModel.money];
//                walletItem.value = self.personModel.money;
//                
//                pointsItem.textValue = [NSString stringWithFormat:@"%d 积分",self.personModel.score];
//                pointsItem.value = [NSNumber numberWithInt:self.personModel.score];
//                
//                
//                [self.tableViewController changeViewAryObjectWith:walletItem atIndex:[self.viewAry indexOfObject:walletItem]];
//                [self.tableViewController changeViewAryObjectWith:pointsItem atIndex:[self.viewAry indexOfObject:pointsItem]];
//                [self.tableViewController.tableView reloadData];
//            }
            
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
