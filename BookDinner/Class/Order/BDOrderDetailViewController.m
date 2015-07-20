//
//  BDOrderDetailViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderDetailViewController.h"
#import "HNYDetailTableViewController.h"
#import "BDOrderReceiveAddressView.h"
#import "BDAddressViewController.h"
#import "HNYActionSheet.h"
#import "BDCouponViewController.h"

@interface BDOrderDetailViewController ()<HNYDetailTableViewControllerDelegate,HNYDelegate,HNYActionSheetDelegate>
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) NSArray *timeAry;
@property (nonatomic,strong) NSArray *buyTypeAry;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) HNYTextField *numTextField;

@end

@implementation BDOrderDetailViewController
@synthesize orderModel = _orderModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.editAble = YES;
        self.orderModel = [[BDOrderModel alloc] init];
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        self.timeAry = [NSArray arrayWithObjects:@"10:00 - 10:30",@"10:30 - 11:00",@"11:00 - 11:30",@"11:30 - 12:00",@"12:00 - 12:30",@"12:30 - 13:00",@"13:00 - 13:30", nil];
        self.buyTypeAry = [NSArray arrayWithObjects:@"本人购买",@"赠送朋友",nil];
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
    [self createTable];
    [self setContent];
    [self createBottomView];
    if (self.editAble)
        [self getDefaultAddress];
    else
        [self getOrderDetail];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dose of any resources that can be recreated.
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
- (void)setContent{
    
    HNYDetailItemModel *imgItem = [[HNYDetailItemModel alloc] init];
    imgItem.viewType = ImageView;
    imgItem.value = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.orderModel.img]];
    imgItem.height = @"four";
    imgItem.dataSource = [UIImage imageNamed:@"dinner"];
    imgItem.key = @"menu_image";
    [_viewAry addObject:imgItem];
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = Label;
    nameItem.editable = self.editAble;
    nameItem.key = @"name";
    nameItem.textAlignment = NSTextAlignmentRight;
    nameItem.textValue = [NSString stringWithFormat:@"￥%@",self.orderModel.money];
    nameItem.value = self.orderModel.product.money;
    nameItem.textColor = [UIColor lightGrayColor];
    nameItem.rightPadding = 10;
    nameItem.textFont = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
    nameItem.name = [NSString stringWithFormat:@"  %@",self.orderModel.title];
    nameItem.height = @"one";
    [_viewAry addObject:nameItem];
    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Customer;
    numItem.editable = self.editAble;
    numItem.name = @"  购买数量 ";
    numItem.key = @"num";
    numItem.height = @"one";
    numItem.keyboardType = UIKeyboardTypeNumberPad;
    numItem.textAlignment = NSTextAlignmentCenter;
    if (self.orderModel.order_number < 1)
        numItem.textValue = @"1";
    else
        numItem.textValue = [NSString stringWithFormat:@"%d",self.orderModel.order_number];
    numItem.value = numItem.textValue;
    numItem.textColor = [UIColor lightGrayColor];
    numItem.textFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [_viewAry addObject:numItem];
    
    
    HNYDetailItemModel *typeItem = [[HNYDetailItemModel alloc] init];
    typeItem.viewType = Label;
    typeItem.editable = self.editAble;
    typeItem.height = @"one";
    typeItem.textAlignment = NSTextAlignmentRight;
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    typeItem.key = @"buyType";
    typeItem.textValue = [self.buyTypeAry objectAtIndex:self.orderModel.using];
    typeItem.value = [NSNumber numberWithInt:self.orderModel.using];
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.name = @"  购买方式";
    [_viewAry addObject:typeItem];

    HNYDetailItemModel *couponItem = [[HNYDetailItemModel alloc] init];
    couponItem.viewType = Label;
    couponItem.editable = self.editAble;
    couponItem.height = @"one";
    couponItem.key = @"coupon";
    couponItem.textValue = @"请选择优惠券";
    if (!self.orderModel.ticker && !self.editAble)
        couponItem.textValue = @"未使用";
    else
        couponItem.textValue = self.orderModel.ticker.name;

    couponItem.textAlignment = NSTextAlignmentRight;
    couponItem.textColor = [UIColor lightGrayColor];
    couponItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    couponItem.name = @"  优惠券";
    [_viewAry addObject:couponItem];
    
    
    HNYDetailItemModel *timeItem = [[HNYDetailItemModel alloc] init];
    timeItem.viewType = Label;
    timeItem.editable = self.editAble;
    timeItem.height = @"one";
    timeItem.key = @"time";
    timeItem.name = @"  送餐时间";
    timeItem.textValue = @"请您选择送餐时间";
    if (self.orderModel.order_date)
        timeItem.textValue = self.orderModel.order_date;
    timeItem.textColor = [UIColor lightGrayColor];
    timeItem.textAlignment = NSTextAlignmentRight;
    timeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:timeItem];

    HNYDetailItemModel *addressItem = [[HNYDetailItemModel alloc] init];
    addressItem.viewType = Customer;
    addressItem.key = KUSER_ADDRESS;
    addressItem.height = @"auto";
    addressItem.maxheight = 80;
    addressItem.minheight = 80;
    addressItem.editable = NO;
    addressItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:addressItem];
    
    HNYDetailItemModel *remarkItem = [[HNYDetailItemModel alloc] init];
    remarkItem.viewType = TextView;
    remarkItem.editable = self.editAble;
    addressItem.height = @"auto";
    addressItem.maxheight = self.tableViewController.cellHeight;
    addressItem.minheight = self.tableViewController.cellHeight;
    addressItem.value = self.orderModel.remarks;
    remarkItem.key = @"remark";
    remarkItem.name = @"  留   言";
    [_viewAry addObject:remarkItem];
     self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

