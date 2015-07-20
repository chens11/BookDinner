//
//  BDAddressViewController.m
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAddressViewController.h"
#import "BDAddressTableViewCell.h"
#import "BDAddressDetailViewController.h"

@interface BDAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *menuAry;

@end

@implementation BDAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuAry = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self getAddressList];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create subview
- (void)createTableView{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height) style:UITableViewStylePlain];
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];
}
- (void)createNaviBarItems{
    [super createNaviBarItems];
    HNYNaviBarItem *barItem = [HNYNaviBarItem initWithNormalImage:[UIImage imageNamed:@"atc_tagedit"] downImage:[UIImage imageNamed:@"atc_tagedit"] target:self action:@selector(touchAddBarItem:)];
    self.naviBar.rightItems = [NSArray arrayWithObjects:barItem, nil];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UITableViewCell";
    BDAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.tag = indexPath.row;
    [cell iniDataWithModel:[self.menuAry objectAtIndex:indexPath.row]];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selector) {
        BDAddressModel *model = [self.menuAry objectAtIndex:indexPath.row];
        [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:model,@"BDAddressModel", nil]];
        [self.customNaviController popViewControllerAnimated:YES];
    }else{
        BDAddressDetailViewController *controller = [[BDAddressDetailViewController alloc] init];
        controller.delegate = self;
        controller.addressModel = [self.menuAry objectAtIndex:indexPath.row];
        controller.customNaviController  = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
    }
}

#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}


#pragma mark - IBAciton
- (void)touchAddBarItem:(UIBarButtonItem*)sender{
    
    BDAddressDetailViewController *controller = [[BDAddressDetailViewController alloc] init];
    controller.isAddAddress = YES;
    controller.delegate = self;
    if (self.menuAry.count == 0)
        controller.isDefault = YES;
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}

#pragma mark - http request

- (void)getAddressList{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressList,HTTP_USER_INFO, nil];
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
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self.menuAry removeAllObjects];
            NSArray *value = [dictionary valueForKey:HTTP_VALUE];
            self.menuAry = [HNYJSONUitls mappingDicAry:value toObjectAryWithClassName:@"BDAddressModel"];
            [self.table reloadData];
        }
    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

#pragma mark - HNYDelegate
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDAddressDetailViewController class]]) {
        if ([@"RefreshTable" isEqualToString:[info valueForKey:@"action"]]) {
            [self getAddressList];
        }
    }
}
@end
