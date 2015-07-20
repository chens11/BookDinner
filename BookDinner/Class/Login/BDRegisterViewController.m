//
//  BDRegisterViewController.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDRegisterViewController.h"
#import "HNYDetailTableViewController.h"

@interface BDRegisterViewController ()<UITextFieldDelegate,HNYDetailTableViewControllerDelegate,HNYPopoverViewDelegate>
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;
@property (nonatomic,strong) UITextField *sexTextField;
@property (nonatomic,strong) NSArray *sexAry;
@property (nonatomic,strong) UITextField *codeTextField;

@end

@implementation BDRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        self.params = [NSMutableDictionary dictionary];
        self.sexAry = [NSArray arrayWithObjects:@"保密",@"男",@"女", nil];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"会员注册";
    [self createTable];
    [self setContent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create subview
- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 90;
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 50;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.tableViewController.cellHeight * 8);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}

- (void)setContent{
    
    HNYDetailItemModel *imgItem = [[HNYDetailItemModel alloc] init];
    imgItem.viewType = ImageView;
    imgItem.key = USER_IMG;
    imgItem.contentMode = UIViewContentModeCenter;
    imgItem.height = @"two";
    imgItem.value = [UIImage imageNamed:@"AppIcon11"];
    [self.viewAry addObject:imgItem];
    
    HNYDetailItemModel *accountItem = [[HNYDetailItemModel alloc] init];
    accountItem.viewType = TextField;
    accountItem.editable = YES;
    accountItem.key = USER_ACCOUNT;
    accountItem.rightPadding = 10;
    accountItem.name = @"  账号";
    accountItem.height = @"one";
    accountItem.placeholder = @"请您输入手机号码";
    accountItem.keyboardType = UIKeyboardTypeNumberPad;
    [self.viewAry addObject:accountItem];
    
    HNYDetailItemModel *nameItem = [[HNYDetailItemModel alloc] init];
    nameItem.viewType = TextField;
    nameItem.editable = YES;
    nameItem.name = @"  昵称";
    nameItem.key = USER_NAME;
    nameItem.height = @"one";
    nameItem.placeholder = @"请您输入昵称";
    [self.viewAry addObject:nameItem];
    
    HNYDetailItemModel *sexItem = [[HNYDetailItemModel alloc] init];
    sexItem.viewType = Customer;
    sexItem.editable = YES;
    sexItem.textValue = @"保密";
    sexItem.value = [NSString stringWithFormat:@"0"];
    sexItem.height = @"one";
    sexItem.key = USER_SEX;
    sexItem.name = @"  性别";
    [self.viewAry addObject:sexItem];
    
    HNYDetailItemModel *passwordItem = [[HNYDetailItemModel alloc] init];
    passwordItem.viewType = TextField;
    passwordItem.editable = YES;
    passwordItem.height = @"one";
    passwordItem.key = USER_PASSWORD;
    passwordItem.name = @"  密码";
    passwordItem.secureTextEntry = YES;
    passwordItem.placeholder = @"请您输入密码";
    [self.viewAry addObject:passwordItem];
    
    HNYDetailItemModel *conPasswordItem = [[HNYDetailItemModel alloc] init];
    conPasswordItem.viewType = TextField;
    conPasswordItem.editable = YES;
    conPasswordItem.height = @"one";
    conPasswordItem.key = USER_CONFIRM_PASSWORD;
    conPasswordItem.name = @"确认密码";
    conPasswordItem.placeholder = @"请您输入确认密码";
    conPasswordItem.secureTextEntry = YES;
    [self.viewAry addObject:conPasswordItem];
    
    HNYDetailItemModel *numItem = [[HNYDetailItemModel alloc] init];
    numItem.viewType = Customer;
    numItem.editable = YES;
    numItem.name = @"   验 证 码";
    numItem.placeholder = @"请输入验证码";
    numItem.key = @"captcha";
    numItem.height = @"one";
    numItem.textFont = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [_viewAry addObject:numItem];
    
    HNYDetailItemModel *buttonItem = [[HNYDetailItemModel alloc] init];
    buttonItem.viewType = Customer;
    buttonItem.height = @"one";
    buttonItem.key = @"button";
    [_viewAry addObject:buttonItem];
    
    self.tableViewController.viewAry = self.viewAry;
    [self.tableViewController.tableView reloadData];
}