#pragma mark - EXDetailTableViewDelegate
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    if ([controller isKindOfClass:[HNYDetailTableViewController class]]) {
        if ([@"num" isEqualToString:key]) {
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
        }
        else if ([@"outerUserMobiles" isEqualToString:key]){
        }
    }
}

#pragma mark - create subview
- (void)createBottomView{
    float price = [self calculatePrice];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 50, self.view.frame.size.width - 130, 40)];
    self.priceLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",price];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [self.view addSubview:self.priceLabel];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.tag = 3;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    buyBtn.frame = CGRectMake(self.view.frame.size.width - 110, self.view.frame.size.height - 50, 100, 40);
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buyBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    if (![@"0" isEqualToString:self.orderState])
        buyBtn.enabled = NO;
    [self.view addSubview:buyBtn];
}

- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 100;
    self.tableViewController.nameTextFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 60;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - 60);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}


- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([KUSER_ADDRESS isEqualToString:item.key]) {
        
        BDOrderReceiveAddressView *addressView = [[BDOrderReceiveAddressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 0 , 40, self.tableViewController.cellHeight*3)];
        addressView.addressModel = item.value;
        return addressView;
    }
    else if ([@"num" isEqualToString:item.key]){
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - self.tableViewController.nameLabelWidth, self.tableViewController.cellHeight)];
        
        UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minusBtn.frame = CGRectMake(numView.frame.size.width - 120, 0, 40, self.tableViewController.cellHeight);
        minusBtn.tag = 100;
        minusBtn.enabled = self.editAble;
        [minusBtn setImage:[UIImage imageNamed:@"LLMenuRemoveRound"] forState:UIControlStateNormal];
        [minusBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.numTextField = [[HNYTextField alloc] initWithFrame:CGRectMake(numView.frame.size.width - 86, 0, 45, self.tableViewController.cellHeight)];
        self.numTextField.enabled = item.editable;
        self.numTextField.tag = item.tag;
        self.numTextField.textAlignment = item.textAlignment;
        self.numTextField.backgroundColor = item.backGroundColor;
        self.numTextField.text = item.textValue;
        self.numTextField.delegate = self.tableViewController;
        self.numTextField.secureTextEntry = item.secureTextEntry;
        self.numTextField.font = item.textFont;
        self.numTextField.textColor = item.textColor;
        self.numTextField.returnKeyType = item.returnKeyType;
        self.numTextField.keyboardType = item.keyboardType;
        self.numTextField.placeholder = item.placeholder;

        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(numView.frame.size.width - 50, 0, 40, self.tableViewController.cellHeight);
        addBtn.tag = 101;
        addBtn.enabled = self.editAble;
        [addBtn setImage:[UIImage imageNamed:@"LLMenuAddRound"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [numView addSubview:self.numTextField];
        [numView addSubview:minusBtn];
        [numView addSubview:addBtn];
        return numView;
    }
    return [[UIView alloc] init];
}


- (void)tableViewController:(HNYDetailTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.editAble)
        return;
    HNYDetailItemModel *item = [self.tableViewController.viewAry objectAtIndex:indexPath.row];
    if ([KUSER_ADDRESS isEqualToString:item.key]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:KUSER_IS_LOGIN]) {
            BDAddressViewController *controller = [[BDAddressViewController alloc] init];
            controller.delegate = self;
            controller.selector = YES;
            controller.title = @"请选择收货地址";
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
            [self login];
        
    }
    else if ([@"buyType" isEqualToString:item.key]) {
        HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择购买方式"
                                                withStringAry:self.buyTypeAry
                                               cancelBtnTitle:nil
                                                 sureBtnTitle:nil
                                                     delegate:self];
        sheet.tag = item.tag;
    }
    else if ([@"coupon" isEqualToString:item.key]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:KUSER_IS_LOGIN]) {
            HNYDetailItemModel *buyItem = [self.tableViewController getItemWithKey:@"buyType"];
            
            BDCouponViewController *controller = [[BDCouponViewController alloc] init];
            controller.title = @"请选择优惠券";
            controller.selector = YES;
            controller.delegate = self;
            controller.using = [buyItem.value intValue];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else{
            [self login];
        }
        
    }
    else if ([@"time" isEqualToString:item.key]){
        

        HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择送餐时间"
                                                withStringAry:self.timeAry
                                               cancelBtnTitle:nil
                                                 sureBtnTitle:nil
                                                     delegate:self];
        sheet.tag = item.tag;

    }

}

