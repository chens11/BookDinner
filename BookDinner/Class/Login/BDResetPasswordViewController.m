//
//  BDResetPasswordViewController.m
//  BookDinner
//
//  Created by zqchen on 26/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDResetPasswordViewController.h"

@interface BDResetPasswordViewController ()<HNYDetailTableViewControllerDelegate,HNYDelegate>
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;


@end

@implementation BDResetPasswordViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"重置密码";
    [self createTable];
    [self setContent];
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
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = TextField;
    nameItem.key = @"phone";
    nameItem.editable = YES;
    nameItem.textValue = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ACCOUNT];
    nameItem.textFont = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
    nameItem.name = @"  手机号码:";
    nameItem.placeholder = @"请输入手机号";
    nameItem.height = @"one";
    [_viewAry addObject:nameItem];
    
    HNYDetailItemModel *passwordItem = [[HNYDetailItemModel alloc] init];
    passwordItem.viewType = TextField;
    passwordItem.key = @"password";
    passwordItem.editable = YES;
    passwordItem.secureTextEntry = YES;
    passwordItem.textFont = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
    passwordItem.name = @"   新 密 码:";
    passwordItem.height = @"one";
    passwordItem.placeholder =  @"请输入新密码";
    [_viewAry addObject:passwordItem];

    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Customer;
    numItem.editable = YES;
    numItem.name = @"   验 证 码:";
    numItem.placeholder = @"请输入验证码";
    numItem.key = @"code";
    numItem.height = @"one";
    numItem.textFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [_viewAry addObject:numItem];
    
    HNYDetailItemModel *changeItem = [[HNYDetailItemModel alloc] init];
    changeItem.viewType = Customer;
    changeItem.editable = YES;
    changeItem.key = @"change";
    changeItem.height = @"one";
    changeItem.textFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [_viewAry addObject:changeItem];
    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

#pragma mark - EXDetailTableViewDelegate
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
//    if ([controller isKindOfClass:[HNYDetailTableViewController class]]) {
//        if ([@"num" isEqualToString:key]) {
//            self.priceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",[self calculatePrice]];
//        }
//        else if ([@"outerUserMobiles" isEqualToString:key]){
//        }
//    }
}

#pragma mark - create subview
- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 90;
    self.tableViewController.nameTextFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 60;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.tableViewController.cellHeight*4);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}

- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([@"code" isEqualToString:item.key]){
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - self.tableViewController.nameLabelWidth, self.tableViewController.cellHeight)];
        
        self.codeTextField = [[HNYTextField alloc] initWithFrame:CGRectMake(0, 0, numView.frame.size.width - 110, self.tableViewController.cellHeight)];
        self.codeTextField.enabled = item.editable;
        self.codeTextField.tag = item.tag;
        self.codeTextField.backgroundColor = item.backGroundColor;
        self.codeTextField.text = item.textValue;
        self.codeTextField.delegate = self.tableViewController;
        self.codeTextField.secureTextEntry = item.secureTextEntry;
        self.codeTextField.font = item.textFont;
        self.codeTextField.textColor = item.textColor;
        self.codeTextField.returnKeyType = item.returnKeyType;
        self.codeTextField.keyboardType = item.keyboardType;
        self.codeTextField.placeholder = item.placeholder;
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(numView.frame.size.width - 110, 8, 100, self.tableViewController.cellHeight - 16);
        addBtn.tag = 101;
        addBtn.enabled = YES;
        addBtn.titleLabel.font = ButtonTitleFont;
        [addBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [addBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(touchButtons:) forControlEvents:UIControlEventTouchUpInside];
        
        [numView addSubview:self.codeTextField];
        [numView addSubview:addBtn];
        return numView;
    }
    else if ([@"change" isEqualToString:item.key]){
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableViewController.cellHeight)];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(10, 8, self.view.frame.size.width - 20, self.tableViewController.cellHeight - 16);
        addBtn.tag = 102;
        addBtn.enabled = YES;
        addBtn.titleLabel.font = ButtonTitleFont;
        [addBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [addBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(touchButtons:) forControlEvents:UIControlEventTouchUpInside];
        
        [numView addSubview:addBtn];
        return numView;
    }
    return [[UIView alloc] init];
}
#pragma mark - IBAction
- (void)touchButtons:(UIButton*)sender{
    [self.view endEditing:YES];
    HNYDetailItemModel *phoneItem = [self.tableViewController getItemWithKey:@"phone"];
    HNYDetailItemModel *passwordItem = [self.tableViewController getItemWithKey:@"password"];
    HNYDetailItemModel *codeItem = [self.tableViewController getItemWithKey:@"code"];
    
    if (phoneItem.textValue.length == 0) {
        [self showTips:@"请您输入手机号码账号"];
        return;
    }

    if (sender.tag == 101) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      phoneItem.textValue,USER_ACCOUNT,
                                      [AppInfo headInfo],HTTP_HEAD,
                                      nil];
        [self getConfirmCode:param];

    }
    else if (sender.tag == 102){
        if (passwordItem.textValue.length == 0) {
            [self showTips:@"请您输入新密码"];
            return;
        }
        
        if (codeItem.textValue.length == 0) {
            [self showTips:@"请您输入验证码"];
            return;
        }
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      phoneItem.textValue,USER_ACCOUNT,
                                      passwordItem.textValue,USER_PASSWORD,
                                      codeItem.textValue,@"captcha",
                                      [AppInfo headInfo],HTTP_HEAD,nil];
        [self changePassword:param];
    }
}

#pragma mark - http request

- (void)getConfirmCode:(NSDictionary*)params{
    [self showRequestingTips:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetConfirmCode];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"url = %@ \n param = %@",urlString,params);
    
    NSString *jsonString = [params JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetConfirmCode,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
    
}
- (void)changePassword:(NSDictionary*)params{
    [self showRequestingTips:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionResetPassWord];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"url = %@ \n param = %@",urlString,params);
    
    NSString *jsonString = [params JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionResetPassWord,HTTP_USER_INFO, nil];
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
        if ([ActionGetConfirmCode isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionResetPassWord isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:RememberPassWord]) {
                HNYDetailItemModel *passwordItem = [self.tableViewController getItemWithKey:@"password"];
                [[NSUserDefaults standardUserDefaults] setValue:passwordItem.textValue forKey:USER_PASSWORD];
            }
            [self.customNaviController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:1];
        }
    }
    else{
        if ([ActionGetConfirmCode isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            
        }
        else if ([ActionResetPassWord isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
    
}

@end
