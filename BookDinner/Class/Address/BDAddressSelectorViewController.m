//
//  BDAddressSelectorViewController.m
//  BookDinner
//
//  Created by zqchen on 28/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAddressSelectorViewController.h"
#import "BDAddressSelectorTableViewCell.h"

@interface BDAddressSelectorViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) BDCodeModel *requestingModel;
@property (nonatomic,strong) NSMutableArray *dataAry;

@end

@implementation BDAddressSelectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataAry = [NSMutableArray array];
        self.addressModel = [[BDAddressModel alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height) style:UITableViewStylePlain];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];
    if (self.getStreet)
        [self getAddressStreetWith:self.addressModel.district];
    else
        [self getAddressProvince];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"BDAddressSelectorTableViewCell";
    BDAddressSelectorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[BDAddressSelectorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    BDCodeModel *model  = [self.dataAry objectAtIndex:indexPath.row];
    [cell iniDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDCodeModel *model  = [self.dataAry objectAtIndex:indexPath.row];
    if (model.type == 0) {
        if (model.hasSons && model.sons.count == 0) {
            [self getAddressCityWith:model];
        }
    }
    else if (model.type == 1) {
        if (model.hasSons && model.sons.count == 0) {
            [self getAddressBlockWith:model];
        }
    }
    else if (model.type == 2) {
        self.addressModel.prorince = model.parentCode.parentCode;
        self.addressModel.city = model.parentCode;
        self.addressModel.district = model;
        
        [self.delegate viewController:self
                       actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel,@"BDAddressModel", nil]];
        [self.customNaviController popViewControllerAnimated:YES];
    }
    else if (model.type == 3){
        self.addressModel.street = model;
        [self.delegate viewController:self
                       actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel,@"BDAddressModel", nil]];
        [self.customNaviController popViewControllerAnimated:YES];
    }
}

#pragma mark - http request
- (void)getAddressStreetWith:(BDCodeModel*)model{
    [self showRequestingTips:nil];
    self.requestingModel = model;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:model.code],@"code",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressStreet];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressStreet,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getAddressBlockWith:(BDCodeModel*)model{
    [self showRequestingTips:nil];
    self.requestingModel = model;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:model.code],@"code",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressBlock];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressBlock,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getAddressCityWith:(BDCodeModel*)model{
    [self showRequestingTips:nil];
    self.requestingModel = model;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:model.code],@"code",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressCity];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressCity,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getAddressProvince{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressProvince];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@@",urlString);
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressProvince,HTTP_USER_INFO, nil];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    [self.hud removeFromSuperview];
    NSLog(@"result = %@",string);
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionGetAddressProvince isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 0;
                model.parentCode = nil;
                model.hasSons = YES;
                [self.dataAry addObject:model];
            }
            [self.table reloadData];
        }
        else if ([ActionGetAddressCity isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            NSMutableArray *sons = [NSMutableArray array];
            int index = [self.dataAry indexOfObject:self.requestingModel];

            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 1;
                model.parentCode = self.requestingModel;
                model.hasSons = YES;
                index ++;
                [self.dataAry insertObject:model atIndex:index];
                [sons addObject:model];
            }
            self.requestingModel.sons = sons;
            [self.table reloadData];
        }
        else if ([ActionGetAddressBlock isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            NSMutableArray *sons = [NSMutableArray array];
            int index = [self.dataAry indexOfObject:self.requestingModel];
            
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 2;
                model.parentCode = self.requestingModel;
                model.hasSons = NO;
                index ++;
                [self.dataAry insertObject:model atIndex:index];
                [sons addObject:model];
            }
            self.requestingModel.sons = sons;
            [self.table reloadData];
        }
        else if ([ActionGetAddressStreet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 3;
                model.parentCode = nil;
                model.hasSons = NO;
                [self.dataAry addObject:model];
            }
            if (self.dataAry.count == 0) {
                [self showTips:@"无街道数据"];
            }
            [self.table reloadData];
        }

    }
    else{
        if ([ActionGetAddressProvince isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionGetAddressCity isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionGetAddressBlock isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionGetAddressStreet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