#pragma mark - touchButton
- (void)dateValueChang:(UIDatePicker*)picker{
    
}

- (void)touchBuyButton:(UIButton*)sender{
    [self.view endEditing:YES];
    
    if (!self.editAble) {
        BDPayViewController *controller = [[BDPayViewController alloc] init];
        controller.orderModel = self.orderModel;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    HNYDetailItemModel *numItem = [self.tableViewController getItemWithKey:@"num"];
    if (sender.tag == 100) {
        if ([numItem.value intValue] > 1) {
            if ([numItem.value intValue] == 3)
                return;
            numItem.value = [NSString stringWithFormat:@"%d",[numItem.value intValue] - 1];
            numItem.textValue = numItem.value;
            self.numTextField.text = numItem.value;
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
        }
    }
    else if (sender.tag == 101) {
        if ([numItem.value intValue] < self.orderModel.product.number) {
            numItem.value = [NSString stringWithFormat:@"%d",[numItem.value intValue] + 1];
            numItem.textValue = numItem.value;
            self.numTextField.text = numItem.value;
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
        }
    }
    else{
        if (![[NSUserDefaults standardUserDefaults] boolForKey:KUSER_IS_LOGIN]) {
            [self login];
            return;
        }
        HNYDetailItemModel *timeItem = [self.tableViewController getItemWithKey:@"time"];
        HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:KUSER_ADDRESS];
        HNYDetailItemModel *buyItem = [self.tableViewController getItemWithKey:@"buyType"];
        HNYDetailItemModel *couponItem = [self.tableViewController getItemWithKey:@"coupon"];
        HNYDetailItemModel *remarkItem = [self.tableViewController getItemWithKey:@"remark"];
        
        BDCouponModel *couponModel = couponItem.value;
        
        if ([numItem.value intValue] == 0) {
            [self showTips:@"请您至少购买一份"];
            return;
        }
        if (!numItem.value) {
            [self showTips:@"请您选择购买数量"];
            return;
        }
        if (!timeItem.value) {
            [self showTips:@"请您选择送餐时间"];
            return;
        }
        
        if (!addressItem.value) {
            [self showTips:@"请您输入收货地址"];
            return;
        }
        
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:[NSNumber numberWithInt:self.orderModel.product.id] forKey:@"product_id"];
        [dictionary setValue:[NSNumber numberWithInt:self.orderModel.address.id] forKey:@"user_address_id"];
        [dictionary setValue:[NSNumber numberWithInt:[numItem.value intValue]] forKey:@"order_number"];
        [dictionary setValue:timeItem.value forKey:@"order_date"];
        [dictionary setValue:buyItem.value forKey:@"using"];
        [dictionary setValue:[NSNumber numberWithInt:couponModel.id] forKey:@"ticker_id"];
        [dictionary setValue:remarkItem.value forKey:@"remarks"];
        //分类（1一元购，2买一送一，3买二送一 4 充值十元 5 充值五元）
//        if (self.orderModel.ticker.type == 2 || self.orderModel.ticker.type == 3){
//            [dictionary setValue:[NSNumber numberWithInt:[numItem.value intValue]- 1] forKey:@"order_number"];
//        }

        [dictionary setValue:[AppInfo headInfo] forKey:HTTP_HEAD];
        [dictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN] forKey:HTTP_TOKEN];
        [self payOrderWith:dictionary];
    }
}
#pragma mark - HNYActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)hNYActionSheetCancel:(HNYActionSheet *)actionSheet;{
    
}


