//
//  BDOrderDetailViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderDetailViewController.h"
#import "BDOrderReceiveAddressView.h"
#import "BDAddressViewController.h"
#import "HNYActionSheet.h"
#import "BDCouponViewController.h"
#import "BDOrderAddressView.h"
#import "BDOrderCouponView.h"
#import "BDOrderInfoView.h"
#import "BDOrderProductCell.h"

@interface BDOrderDetailViewController ()<HNYDelegate,HNYActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) BDOrderCouponView *couponView;
@property (nonatomic,strong) BDOrderInfoView *infoView;
@property (nonatomic,strong) BDOrderAddressView *addressView;
@property (nonatomic,strong) UITextField *remarkTextField;
@property (nonatomic,strong) UIButton *orderBtn;


@end

@implementation BDOrderDetailViewController
@synthesize orderModel = _orderModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.editAble = YES;
        self.orderModel = [[BDOrderModel alloc] init];
        // Custom initializations
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单详细";
    [self createSubView];
    [self updateViewConstraints];
    if (self.editAble){
        [self getDefaultAddress];
    }
    else
        [self getOrderDetail];
    [self calculatePrice];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dose of any resources that can be recreated.
}
#pragma mark - create subview
- (void)createSubView{
    
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    
    self.contentView = [[UIView alloc] init];
    [self.scroll addSubview:self.contentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.contentView addSubview:self.tableView];
    
    self.couponView = [[BDOrderCouponView alloc] init];
    self.couponView.delegate = self;
    [self.contentView addSubview:self.couponView];
    
    self.infoView = [[BDOrderInfoView alloc] init];
    [self.contentView addSubview:self.infoView];
    
    self.addressView = [[BDOrderAddressView alloc] init];
    [self.contentView addSubview:self.addressView];
    
    
    UIView *remarkView = [[UIView alloc] init];
    remarkView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:remarkView];
    
    self.remarkTextField = [[UITextField alloc] init];
    self.remarkTextField.placeholder = @"备注信息";
    self.remarkTextField.textAlignment = NSTextAlignmentLeft;
    self.remarkTextField.backgroundColor = [UIColor whiteColor];
    [remarkView addSubview:self.remarkTextField];
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBtn.tag = 3;
    [self.orderBtn setTitle:@"购买" forState:UIControlStateNormal];
    [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    self.orderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    self.orderBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.orderBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    if (![@"0" isEqualToString:self.orderState])
        self.orderBtn.enabled = NO;
    [self.view addSubview:self.orderBtn];

    
}

- (void)updateViewConstraints{
    
    [self.scroll mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.naviBar.frame.size.height);
        make.left.right.equalTo(self.view);
    }];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroll);
        make.left.equalTo(self.scroll);
        make.width.equalTo(self.scroll);
        make.bottom.equalTo(self.addressView);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(44*self.orderModel.product.count);
    }];
    
    [self.remarkTextField.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    [self.remarkTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.remarkTextField.superview);
        make.left.equalTo(self.remarkTextField.superview).offset(KFONT_SIZE_MAX_16);
        make.right.equalTo(self.remarkTextField.superview).offset(-KFONT_SIZE_MAX_16);
    }];
    
    [self.couponView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remarkTextField.superview.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
    }];
    

    [self.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couponView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
    }];
    
    
    [self.orderBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroll.mas_bottom).offset(8);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(self.view).offset(-8);
    }];
    
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height);
    [super updateViewConstraints];
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderModel.product.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDOrderProductCell";
    BDOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDOrderProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    BDProductModel *model = [self.orderModel.product objectAtIndex:indexPath.row];
    [cell configureCellWith:model];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - HNYDelegate

- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDCouponViewController class]]) {
        BDCouponModel *model = [info valueForKey:@"BDCouponModel"];
        self.orderModel.ticker_id = model.ids;
        self.orderModel.ticker_name = model.name;
        self.orderModel.ticker_money = model.money;
        self.couponView.detailLabel.text = model.name;
        self.couponView.offsetPriceLabel.text = [NSString stringWithFormat:@"¥ -%@",model.money];
        
        [self calculatePrice];
    }
}


- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isKindOfClass:[BDOrderProductCell class]]) {
        
        BDOrderProductCell *cell = (BDOrderProductCell*)aView;
        
        if ([@"add" isEqualToString:[info valueForKey:@"action"]]) {
            cell.productModel.number += 1;
        }
        else if ([@"remove" isEqualToString:[info valueForKey:@"action"]]) {
            if (cell.productModel.number == 0) {
                cell.productModel.number = 0;
            }
            else{
                cell.productModel.number -= 1;
            }
        }
        [cell configureCellWith:cell.productModel];
        [self calculatePrice];
    }
    else if ([aView isEqual:self.couponView]){
        BDCouponViewController *controller = [[BDCouponViewController alloc] init];
        controller.title = @"请选择优惠券";
        controller.selector = YES;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - touchButton
- (void)touchBuyButton:(UIButton*)sender{
    [self.view endEditing:YES];
    
    if (!self.editAble) {
        BDPayViewController *controller = [[BDPayViewController alloc] init];
        controller.orderModel = self.orderModel;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:KUSER_IS_LOGIN]) {
        [self login];
        return;
    }
    
    if (!self.orderModel.address) {
        [self showTips:@"请您输入收货地址"];
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger num = 0;
    for (BDProductModel *model in self.orderModel.product) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:model.ids],@"id",[NSNumber numberWithInteger:model.number],@"number", nil];
        num += model.number;
        [array addObject:dic];
    }
    if (num == 0) {
        [self showTips:@"请您至少购买一个产品"];
        return;
    }

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:array forKey:@"order"];
    [dictionary setValue:[NSNumber numberWithInteger:self.orderModel.address.ids] forKey:@"address_id"];
    [dictionary setValue:[NSNumber numberWithInteger:self.orderModel.ticker_id] forKey:@"ticker_id"];
    [dictionary setValue:self.orderModel.remark forKey:@"remark"];
    
    [dictionary setValue:[AppInfo headInfo] forKey:HTTP_HEAD];
    [self payOrderWith:dictionary];
}


#pragma mark - http request

- (void)payOrderWith:(NSDictionary*)params{
    [self showRequestingTips:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionPayOrder];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,params);
    
    NSString *jsonString = [params JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionPayOrder,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getDefaultAddress{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetAddressList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetAddressList,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
    
}


- (void)getOrderDetail{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  self.orderModel.ids,@"id",
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionGetOrderDetail];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionGetOrderDetail,HTTP_USER_INFO, nil];
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
        if ([KAPI_ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSDictionary *dic = [dictionary valueForKey:HTTP_VALUE];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                NSArray *value = [dic valueForKey:HTTP_DATA];
                if ([value isKindOfClass:[NSArray class]] && value.count > 0) {
                    BDAddressModel *address = [HNYJSONUitls mappingDictionary:[value objectAtIndex:0] toObjectWithClassName:@"BDAddressModel"];
                    self.orderModel.address_address = address.address;
                    self.orderModel.address_id = address.ids;
                    self.orderModel.address_name = address.name;
                    self.orderModel.address_tel = address.tel;
                    self.orderModel.address = address;
                    
                }
            }
        }
        else if ([KAPI_ActionPayOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSDictionary *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSDictionary class]]) {
                [self.orderModel.product removeAllObjects];
                self.orderModel.ids = [value objectForKey:@"ids"];
                self.orderModel.price = [value objectForKey:@"price"];
                BDPayViewController *controller = [[BDPayViewController alloc] init];
                controller.orderModel = self.orderModel;
                controller.delegate = self.delegate;
                NSMutableArray *array = [[self.navigationController viewControllers] mutableCopy];
                [array removeLastObject];
                [array addObject:controller];
                [self.navigationController setViewControllers:array animated:YES];
            }
        }
        else if ([KAPI_ActionGetOrderDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSDictionary *value = [dictionary valueForKey:@"value"];
            if ([value isKindOfClass:[NSDictionary class]]) {
                [HNYJSONUitls mappingDictionary:value toObject:self.orderModel];
                [self calculatePrice];
            }

        }

    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([KAPI_ActionPayOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([KAPI_ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
//            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([KAPI_ActionGetOrderDetail isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([KAPI_ActionPayOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}
#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (float)calculatePrice{
    double sum = 0.0;
    NSInteger num = 0;

    if (!self.editAble) {
        sum = [self.orderModel.price floatValue];
    }
    else{
        for (BDProductModel *model in self.orderModel.product) {
            sum += [model.money doubleValue] * (double)model.number;
            num += model.number;
        }
    }
    
    if (self.orderModel.ticker_id != 0) {
        sum -= [self.orderModel.ticker_money doubleValue];
        if (sum < 0) {
            sum = 0;
        }
    }
    [self.infoView updateNum:num price:sum];
    return sum;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)setOrderModel:(BDOrderModel *)orderModel{
    _orderModel = orderModel;
    [self calculatePrice];
}
@end
