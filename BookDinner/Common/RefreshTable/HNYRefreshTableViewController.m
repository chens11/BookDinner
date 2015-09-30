//
//  HNYRefreshTableViewController.m
//  Demo
//
//  Created by zqchen on 13/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYRefreshTableViewController.h"
#import "HNYPopoverView.h"

@interface HNYRefreshTableViewController ()<HNYPopoverViewDelegate>
@property (nonatomic,strong) HNYPopoverView *longPressPopover;
@property (nonatomic,strong) NSIndexPath *popIndexPath;
//@property (nonatomic,strong) PopoverView *popoverView;
@property (nonatomic) UIEdgeInsets edggeInsets;
@end

@implementation HNYRefreshTableViewController
@synthesize enbleFooterLoad = _enbleFooterLoad;
@synthesize enbleHeaderRefresh = _enbleHeaderRefresh;
@synthesize delegate = _delegate;
@synthesize updateFooterView = _updateFooterView;
@synthesize updateHeaderView = _updateHeaderView;
@synthesize longPressGesture = _longPressGesture;
@synthesize list = _list;
@synthesize pageSize = _pageSize;
@synthesize pageNum = _pageNum;
@synthesize loadType = _loadType;
@synthesize headerIsUpdateing = _headerIsUpdateing;
@synthesize footerIsLoading = _footerIsLoading;
@synthesize longPressPopover = _longPressPopover;
@synthesize popIndexPath = _popIndexPath;
//@synthesize popoverView = _popoverView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.enbleHeaderRefresh = YES;
        self.enbleFooterLoad = YES;
        self.pageNum = 1;
        self.pageSize = 20;
        self.loadType = 0;
        self.headerIsUpdateing = NO;
        self.footerIsLoading = NO;
        self.list = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUpdateView];
    self.longPressGesture= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.tableView addGestureRecognizer:self.longPressGesture];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.edggeInsets = self.tableView.contentInset;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create update footer and header view
- (void)createUpdateView{
    CGRect rect = self.view.frame;
    self.updateHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                             CGRectMake(0, -50, rect.size.width, 50)];
    self.updateHeaderView.delegate = self;
    [self.updateHeaderView refreshLastUpdatedDate];
    self.updateHeaderView.hidden = YES;
    [self.tableView addSubview:self.updateHeaderView];
    
    self.updateFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                             CGRectMake(0, 0, rect.size.width, 50)];
    self.updateFooterView.delegate = self;
    self.updateFooterView.hidden = YES;
    [self.updateFooterView refreshLastUpdatedDate];
    [self.tableView addSubview:self.updateFooterView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.updateFooterView.frame = CGRectMake(0, scrollView.contentSize.height, scrollView.frame.size.width, 50);
    if (scrollView.contentSize.height < scrollView.frame.size.height)
        self.updateFooterView.frame = CGRectMake(0, scrollView.frame.size.height, scrollView.frame.size.width, 50);
    if ( scrollView.contentOffset.y < 0 && self.enbleHeaderRefresh) {
        //下拉刷新
        self.updateHeaderView.hidden = NO;
        [self.updateHeaderView egoRefreshScrollViewDidScroll:scrollView];
        NSLog(@"scrollViewDidScroll");
    }
    else if ((scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) && self.enbleFooterLoad){
        self.updateFooterView.hidden = NO;
        [self.updateFooterView egoRefreshScrollViewDidScroll:scrollView];
        NSLog(@"scrollViewDidScroll");
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
	if (scrollView.contentOffset.y < 0 && self.enbleHeaderRefresh){
        self.updateHeaderView.hidden = NO;
        [self.updateHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
    else if ((scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) && self.enbleFooterLoad){
        self.updateFooterView.hidden = NO;
        [self.updateFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row = %ld@",(long)indexPath.row];
    // Configure the cell...
    
    return cell;
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    self.headerIsUpdateing = YES;
    if ([self.delegate respondsToSelector:@selector(pullDownTable)]) {
        [self.delegate pullDownTable];
    }
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return self.headerIsUpdateing;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}
#pragma mark -  EGORefreshTableFooterDelegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view{
    self.footerIsLoading = YES;
    if ([self.delegate respondsToSelector:@selector(pullUpTable)]) {
        [self.delegate pullUpTable];
    }
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return self.footerIsLoading;
}

- (NSDate *)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView *)view{
    return [NSDate date];
}

#pragma mark - longPressGesture
- (void)longPressGesture:(UIGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![indexPath isEqual: self.popIndexPath] && cell) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            [self.longPressPopover dismissPopoverAnimated:YES];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            NSString *mainDescripiton;
            if ([self.delegate respondsToSelector:@selector(descriptionOfTableCellAtIndexPath:)])
                mainDescripiton = [self.delegate descriptionOfTableCellAtIndexPath:indexPath];
            if (mainDescripiton != nil && mainDescripiton.length != 0) {
                self.longPressPopover = [HNYPopoverView presentPopoverFromRect:cell.frame inView:self.view withText:mainDescripiton delegate:self];//[PopoverView showPopoverAtPoint:point inView:self.view withText:mainDescripiton delegate:self];
            }
        }
        self.popIndexPath = indexPath;
    }
    if (gesture.state == UIGestureRecognizerStateEnded)
        self.popIndexPath = nil;
}

#pragma mark - instance fun
- (void)addObjectsFromAry:(NSArray *)array{
    if (self.loadType == 0)
        [self.list removeAllObjects];
    [self.list addObjectsFromArray:array];
    [self.tableView reloadData];
    
}

- (void)setHeaderIsUpdateing:(BOOL)headerIsUpdateing{
    _headerIsUpdateing = headerIsUpdateing;
    if (!headerIsUpdateing){
        [self.updateHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView withEdgeInsets:self.edggeInsets];
        self.updateHeaderView.hidden = YES;
    }
}

- (void)setFooterIsLoading:(BOOL)footerIsLoading{
    _footerIsLoading = footerIsLoading;
    if (!footerIsLoading){
        [self.updateFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView scrollFooterBack:YES withEdgeInsets:self.edggeInsets];
        self.updateFooterView.hidden = YES;
    }

}
- (void)setEnbleFooterLoad:(BOOL)enbleFooterLoad{
    _enbleFooterLoad = enbleFooterLoad;
    if (!enbleFooterLoad)
        self.updateFooterView.hidden = YES;
}

- (void)setEnbleHeaderRefresh:(BOOL)enbleHeaderRefresh{
    _enbleHeaderRefresh = enbleHeaderRefresh;
    if (!enbleHeaderRefresh)
        self.updateFooterView.hidden = YES;
}

- (void)doneRefresh{
    if (self.loadType == 0)
        self.headerIsUpdateing = NO;
    else
        self.footerIsLoading = NO;
}

#pragma mark - PopoverViewDelegate
- (void)hNYPopoverViewWillDismissPopover:(HNYPopoverView *)popover{
    
}

- (void)hNYPopoverViewDidDismissPopover:(HNYPopoverView *)popover{
    [self.tableView deselectRowAtIndexPath:self.popIndexPath animated:YES];
}
@end