// caled when select the String ary
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet didSelectStringAryAtIndex:(NSInteger)index{
    HNYDetailItemModel *item = [self.tableViewController.viewAry objectAtIndex:actionSheet.tag];
    if ([@"time" isEqualToString:item.key]) {
        NSString *time = [self.timeAry objectAtIndex:index];
        item.value = time;
        item.textValue = time;
        [self.tableViewController changeViewAryObjectWith:item atIndex:[self.viewAry indexOfObject:item]];
        [self.tableViewController.tableView reloadData];
    }
    //0本人购买 1赠送朋友
    else if ([@"buyType" isEqualToString:item.key]) {
        NSString *time = [self.buyTypeAry objectAtIndex:index];
        item.value = [NSNumber numberWithInt:index];
        item.textValue = time;
        [self.tableViewController changeViewAryObjectWith:item atIndex:[self.viewAry indexOfObject:item]];
        [self.tableViewController.tableView reloadData];
        
        if (!index == self.orderModel.ticker.using) {
            self.orderModel.ticker = nil;
            HNYDetailItemModel *couponItem = [self.tableViewController getItemWithKey:@"coupon"];
            couponItem.textValue = @"请选择优惠券";
            couponItem.value = nil;
            [self.tableViewController changeViewAryObjectWith:couponItem atIndex:[self.viewAry indexOfObject:couponItem]];
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
            [self.tableViewController.tableView reloadData];
        }
    }

    [actionSheet hide];
}

 // before animation and showing view
- (void)willPresentHNYActionSheet:(HNYActionSheet *)actionSheet{
    
}

// after animation
- (void)didPresentHNYActionSheet:(HNYActionSheet *)actionSheet{
    
}


// before animation and hiding view
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}