#pragma mark - IBAction
- (void)touchRegisterButton:(UIButton*)sender{
    [self.view endEditing:YES];
    
    if (![self.params valueForKey:USER_ACCOUNT]) {
        [self showTips:@"账号不能为空"];
        return;
    }
    if (![AppInfo isValidateMobile:[self.params valueForKey:USER_ACCOUNT]]) {
        [self showTips:@"请输入正确的手机号码"];
        return;
    }
    if (![self.params valueForKey:USER_PASSWORD]) {
        [self showTips:@"密码不能为空"];
        return;
    }
    if (![[self.params valueForKey:USER_PASSWORD] isEqualToString:[self.params valueForKey:USER_CONFIRM_PASSWORD]]) {
        [self showTips:@"密码不一致"];
        return;
    }
    if (![self.params valueForKey:USER_NAME]) {
        [self showTips:@"昵称不能为空"];
        return;
    }
    
    if (![self.params valueForKey:@"captcha"]) {
        [self showTips:@"验证码不能为空"];
        return;
    }
    
    [self registerAccount];
}

- (void)touchButtons:(UIButton*)sender{
    [self.view endEditing:YES];
    HNYDetailItemModel *codeItem = [self.tableViewController getItemWithKey:USER_ACCOUNT];
    
    if (sender.tag == 101) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      codeItem.textValue,USER_ACCOUNT,
                                      [AppInfo headInfo],HTTP_HEAD,
                                      nil];
        [self getConfirmCode:param];
        
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

- (void)registerAccount{
    [self showRequestingTips:@"正在注册..."];
    
    [self.params setValue:[AppInfo headInfo] forKeyPath:HTTP_HEAD];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionReister];
    NSURL *url = [NSURL URLWithString:urlString];
    
//    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon11"]);
//    NSString *photoName=[NSString stringWithFormat:@"%@.png",[NSDate date]];
    //照片content
    NSLog(@"url = %@ \n param = %@",urlString,self.params);
    
    NSString *jsonString = [self.params JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionReister,HTTP_USER_INFO, nil];
//    [formRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:USER_IMG];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",dictionary);
    [self.hud removeFromSuperview];

    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionReister isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0];
        }
        else if ([ActionGetConfirmCode isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }

    }
    else{
        if ([ActionReister isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
        else if ([ActionGetConfirmCode isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }

    }
}

#pragma mark - HNYDetailTableViewControllerDelegate
//item值改变的时候，改delegate传出值
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    [self.params setValue:value forKeyPath:key];
}

- (id)createViewWith:(HNYDetailItemModel *)item{
    if ([USER_SEX isEqualToString:item.key]) {
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - self.tableViewController.nameLabelWidth, self.tableViewController.cellHeight)];
        
        self.sexTextField = [[HNYTextField alloc] initWithFrame:CGRectMake(10, self.tableViewController.cellHeight/2 - 10 , self.view.frame.size.width - self.tableViewController.nameLabelWidth, 20)];
        self.sexTextField.backgroundColor = [UIColor clearColor];
        self.sexTextField.textAlignment = NSTextAlignmentLeft;
        self.sexTextField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        self.sexTextField.text = item.textValue;
        self.sexTextField.delegate = self;
        self.sexTextField.backgroundColor = [UIColor clearColor];
        [numView addSubview:self.sexTextField];
        return numView;
    }
    else if ([@"button" isEqualToString:item.key]) {
        UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableViewController.cellHeight*2)];
        
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(10, 5, self.view.frame.size.width - 20, 40);
        [registerBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        registerBtn.titleLabel.font = ButtonTitleFont;
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(touchRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [temp addSubview:registerBtn];
        
        return temp;
    }
   else if ([@"captcha" isEqualToString:item.key]){
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

    return nil;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [HNYPopoverView presentPopoverFromRect:textField.frame inView:textField.superview withTitle:nil withStringAry:self.sexAry delegate:self];
    return NO;
}
#pragma mark - HNYPopoverViewDelegate
// caled when select the String ary
- (void)hNYPopoverView:(HNYPopoverView *)popover didSelectStringAryAtIndex:(NSInteger)index{
    HNYDetailItemModel *item = [self.tableViewController getItemWithKey:USER_SEX];
    item.textValue = [self.sexAry objectAtIndex:index];
    item.value = [NSString stringWithFormat:@"%d",index];
    self.sexTextField.text = item.textValue;
    [self.params setValue:item.value forKeyPath:USER_SEX];
    [popover dismissPopoverAnimated:YES];
}

@end
