//
//  BDHomeViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDHomeViewController.h"
#import "BDProductModel.h"
#import "BDCategoryModel.h"
#import "BDProductCell.h"
#import "BDToolBar.h"
#import "BDShoppingCartView.h"
#import "BDOrderDetailViewController.h"
#import "BDProductDetailViewController.h"

@interface BDHomeViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) NSMutableArray *categorys;
@property (nonatomic,strong) NSMutableArray *products;
@property (nonatomic,strong) BDToolBar *topView;
@property (nonatomic,strong) BDShoppingCartView *cartView;
@property (nonatomic) int type_id;

@end

@implementation BDHomeViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        self.type_id = 0;
        self.products = [NSMutableArray array];
        self.categorys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    self.title = @"订餐";
    [self createCart];
    [self createTable];
    [self requestProductCategory];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.cartView updatePrice];
    [self.tableController.tableView reloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - draw subviews

- (void)createNaviBarItems{
    
    HNYNaviBarItem *leftBarItem = [HNYNaviBarItem initWithNormalImage:[UIImage imageNamed:@"button_menu"] downImage:[UIImage imageNamed:@"button_menu"] target:self action:@selector(touchLeftBarItem:)];
    self.naviBar.leftItems = [NSArray arrayWithObjects:leftBarItem, nil];
}

- (void)createTopView{
    self.topView = [[BDToolBar alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, 44)];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
}

- (void)createTable{
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height + self.topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.topView.frame.size.height - self.cartView.frame.size.height);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 10;
    self.tableController.delegate = self;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
}

- (void)createCart{
    self.cartView = [[BDShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    self.cartView.delegate = self;
    self.cartView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.cartView];
}
#pragma mark - IBAction
- (void)touchLeftBarItem:(UIBarButtonItem*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handleShowLeftNotification" object:nil];
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
    static NSString *cellIdentify = @"BDProductCell";
    BDProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    BDProductModel *model = [self.tableController.list objectAtIndex:indexPath.row];
    
    BDProductModel *buy = [self.cartView getProductByProductId:model.ids];
    if (buy) {
        model.number = buy.number;
    }
    else {
        model.number = 0;
    }
    [cell configureCellWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BDProductModel *model = [self.tableController.list objectAtIndex:indexPath.row];

    BDProductDetailViewController *controller = [[BDProductDetailViewController alloc] init];
    controller.product = model;
    controller.products = self.cartView.products;
    [self.customNaviController pushViewController:controller animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld", (long)indexPath.row);
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
    [self requestProductList];
    
}
//上拉Table View
-(void)pullUpTable{
    self.tableController.loadType = 1;
    self.tableController.pageNum += 1;
    [self requestProductList];
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - HNYDelegate

- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([[info valueForKey:@"PayResult"] boolValue]) {
        [self.cartView clearProoducts];
        [self.customNaviController popViewControllerAnimated:YES];
    }
}


- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDToolBar class]]) {
        BDMenuModel *model = [info valueForKey:@"subMenuSelected"];
        self.type_id = [model.type intValue];
        [self pullDownTable];
    }
    else if ([aView isKindOfClass:[BDProductCell class]]) {
        
        BDProductCell *cell = (BDProductCell*)aView;

        if ([@"add" isEqualToString:[info valueForKey:@"action"]]) {
            cell.productModel.number += 1;
            [self.cartView addProduct:cell.productModel];
        }
        else if ([@"remove" isEqualToString:[info valueForKey:@"action"]]) {
            if (cell.productModel.number == 0) {
                cell.productModel.number = 0;
            }
            else{
                cell.productModel.number -= 1;
                [self.cartView removeProduct:cell.productModel];
            }
        }
        if (cell.productModel.number == 0) {
            cell.numLabel.text = @"";
            cell.removeBtn.hidden = YES;
        }
        else{
            cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)cell.productModel.number];
            cell.removeBtn.hidden = NO;
        }

    }
    else if ([aView isKindOfClass:[BDShoppingCartView class]]) {
        
        BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
        controller.orderModel.product = self.cartView.products;
        controller.editAble = YES;
        controller.orderState = @"0";
        controller.delegate = self;
        [self.customNaviController pushViewController:controller animated:YES];
    }
}

#pragma mark - http request
- (void)requestProductCategory{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionProductsCategory];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionProductsCategory,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)requestProductList{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  @1,@"page",
                                  @20,@"list_number",
                                  [NSNumber numberWithInt:self.type_id],@"type_id",
                                  nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionProductsList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionProductsList,HTTP_USER_INFO, nil];
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
        if ([KAPI_ActionProductsCategory isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            if ([[dictionary valueForKey:@"value"] isKindOfClass:[NSDictionary class]]) {
                
                
                BDCategoryModel *model = [[BDCategoryModel alloc] init];
                model.ids = 0;
                model.name = @"全部";
                
                BDMenuModel *all = [[BDMenuModel alloc] init];
                all.orignalModel = model;
                all.title = model.name;
                all.type = [NSString stringWithFormat:@"%ld",(long)model.ids];
                [self.categorys addObject:all];

                for (NSDictionary *dic in [[dictionary valueForKey:@"value"] valueForKey:@"data"]) {
                    BDCategoryModel *category = [HNYJSONUitls mappingDictionary:dic toObjectWithClassName:@"BDCategoryModel"];
                    BDMenuModel *menu = [[BDMenuModel alloc] init];
                    menu.orignalModel = category;
                    menu.title = category.name;
                    menu.type = [NSString stringWithFormat:@"%ld",(long)category.ids];
                    [self.categorys addObject:menu];
                }
                
                self.topView.subMenuAry = self.categorys;
                self.topView.defaultSelectedIndex = 0;
                
            }
            [self requestProductList];
        }
        else if ([KAPI_ActionProductsList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            if ([[dictionary valueForKey:@"value"] isKindOfClass:[NSDictionary class]]) {
                NSArray *array = [HNYJSONUitls mappingDicAry:[[dictionary valueForKey:@"value"] valueForKey:@"data"] toObjectAryWithClassName:@"BDProductModel"];
                [self.tableController doneRefresh];
                [self.tableController.list addObjectsFromArray:array];
                [self.tableController.tableView reloadData];
                if (array.count < self.tableController.pageSize)
                    self.tableController.enbleFooterLoad = NO;
                else
                    self.tableController.enbleFooterLoad = YES;
                
                if (self.tableController.list.count == 0)
                    [self showTips:@"暂无数据"];
                
            }
        }
    }
    else{
        if ([KAPI_ActionProductsCategory isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self requestProductList];
            
        }
        else if ([KAPI_ActionProductsList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            
        }
        
    }
}

@end
