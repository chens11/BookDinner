//
//  BDProductDetailViewController.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductDetailViewController.h"
#import "BDProductHeadView.h"
#import "BDProductDescriptionView.h"
#import "BDShoppingCartView.h"
#import "BDOrderDetailViewController.h"

@interface BDProductDetailViewController ()
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) BDShoppingCartView *cartView;
@property (nonatomic,strong) BDProductHeadView *headView;
@property (nonatomic,strong) BDProductDescriptionView *descriptionView;

@end

@implementation BDProductDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.products = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
    [self requestProduct];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - create subview
- (void)createSubView{
    
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    
    self.contentView = [[UIView alloc] init];
    [self.scroll addSubview:self.contentView];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.imgView];
    
    self.headView = [[BDProductHeadView alloc] init];
    self.headView.delegate = self;
    [self.contentView addSubview:self.headView];
    
    self.descriptionView = [[BDProductDescriptionView alloc] init];
    [self.contentView addSubview:self.descriptionView];
    
    self.cartView = [[BDShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    self.cartView.delegate = self;
    self.cartView.products = self.products;
    self.cartView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.cartView];
}

- (void)updateViewConstraints{
    
    [self.scroll mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(self.naviBar.frame.size.height);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroll);
        make.left.equalTo(self.scroll);
        make.width.equalTo(self.scroll);
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(200);
    }];
    
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(80);
    }];
    
    
    [self.descriptionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height);
    [super updateViewConstraints];
    
}

- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDShoppingCartView class]]) {
        
        BDOrderDetailViewController *controller = [[BDOrderDetailViewController alloc] init];
        controller.orderModel.product = self.cartView.products;
        controller.editAble = YES;
        controller.orderState = @"0";
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([aView isKindOfClass:[BDProductHeadView class]]) {
        
        
        if ([@"add" isEqualToString:[info valueForKey:@"action"]]) {
            self.product.number += 1;
            [self.cartView addProduct:self.product];
        }
        else if ([@"remove" isEqualToString:[info valueForKey:@"action"]]) {
            if (self.product.number == 0) {
                self.product.number = 0;
            }
            else{
                self.product.number -= 1;
                [self.cartView removeProduct:self.product];
            }
        }
        self.headView.numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.product.number];
    }

}


#pragma mark -  http request
- (void)requestProduct{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  [NSNumber numberWithInteger:self.product.ids],@"id",
                                  nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionProductDetail];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionProductDetail,HTTP_USER_INFO, nil];
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
        if ([KAPI_ActionProductDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            if ([[dictionary valueForKey:@"value"] isKindOfClass:[NSDictionary class]]) {
                [HNYJSONUitls mappingDictionary:[dictionary valueForKey:@"value"] toObject:self.product];
                [self.imgView setImageWithURL:[NSURL URLWithString:self.product.img]];
                self.headView.product = self.product;
                self.descriptionView.product = self.product;
                [self updateViewConstraints];
            }
        }
    }
    else{
        if ([KAPI_ActionProductDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            
        }
    }
}

@end