// after animation
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
#pragma mark - HNYDelegate
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([vController isKindOfClass:[BDAddressViewController class]]) {
        BDAddressModel *model = [info valueForKey:@"BDAddressModel"];
        self.orderModel.address = model;
        HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:KUSER_ADDRESS];
        addressItem.value = self.orderModel.address;
        [self.tableViewController changeViewAryObjectWith:addressItem atIndex:[self.viewAry indexOfObject:addressItem]];
        [self.tableViewController.tableView reloadData];
    }
    else if ([vController isKindOfClass:[BDPayViewController class]]){
        if ([[info valueForKey:@"PayResult"] boolValue]) {
            [self.navigationController popViewControllerAnimated:NO];
            [self.delegate viewController:self actionWitnInfo:info];
        }

    }
    else if ([vController isKindOfClass:[BDCouponViewController class]]) {
        BDCouponModel *model = [info valueForKey:@"BDCouponModel"];
        self.orderModel.ticker = model;
        HNYDetailItemModel *couponItem = [self.tableViewController getItemWithKey:@"coupon"];
        HNYDetailItemModel *numItem = [self.tableViewController getItemWithKey:@"num"];

        couponItem.value = self.orderModel.ticker;
        couponItem.textValue = self.orderModel.ticker.name;
        [self.tableViewController changeViewAryObjectWith:couponItem atIndex:[self.viewAry indexOfObject:couponItem]];
        //分类（1一元购，2买一送一，3买二送一 4 充值十元 5 充值五元）
        if (self.orderModel.ticker.type == 2 && [numItem.value intValue] < 2) {
//            numItem.value = [NSString stringWithFormat:@"%d",[numItem.value intValue] + 1];
//            numItem.textValue = numItem.value;
//            self.numTextField.text = numItem.value;
//            [self.tableViewController changeViewAryObjectWith:numItem atIndex:[self.viewAry indexOfObject:numItem]];
        }
        else if (self.orderModel.ticker.type == 3 && [numItem.value intValue] < 2) {
            numItem.value = [NSString stringWithFormat:@"%d",2];
            numItem.textValue = numItem.value;
            self.numTextField.text = numItem.value;
            [self.tableViewController changeViewAryObjectWith:numItem atIndex:[self.viewAry indexOfObject:numItem]];
        }
        
        self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
        [self.tableViewController.tableView reloadData];
    }
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
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [NSNumber numberWithInt:self.orderModel.id],@"id",
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
            NSArray *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSArray class]] && value.count > 0) {
                self.orderModel.address = [HNYJSONUitls mappingDictionary:[value objectAtIndex:0] toObjectWithClassName:@"BDAddressModel"];
                
                HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:KUSER_ADDRESS];
                addressItem.value = self.orderModel.address;
                [self.tableViewController changeViewAryObjectWith:addressItem atIndex:[self.viewAry indexOfObject:addressItem]];
                [self.tableViewController.tableView reloadData];
            }
        }
        else if ([KAPI_ActionPayOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            NSDictionary *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSDictionary class]]) {
                self.orderModel.id = [[value objectForKey:@"id"] intValue];
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
                
                HNYDetailItemModel *timeItem = [self.tableViewController getItemWithKey:@"time"];
                timeItem.value = self.orderModel.order_date;
                timeItem.textValue = self.orderModel.order_date;
                
                HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:KUSER_ADDRESS];
                addressItem.value = self.orderModel.address;
                [self.tableViewController changeViewAryObjectWith:addressItem atIndex:[self.viewAry indexOfObject:addressItem]];
                
                [self.tableViewController changeViewAryObjectWith:timeItem atIndex:[self.viewAry indexOfObject:timeItem]];
                [self.tableViewController.tableView reloadData];
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
    if (!self.editAble) {
        return [self.orderModel.pricemoney floatValue];
    }
    
    float money = [self.orderModel.money floatValue];
    float price = money;
    
    //分类（1一元购，2买一送一，3买二送一 4 充值十元 5 充值五元）
    HNYDetailItemModel *numItem = [self.tableViewController getItemWithKey:@"num"];
    if (self.orderModel.ticker.type == 1) {
        price = money * ([numItem.value intValue] - 1);
        price += 1.00;
    }
//    else if (self.orderModel.ticker.type == 2){
//        price = money * ([numItem.value intValue] - 1);
//    }
//    else if (self.orderModel.ticker.type == 3){
//        price = money * ([numItem.value intValue] - 1);
//    }
    else
        price = money * [numItem.value intValue];
    self.orderModel.pricemoney = [NSString stringWithFormat:@"%f",price];
    return price;
}

@end
