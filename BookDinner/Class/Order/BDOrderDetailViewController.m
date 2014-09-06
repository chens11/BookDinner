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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.editAble = YES;
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
    [self getDefaultAddress];
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
    imgItem.value = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dinnerModel.img]];
    imgItem.height = @"four";
    imgItem.key = @"menu_image";
    [_viewAry addObject:imgItem];
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = Label;
    nameItem.editable = YES;
    nameItem.key = @"name";
    nameItem.textAlignment = NSTextAlignmentRight;
    nameItem.textValue = [NSString stringWithFormat:@"￥%@",self.dinnerModel.money];
    nameItem.value = self.dinnerModel.money;
    nameItem.textColor = [UIColor lightGrayColor];
    nameItem.rightPadding = 10;
    nameItem.textFont = [UIFont systemFontOfSize:16];
    nameItem.name = [NSString stringWithFormat:@"  %@",self.dinnerModel.title];
    nameItem.height = @"one";
    [_viewAry addObject:nameItem];
    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Customer;
    numItem.editable = YES;
    numItem.name = @"  购买数量 ";
    numItem.key = @"num";
    numItem.height = @"one";
    numItem.keyboardType = UIKeyboardTypeNumberPad;
    numItem.textAlignment = NSTextAlignmentCenter;
    numItem.textValue = @"1";
    numItem.value = @"1";
    numItem.textColor = [UIColor lightGrayColor];
    numItem.textFont = [UIFont boldSystemFontOfSize:16.0];
    [_viewAry addObject:numItem];
    
    
    HNYDetailItemModel *typeItem = [[HNYDetailItemModel alloc] init];
    typeItem.viewType = Label;
    typeItem.editable = YES;
    typeItem.height = @"one";
    typeItem.textAlignment = NSTextAlignmentRight;
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    typeItem.key = @"buyType";
    typeItem.textValue = [self.buyTypeAry objectAtIndex:0];
    typeItem.value = [NSNumber numberWithInt:0];
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.name = @"  购买方式";
    [_viewAry addObject:typeItem];

    HNYDetailItemModel *couponItem = [[HNYDetailItemModel alloc] init];
    couponItem.viewType = Label;
    couponItem.editable = YES;
    couponItem.height = @"one";
    couponItem.key = @"coupon";
    couponItem.textValue = @"请选择优惠券";
    couponItem.textAlignment = NSTextAlignmentRight;
    couponItem.textColor = [UIColor lightGrayColor];
    couponItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    couponItem.name = @"  优惠券";
    [_viewAry addObject:couponItem];
    
    
    HNYDetailItemModel *timeItem = [[HNYDetailItemModel alloc] init];
    timeItem.viewType = Label;
    timeItem.editable = YES;
    timeItem.height = @"one";
    timeItem.key = @"time";
    timeItem.name = @"  送餐时间";
    timeItem.textValue = @"请您选择送餐时间";
    timeItem.textColor = [UIColor lightGrayColor];
    timeItem.textAlignment = NSTextAlignmentRight;
    timeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:timeItem];

    HNYDetailItemModel *addressItem = [[HNYDetailItemModel alloc] init];
    addressItem.viewType = Customer;
    addressItem.key = USER_ADDRESS;
    addressItem.height = @"auto";
    addressItem.maxheight = 80;
    addressItem.minheight = 80;
    addressItem.editable = NO;
    addressItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:addressItem];
    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

#pragma mark - EXDetailTableViewDelegate
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    if ([controller isKindOfClass:[HNYDetailTableViewController class]]) {
        if ([@"num" isEqualToString:key]) {
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.1f",[self calculatePrice]];
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
    self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.1f",price];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.view addSubview:self.priceLabel];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.tag = 3;
    buyBtn.enabled = self.editAble;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.backgroundColor = ButtonNormalColor;
    buyBtn.titleLabel.font = ButtonTitleFont;
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    buyBtn.frame = CGRectMake(self.view.frame.size.width - 110, self.view.frame.size.height - 50, 100, 40);
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buyBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
}

- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 100;
    self.tableViewController.nameTextFont = [UIFont boldSystemFontOfSize:16.0];
    self.tableViewController.nameTextAlignment = UITextAlignmentLeft;
    self.tableViewController.cellHeight = 60;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - 60);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}


- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([USER_ADDRESS isEqualToString:item.key]) {
        
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
    if ([USER_ADDRESS isEqualToString:item.key]) {
        BDAddressViewController *controller = [[BDAddressViewController alloc] init];
        controller.delegate = self;
        controller.selector = YES;
        controller.title = @"请选择收货地址";
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
        
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
        HNYDetailItemModel *buyItem = [self.tableViewController getItemWithKey:@"buyType"];

        BDCouponViewController *controller = [[BDCouponViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        controller.title = @"请选择优惠券";
        controller.selector = YES;
        controller.delegate = self;
        controller.using = [buyItem.value intValue];
        [self.customNaviController pushViewController:controller animated:YES];
        
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
    BDPayViewController *controller = [[BDPayViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
    return;
    
    HNYDetailItemModel *numItem = [self.tableViewController getItemWithKey:@"num"];
    if (sender.tag == 100) {
        if ([numItem.value intValue] > 1) {
            numItem.value = [NSString stringWithFormat:@"%d",[numItem.value intValue] - 1];
            numItem.textValue = numItem.value;
            self.numTextField.text = numItem.value;
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.1f",[self calculatePrice]];
        }
    }
    else if (sender.tag == 101) {
        if ([numItem.value intValue] < self.dinnerModel.number) {
            numItem.value = [NSString stringWithFormat:@"%d",[numItem.value intValue] + 1];
            numItem.textValue = numItem.value;
            self.numTextField.text = numItem.value;
            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.1f",[self calculatePrice]];
        }
    }
    else{
        if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN]) {
            [self login];
            return;
        }
        HNYDetailItemModel *timeItem = [self.tableViewController getItemWithKey:@"time"];
        HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:USER_ADDRESS];
        HNYDetailItemModel *buyItem = [self.tableViewController getItemWithKey:@"buyType"];
        HNYDetailItemModel *couponItem = [self.tableViewController getItemWithKey:@"coupon"];
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
        [dictionary setValue:[NSNumber numberWithInt:self.dinnerModel.id] forKey:@"product_id"];
        [dictionary setValue:[NSNumber numberWithInt:self.addressModel.id] forKey:@"user_address_id"];
        [dictionary setValue:[NSNumber numberWithInt:[numItem.value intValue]] forKey:@"order_number"];
        [dictionary setValue:timeItem.value forKey:@"order_date"];
        [dictionary setValue:buyItem.value forKey:@"using"];
        [dictionary setValue:[NSNumber numberWithInt:couponModel.id] forKey:@"ticker_id"];
        [dictionary setValue:@"" forKey:@"remarks"];
        
        
        [dictionary setValue:[AppInfo headInfo] forKey:HTTP_HEAD];
        [dictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN] forKey:HTTP_TOKEN];
        [self placeOrderWith:dictionary];
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
    else if ([@"buyType" isEqualToString:item.key]) {
        NSString *time = [self.buyTypeAry objectAtIndex:index];
        item.value = [NSNumber numberWithInt:index];
        item.textValue = time;
        [self.tableViewController changeViewAryObjectWith:item atIndex:[self.viewAry indexOfObject:item]];
        [self.tableViewController.tableView reloadData];
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
        self.addressModel = model;
        HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:USER_ADDRESS];
        addressItem.value = self.addressModel;
        [self.tableViewController changeViewAryObjectWith:addressItem atIndex:[self.viewAry indexOfObject:addressItem]];
        [self.tableViewController.tableView reloadData];
    }
    else if ([vController isKindOfClass:[BDCouponViewController class]]) {
        BDCouponModel *model = [info valueForKey:@"BDCouponModel"];
        self.couponModel = model;
        HNYDetailItemModel *couponItem = [self.tableViewController getItemWithKey:@"coupon"];
        couponItem.value = self.couponModel;
        couponItem.textValue = self.couponModel.name;
        [self.tableViewController changeViewAryObjectWith:couponItem atIndex:[self.viewAry indexOfObject:couponItem]];
        [self.tableViewController.tableView reloadData];
    }
}
#pragma mark - http request

- (void)placeOrderWith:(NSDictionary*)params{
    [self showRequestingTips:nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionPlaceOrder];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,params);
    
    NSString *jsonString = [params JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionPlaceOrder,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)getDefaultAddress{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetAddressList];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetAddressList,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",string);
    [self.hud removeFromSuperview];
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *value = [dictionary valueForKey:HTTP_VALUE];
            if ([value isKindOfClass:[NSArray class]] && value.count > 0) {
                self.addressModel = [HNYJSONUitls mappingDictionary:[value objectAtIndex:0] toObjectWithClassName:@"BDAddressModel"];
                
                HNYDetailItemModel *addressItem = [self.tableViewController getItemWithKey:USER_ADDRESS];
                addressItem.value = self.addressModel;
                [self.tableViewController changeViewAryObjectWith:addressItem atIndex:[self.viewAry indexOfObject:addressItem]];
                [self.tableViewController.tableView reloadData];

            }
        }
        else if ([ActionPlaceOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            BDPayViewController *controller = [[BDPayViewController alloc] init];
            controller.customNaviController = self.customNaviController;
            NSMutableArray *array = [[self.customNaviController viewControllers] mutableCopy];
            [array removeLastObject];
            [array addObject:controller];
            [self.customNaviController setViewControllers:array animated:YES];
        }

    }
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        if ([ActionPlaceOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionGetAddressList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionPlaceOrder isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]){
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}
#pragma mark - instance fun
- (void)login{
    BDLoginViewController *controller = [[BDLoginViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}

- (float)calculatePrice{
    float money = [self.dinnerModel.money floatValue];
    float price = money;
    HNYDetailItemModel *numItem = [self.tableViewController getItemWithKey:@"num"];
    price = money * [numItem.value intValue];
    return price;
}

@end
