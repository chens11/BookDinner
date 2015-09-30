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
    [cell configureCellWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDCodeModel *model  = [self.dataAry objectAtIndex:indexPath.row];
    if (model.type == 0) {
        
        if (model.hasSons && !model.expanded && model.sons.count == 0) {
            [self getAddressCityWith:model];
        }
        else if (model.hasSons > 0 && !model.expanded && model.sons.count > 0) {
            [self expandDepartmentWith:model];
        }
        
        else if (model.expanded){
            model.expanded = NO;
            [self unExpandDepartmentWith:model];
        }

//        if (model.hasSons && model.sons.count == 0) {
//            [self getAddressCityWith:model];
//        }
    }
    else if (model.type == 1) {
        if (model.hasSons && !model.expanded && model.sons.count == 0) {
            [self getAddressBlockWith:model];
        }
        else if (model.hasSons > 0 && !model.expanded && model.sons.count > 0) {
            [self expandDepartmentWith:model];
        }
        
        else if (model.expanded){
            model.expanded = NO;
            [self unExpandDepartmentWith:model];
        }

//        if (model.hasSons && model.sons.count == 0) {
//            [self getAddressBlockWith:model];
//        }
    }
    else if (model.type == 2) {
        self.addressModel.province = model.parentCode.parentCode.name;
        self.addressModel.city = model.parentCode.name;
        self.addressModel.area = model.name;
        
        [self.delegate viewController:self
                       actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel,@"BDAddressModel", nil]];
        [self.navigationController popViewControllerAnimated:YES];
    }
//    else if (model.type == 3){
//        self.addressModel.street = model;
//        [self.delegate viewController:self
//                       actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel,@"BDAddressModel", nil]];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
#pragma mark - instance fun
//收起操作
- (void)unExpandDepartmentWith:(BDCodeModel*)model{
    for (BDCodeModel *subModel in model.sons) {
        if (subModel.expanded) {
            [self unExpandDepartmentWith:subModel];
        }
    }
    [self.dataAry removeObjectsInArray:model.sons];
    
    NSInteger index = [self.dataAry indexOfObject:model];
    //展开table 动画
    NSMutableArray *insers = [NSMutableArray array];
    for (int i = 1; i < model.sons.count + 1; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
        [insers addObject:indexPath];
    }
    [self.table deleteRowsAtIndexPaths:insers withRowAnimation:UITableViewRowAnimationAutomatic];
}
//展开操作
- (void)expandDepartmentWith:(BDCodeModel*)model{
    model.expanded = YES;
    
    //添加数据到table
    NSInteger index = [self.dataAry indexOfObject:model];
    NSRange range = NSMakeRange(index + 1, model.sons.count);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.dataAry insertObjects:model.sons atIndexes:indexSet];
    
    //展开table 动画
    NSMutableArray *insers = [NSMutableArray array];
    for (int i = 1; i < model.sons.count + 1; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
        [insers addObject:indexPath];
    }
    [self.table insertRowsAtIndexPaths:insers withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    for (BDCodeModel *subModel in model.sons) {
        if (subModel.expanded) {
            [self expandDepartmentWith:subModel];
        }
    }
}


#pragma mark - http request
- (void)getAddressStreetWith:(BDCodeModel*)model{
    [self showRequestingTips:nil];
    self.requestingModel = model;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:model.code],@"code",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetAddressStreet];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetAddressStreet,HTTP_USER_INFO, nil];
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetAddressBlock];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetAddressBlock,HTTP_USER_INFO, nil];
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetAddressCity];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetAddressCity,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getAddressProvince{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetAddressProvince];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@",urlString);
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetAddressProvince,HTTP_USER_INFO, nil];
    [formRequest setDelegate:self];
    [formRequest appendPostData:data];
    [formRequest startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    [self.hud removeFromSuperview];
    NSLog(@"result = %@",dictionary);
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([KAPI_ActionGetAddressProvince isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 0;
                model.expanded = NO;
                model.expandLevel = 0;
                model.parentCode = nil;
                model.hasSons = YES;
                [self.dataAry addObject:model];
            }
            [self.table reloadData];
        }
        else if ([KAPI_ActionGetAddressCity isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            NSMutableArray *sons = [NSMutableArray array];
            int index = [self.dataAry indexOfObject:self.requestingModel];

            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 1;
                model.parentCode = self.requestingModel;
                model.hasSons = YES;
                model.expanded = NO;
                model.expandLevel = self.requestingModel.expandLevel + 1;
                index ++;
                [self.dataAry insertObject:model atIndex:index];
                [sons addObject:model];
            }
            self.requestingModel.sons = sons;
            self.requestingModel.expanded = YES;
            [self.table reloadData];
        }
        else if ([KAPI_ActionGetAddressBlock isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            NSMutableArray *sons = [NSMutableArray array];
            int index = [self.dataAry indexOfObject:self.requestingModel];
            
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 2;
                model.expandLevel = self.requestingModel.expandLevel + 1;
                model.expanded = NO;
                model.parentCode = self.requestingModel;
                model.hasSons = NO;
                index ++;
                [self.dataAry insertObject:model atIndex:index];
                [sons addObject:model];
            }
            self.requestingModel.sons = sons;
            self.requestingModel.expanded = YES;
            [self.table reloadData];
        }
        else if ([KAPI_ActionGetAddressStreet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *list = [dictionary valueForKey:HTTP_VALUE];
            for (NSDictionary *codeDic in list) {
                BDCodeModel *model = [HNYJSONUitls mappingDictionary:codeDic toObjectWithClassName:@"BDCodeModel"];
                model.type = 3;
                model.parentCode = nil;
                model.hasSons = NO;
                model.expandLevel = 0;
                [self.dataAry addObject:model];
            }
            if (self.dataAry.count == 0) {
                [self showTips:@"无街道数据"];
            }
            [self.table reloadData];
        }

    }
    else{
        if ([KAPI_ActionGetAddressProvince isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([KAPI_ActionGetAddressCity isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([KAPI_ActionGetAddressBlock isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([KAPI_ActionGetAddressStreet isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
