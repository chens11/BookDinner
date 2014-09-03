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
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;


@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UITextView *contentTextView;
@property (nonatomic,strong) UITextField *numTextField;
@property (nonatomic,strong) UILabel *totalLabel;

@end

@implementation BDOrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
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

    [self setContent];
    

    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height - 50, self.view.frame.size.width - 130, 40)];
    self.priceLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.priceLabel.text = @"合计: ￥44.0";
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.view addSubview:self.priceLabel];

    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.tag = 3;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.backgroundColor = ButtonNormalColor;
    buyBtn.titleLabel.font = ButtonTitleFont;
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    buyBtn.frame = CGRectMake(self.view.frame.size.width - 110, self.view.frame.size.height - 50, 100, 40);
    buyBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buyBtn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];

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
    imgItem.value = [UIImage imageNamed:@"dinner"];
    imgItem.height = @"four";
    imgItem.key = @"menu_image";
    [_viewAry addObject:imgItem];
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = Label;
    nameItem.editable = YES;
    nameItem.key = @"name";
    nameItem.textAlignment = NSTextAlignmentRight;
    nameItem.textValue = @"$40";
    nameItem.textColor = [UIColor lightGrayColor];
    nameItem.rightPadding = 10;
    nameItem.textFont = [UIFont systemFontOfSize:16];
//    nameItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    nameItem.name = @"  红烧排骨饭 ";
    nameItem.height = @"one";
    [_viewAry addObject:nameItem];
    
    
    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = TextField;
    numItem.editable = YES;
    numItem.name = @"  购买数量 ";
    numItem.key = @"num";
    numItem.height = @"one";
    numItem.keyboardType = UIKeyboardTypeNumberPad;
    numItem.textAlignment = NSTextAlignmentCenter;
    numItem.textValue = @"1";
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
    typeItem.textValue = @"本人购买";
    typeItem.textColor = [UIColor lightGrayColor];
    typeItem.name = @"  购买方式";
    [_viewAry addObject:typeItem];

    HNYDetailItemModel *couponItem = [[HNYDetailItemModel alloc] init];
    couponItem.viewType = Label;
    couponItem.editable = YES;
    couponItem.height = @"one";
    couponItem.key = @"coupon";
    couponItem.textValue = @"一元券";
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
    timeItem.textValue = @"11:30 - 12:00";
    timeItem.textColor = [UIColor lightGrayColor];
    timeItem.textAlignment = NSTextAlignmentRight;
    timeItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:timeItem];

    
    HNYDetailItemModel *markItem = [[HNYDetailItemModel alloc] init];
    markItem.viewType = Label;
    markItem.editable = YES;
    markItem.height = @"one";
    markItem.key = @"payType";
    markItem.name = @"  支付方式";
    markItem.textValue = @"支付宝支付";
    markItem.textColor = [UIColor lightGrayColor];
    markItem.textAlignment = NSTextAlignmentRight;
    markItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_viewAry addObject:markItem];


    HNYDetailItemModel *addressItem = [[HNYDetailItemModel alloc] init];
    addressItem.viewType = Customer;
    addressItem.key = @"address";
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
        if ([@"innerUserList" isEqualToString:key]) {
        }
        else if ([@"outerUserMobiles" isEqualToString:key]){
        }
        else if ([@"desc" isEqualToString:key]){
        }
    }
}

- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([@"address" isEqualToString:item.key]) {
        
        BDOrderReceiveAddressView *addressView = [[BDOrderReceiveAddressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 0 , 40, self.tableViewController.cellHeight*3)];
        addressView.addressModel = nil;
        return addressView;
    }

    return [[UIView alloc] init];
}


- (void)tableViewController:(HNYDetailTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNYDetailItemModel *item = [self.tableViewController.viewAry objectAtIndex:indexPath.row];
    if ([@"address" isEqualToString:item.key]) {
        BDAddressViewController *controller = [[BDAddressViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
        
    }
    else if ([@"buyType" isEqualToString:item.key]) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSString *buySelf = [NSString stringWithFormat:@"本人购买"];
        [array addObject:buySelf];
        NSString *sendOther = [NSString stringWithFormat:@"赠送朋友"];
        [array addObject:sendOther];
        
        HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择购买方式" withStringAry:array cancelBtnTitle:nil sureBtnTitle:nil delegate:self];
        sheet.tag = 100;
    }
    else if ([@"coupon" isEqualToString:item.key]) {
        BDCouponViewController *controller = [[BDCouponViewController alloc] init];
        controller.customNaviController = self.customNaviController;
        [self.customNaviController pushViewController:controller animated:YES];
        
    }
    else if ([@"payType" isEqualToString:item.key]) {
        NSMutableArray *array = [NSMutableArray array];
        NSString *buySelf = [NSString stringWithFormat:@"支付宝支付"];
        [array addObject:buySelf];
        NSString *sendOther = [NSString stringWithFormat:@"微信支付"];
        [array addObject:sendOther];
        NSString *myPay = [NSString stringWithFormat:@"我的钱包付        余额:￥200"];
        [array addObject:myPay];
        HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择支付方式" withStringAry:array cancelBtnTitle:nil sureBtnTitle:nil delegate:self];
        sheet.tag = 101;
        
    }
    else if ([@"time" isEqualToString:item.key]){
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"10:00 - 10:30",@"10:30 - 11:00",@"11:00 - 11:30",@"11:30 - 12:00",@"12:00 - 12:30",@"12:30 - 13:00",@"13:00 - 13:30", nil];

        HNYActionSheet *sheet = [HNYActionSheet showWithTitle:@"请选择送餐时间" withStringAry:array cancelBtnTitle:nil sureBtnTitle:nil delegate:self];
        sheet.tag = 102;

//        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 216, self.view.frame.size.width, 216)];
//        picker.datePickerMode = UIDatePickerModeDateAndTime;
//        [picker addTarget:self action:@selector(dateValueChang:) forControlEvents:UIControlEventValueChanged];
//        [self.view addSubview:picker];
    }

}

#pragma mark - touchButton
- (void)dateValueChang:(UIDatePicker*)picker{
    
}

- (void)touchButton:(UIButton*)sender{
    [self.view endEditing:YES];
    if (sender.tag == 100) {
        if (![@"1" isEqualToString:self.numTextField.text]) {
            self.numTextField.text = [NSString stringWithFormat:@"%d",[self.numTextField.text intValue] - 1];
        }
    }
    else if (sender.tag == 101) {
            self.numTextField.text = [NSString stringWithFormat:@"%d",[self.numTextField.text intValue] + 1];
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



@end
