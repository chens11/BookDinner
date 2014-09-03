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

@interface BDOrderViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;

@end

@implementation BDOrderViewController

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
    
    self.title = @"我的订单";
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.delegate = self;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
    for (int i = 0; i < 38 ; i++) {
        [self.tableController.list addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];
    }
    [self.tableController.tableView reloadData];
    
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
    return [self.tableController.list objectAtIndex:indexPath.row];
}


@end
