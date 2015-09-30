//
//  HNYTTableViewController.m
//  Demo
//
//  Created by zqchen on 26/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTRefreshTableViewController.h"
#import "HNYRefreshTableViewController.h"

@interface HNYTRefreshTableViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;

@end

@implementation HNYTRefreshTableViewController

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
    
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"HNYTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [self.tableController.list objectAtIndex:indexPath.row];
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

@end
