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
                                                 name:NotificationAppDidBecomeActive object:nil];
    [self createScrollView];
    [self createDateView];
    [self getTodayRecommend];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width - 55, self.view.frame.size.height - 200 , 40, 40);
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [btn setImage:[UIImage imageNamed:@"button_info"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 150 , self.view.frame.size.width - 30, 40)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.text = @"香辣猪扒饭";
    self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:self.nameLabel];
    
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 110 , 80, 40)];
    self.priceLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.text = @"￥30.0";
    self.priceLabel.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:36/255.0 alpha:1.0];
    self.priceLabel.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:self.priceLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 110 , self.view.frame.size.width - 120, 40)];
    self.numLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.text = @"剩余10份";
    self.numLabel.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:36/255.0 alpha:1.0];
    self.numLabel.backgroundColor = [UIColor clearColor];
    self.numLabel.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:self.numLabel];
    
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBtn.frame = CGRectMake(15, self.view.frame.size.height - 55 , self.view.frame.size.width - 30, 40);
    self.orderBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.orderBtn.titleLabel.font = ButtonTitleFont;
    self.orderBtn.enabled = NO;
    [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_disable"] forState:UIControlStateDisabled];
    [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [self.orderBtn setTitle:@"订餐" forState:UIControlStateNormal];
    [self.orderBtn addTarget:self action:@selector(touchOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orderBtn];

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - create sub view
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

#pragma mark - ibaction
- (void)touchOrderButton:(UIButton*)sender{
    if(self.dinnerModel){
        BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
        controller.orderModel.product = self.dinnerModel;
        controller.customNaviController = self.customNaviController;
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
- (void)getTodayRecommend{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetTodayRecommend];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetTodayRecommend,HTTP_USER_INFO, nil];
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
        if ([ActionGetTodayRecommend isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            self.dinnerModel  = [HNYJSONUitls mappingDictionary:[dictionary valueForKey:@"value"] toObjectWithClassName:@"BDDinnerModel"];
            self.nameLabel.text = self.dinnerModel.title;
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.dinnerModel.money];
            self.numLabel.text = [NSString stringWithFormat:@"剩余%d份",self.dinnerModel.number];
            self.orderBtn.enabled = YES;
            NSURL *url = [NSURL URLWithString:self.dinnerModel.img];
            [self.imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dinner"]];
        }
    }
    else{
        if ([ActionGetTodayRecommend isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            self.orderBtn.enabled = NO;
//            [self showTips:@"获取今日推荐菜单失败"];
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
