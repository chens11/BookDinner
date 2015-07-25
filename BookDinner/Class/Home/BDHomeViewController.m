//
//  BDHomeViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDHomeViewController.h"
#import "BDHomeDateView.h"
#import "BDLoginViewController.h"
#import "BDOrderDetailViewController.h"
#import "HNYActionSheet.h"
#import "BDProductsViewController.h"
#import "BDNewsViewController.h"

@interface BDHomeViewController ()<UIScrollViewDelegate,HNYActionSheetDelegate,
UIActionSheetDelegate>

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIButton *orderBtn;
@property (nonatomic,strong) UIScrollView *mScrollView;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) HNYActionSheet *sheet;
@property (nonatomic,strong) HNYTabBar *tabBar;
@property (nonatomic,strong) UINavigationController *contenNaviController;
@property (nonatomic,strong) BDProductsViewController *productsController;
@property (nonatomic,strong) BDNewsViewController *newsContoller;

@end

@implementation BDHomeViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getTodayRecommend)
                                                 name:KNotification_App_Did_Become_Active object:nil];
//    [self createScrollView];
//    [self createDateView];
//    [self getTodayRecommend];
    [self createTabBar];
    [self createContentNaviController];
    [self createTabBarItems];

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(self.view.frame.size.width - 55, self.view.frame.size.height - 200 , 40, 40);
//    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    [btn setImage:[UIImage imageNamed:@"button_info"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(touchInfoButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    
//    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 150 , self.view.frame.size.width - 30, 40)];
//    self.nameLabel.textAlignment = NSTextAlignmentCenter;
//    self.nameLabel.text = @"香辣猪扒饭";
//    self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    self.nameLabel.backgroundColor = [UIColor clearColor];
//    self.nameLabel.font = [UIFont systemFontOfSize:18.0];
//    [self.view addSubview:self.nameLabel];
//    
//    
//    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 110 , 80, 40)];
//    self.priceLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    self.priceLabel.backgroundColor = [UIColor clearColor];
//    self.priceLabel.text = @"￥30.0";
//    self.priceLabel.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:36/255.0 alpha:1.0];
//    self.priceLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
//    [self.view addSubview:self.priceLabel];
//    
//    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 110 , self.view.frame.size.width - 120, 40)];
//    self.numLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    self.numLabel.textAlignment = NSTextAlignmentRight;
//    self.numLabel.text = @"剩余10份";
//    self.numLabel.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:36/255.0 alpha:1.0];
//    self.numLabel.backgroundColor = [UIColor clearColor];
//    self.numLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
//    [self.view addSubview:self.numLabel];
//    
//    
//    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.orderBtn.frame = CGRectMake(15, self.view.frame.size.height - 55 , self.view.frame.size.width - 30, 40);
//    self.orderBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    self.orderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
//    self.orderBtn.enabled = NO;
//    [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_disable"] forState:UIControlStateDisabled];
//    [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
//    [self.orderBtn setTitle:@"订餐" forState:UIControlStateNormal];
//    [self.orderBtn addTarget:self action:@selector(touchOrderButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.orderBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mScrollView.contentSize = CGSizeMake(self.mScrollView.frame.size.width, self.mScrollView.frame.size.height);
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - create sub view
- (void)createTabBar{
    self.tabBar = [[HNYTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.tabBar];
}

- (void)createTabBarItems{
    HNYTabBarItem *productItem = [HNYTabBarItem initWithNormalImage:nil downImage:nil title:@"订餐" target:self action:@selector(touchTabBarItem:)];
    productItem.exTag = 0;
    
    HNYTabBarItem *newsItem = [HNYTabBarItem initWithNormalImage:nil downImage:nil title:@"资讯" target:self action:@selector(touchTabBarItem:)];
    newsItem.exTag = 1;
    
    self.tabBar.tabItemsAry = [NSArray arrayWithObjects:productItem,newsItem, nil];
    self.tabBar.defaultSelectedIndex = 0;
}
- (void)createContentNaviController{
    self.productsController = [[BDProductsViewController alloc] init];
    self.newsContoller = [[BDNewsViewController alloc] init];
    
    self.contenNaviController = [[UINavigationController alloc] init];
    self.contenNaviController.navigationBarHidden = YES;
    self.contenNaviController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.tabBar.frame.size.height);
    self.contenNaviController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contenNaviController.view];
    [self addChildViewController:self.contenNaviController];
}
- (void)createBgView{
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.bgImageView.image = [UIImage imageNamed:@"iconHomebg"];
    [self.view addSubview:self.bgImageView];
}

- (void)createDateView{
    BDHomeDateView *dateView = [[BDHomeDateView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    dateView.center = CGPointMake(self.view.frame.size.width - 50, 50);
    [self.view addSubview:dateView];

}
- (void)createNaviBar{
    
}

- (void)createScrollView{
    self.mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150 - self.naviBar.frame.size.height)];
    self.mScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.backgroundColor = [UIColor whiteColor];
    self.mScrollView.delegate = self;
    self.mScrollView.contentSize = CGSizeMake(self.mScrollView.frame.size.width * 1, self.mScrollView.frame.size.height);
    self.mScrollView.contentOffset = CGPointMake(0, 0);
    self.mScrollView.pagingEnabled = YES;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 70, self.view.frame.size.width, 20)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 4;
    self.pageControl.hidden = YES;
    
//    for (int i = 0; i < 1; i++) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.frame = CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height - 150);
//        [imageView setImage:[UIImage imageNamed:@"dinner"]];
//        [self.mScrollView addSubview:imageView];
//    }
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150 - self.naviBar.frame.size.height)];
    self.imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imgView setImage:[UIImage imageNamed:@"dinner"]];
    [self.mScrollView addSubview:self.imgView];

    [self.view addSubview:self.mScrollView];
    [self.view addSubview:self.pageControl];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.pageControl setCurrentPage:index];
}
#pragma mark - HNYDelegate

- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDPayViewController class]]) {
        if ([[info valueForKey:@"PayResult"] boolValue]) {
            [self.customNaviController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - ibaction
- (void)touchTabBarItem:(HNYTabBarItem*)barItem
{
    if (barItem.exTag == 0)
    {
        [self.contenNaviController setViewControllers:[NSArray arrayWithObject:self.productsController]];
    }
    else if (barItem.exTag == 1)
    {
        [self.contenNaviController setViewControllers:[NSArray arrayWithObject:self.newsContoller]];
    }
}
- (void)touchOrderButton:(UIButton*)sender{
    if(self.dinnerModel){
        BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
        controller.orderModel.product = self.dinnerModel;
        controller.editAble = YES;
        controller.orderState = @"0";
        controller.delegate = self;
        [self.customNaviController pushViewController:controller animated:YES];
        
    }
}
- (void)touchInfoButton:(UIButton*)sender{
    if (self.dinnerModel.description) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        CGSize size = [self.dinnerModel.description sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(self.view.frame.size.width, 2000) lineBreakMode:NSLineBreakByWordWrapping ];
        if (size.height > 200) {
            size.height = 200;
        }
        if (size.height < 100) {
            size.height = 120;
        }
        webView.frame = CGRectMake(0, 0, self.view.frame.size.width, size.height);
        [webView loadHTMLString:self.dinnerModel.description baseURL:nil];
        [HNYActionSheet showWithTitle:self.dinnerModel.title contentView:webView cancelBtnTitle:nil sureBtnTitle:nil delegate:self];
    }
}

#pragma mark - http request

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",dictionary);
    [self.hud removeFromSuperview];

    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
    }
    else{
    }
}

@end
