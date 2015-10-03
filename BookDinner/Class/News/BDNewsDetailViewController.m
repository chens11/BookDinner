//
//  BDNewsDetailViewController.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDNewsDetailViewController.h"

@interface BDNewsDetailViewController ()
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation BDNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
    [self requestNew];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)createSubView{
    
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    
    self.contentView = [[UIView alloc] init];
    [self.scroll addSubview:self.contentView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.imgView];


    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.font = [UIFont systemFontOfSize:15];
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.detailLabel];
    
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
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        
    }];
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(200);
    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height);
    [super updateViewConstraints];
    
}

#pragma mark -  http request
- (void)requestNew{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [AppInfo headInfo],HTTP_HEAD,
                                  [NSNumber numberWithInteger:self.newsModel.ids],@"id",
                                  nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionNewDetail];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionNewDetail,HTTP_USER_INFO, nil];
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
        if ([KAPI_ActionNewDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            if ([[dictionary valueForKey:@"value"] isKindOfClass:[NSDictionary class]]) {
                [HNYJSONUitls mappingDictionary:[dictionary valueForKey:@"value"] toObject:self.newsModel];
                [self.imgView setImageWithURL:[NSURL URLWithString:self.newsModel.img]];
                self.titleLabel.text = self.newsModel.title;
                self.timeLabel.text = self.newsModel.addtime;
                self.detailLabel.text = self.newsModel.descriptions;
                [self updateViewConstraints];
            }
        }
    }
    else{
        if ([KAPI_ActionNewDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            
        }
    }
}

@end
