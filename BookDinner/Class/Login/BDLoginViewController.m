//
//  BDLoginViewController.m
//  HBSmartCity
//
//  Created by zqchen on 4/6/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import "BDLoginViewController.h"
#import "HNYCheckButton.h"
#import "PXAlertView.h"
#import "BDRegisterViewController.h"

@interface BDLoginViewController ()<UITextFieldDelegate,HNYCheckButtonDelegate>
@property (nonatomic,strong) HNYCheckButton *rememberBtn;
@property (nonatomic,strong) HNYCheckButton *autoBtn;
@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) NSString *forgetAccount;

@end

@implementation BDLoginViewController

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
    self.title = @"会员登录";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,self.naviBar.frame.size.height + 5, self.view.frame.size.width - 10, 150)];

    imageView.image = [[UIImage imageNamed:@"ic_forget_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    
    UIImageView *loginImagView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.naviBar.frame.size.height + 20, self.view.frame.size.width - 40, 90)];
    loginImagView.image = [UIImage imageNamed:@"login_back"];
    loginImagView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:loginImagView];
    
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(95, self.naviBar.frame.size.height + 28, 200, 30)];
    self.userNameField.placeholder = @"请您输入手机号码";
    self.userNameField.backgroundColor = [UIColor clearColor];
    self.userNameField.tag = 0;
    self.userNameField.delegate = self;
    [self.view addSubview:self.userNameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(95, self.naviBar.frame.size.height + 70, 200, 30)];
    self.passwordField.placeholder = @"请您输入密码";
    self.passwordField.backgroundColor = [UIColor clearColor];
    self.passwordField.delegate = self;
    self.passwordField.tag = 1;
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:RememberPassWord]) {
        self.userNameField.text = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ACCOUNT];
        self.passwordField.text = [[NSUserDefaults standardUserDefaults] valueForKey:USER_PASSWORD];
    }

    
    NSNumber *remNum = [NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:RememberPassWord]];
    NSMutableDictionary *rememberDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"记住密码",@"name",remNum,@"value",@"remember",@"id", nil];
    self.rememberBtn = [[HNYCheckButton alloc] initWithFrame:CGRectMake(20, self.naviBar.frame.size.height + 115, 100, 30)];
    self.rememberBtn.delegate = self;
    self.rememberBtn.exTag = 0;
    [self.rememberBtn setUpWithObject:rememberDic];
    [self.view addSubview:self.rememberBtn];
    
    NSNumber *autNum = [NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:AutoLogin]];
    NSMutableDictionary *autoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"自动登录",@"name",autNum,@"value",@"auto",@"id", nil];
    self.autoBtn = [[HNYCheckButton alloc] initWithFrame:CGRectMake(150, self.naviBar.frame.size.height + 115, 100, 30)];
    self.autoBtn.delegate = self;
    self.autoBtn.exTag = 1;
    [self.autoBtn setUpWithObject:autoDic];
    [self.view addSubview:self.autoBtn];


    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(5, self.naviBar.frame.size.height + 160, self.view.frame.size.width - 10, 40);
    [loginBtn setBackgroundColor:ButtonNormalColor];
    loginBtn.titleLabel.font = ButtonTitleFont;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(touchLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];

    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [forgetBtn setBackgroundImage:[[UIImage imageNamed:@"ic_login_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    forgetBtn.frame = CGRectMake(5, self.naviBar.frame.size.height + 205, (self.view.frame.size.width - 20)/2, 40);
    [forgetBtn setBackgroundColor:ButtonNormalColor];
    forgetBtn.titleLabel.font = ButtonTitleFont;
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(touchForgetButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];

 
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake((self.view.frame.size.width - 20)/2 + 15, self.naviBar.frame.size.height + 205, (self.view.frame.size.width - 20)/2, 40);
    registerBtn.titleLabel.font = ButtonTitleFont;
    [registerBtn setBackgroundColor:ButtonNormalColor];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(touchRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        if (textField.text.length != 0) {
            [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:USER_ACCOUNT];
        }
    }
    else if (textField.tag == 1){
        if (textField.text.length != 0) {
            [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:USER_PASSWORD];
        }
    }
}

#pragma mark - IBAction 
- (void)touchLoginButton:(UIButton*)sender{
    [self.view endEditing:YES];
    if (self.userNameField.text.length == 0) {
        [self showTips:@"请您输入账号"];
        return;

    }
    if (![AppInfo isValidateMobile:self.userNameField.text]) {
        [self showTips:@"请输入正确的手机号码"];
        return;
    }

    if (self.passwordField.text.length == 0) {
        [self showTips:@"请您输入密码"];
        return;
    }
    [self login];
}

- (void)touchForgetButton:(UIButton*)sender{
    [self.view endEditing:YES];
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(10, 6, AlertViewWidth - 20, 30)];
    userField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    userField.placeholder = @"请输入账号";
    userField.backgroundColor = [UIColor colorWithWhite:125 alpha:0.5];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertViewWidth, 44)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:userField];
    [PXAlertView showAlertWithTitle:@"找回密码" message:nil cancelTitle:@"取消" otherTitle:@"发送密码到手机" contentView:view completion:^(BOOL cancelled) {
        if (!cancelled) {
            if (userField.text.length == 0) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.margin = 10.f;
                hud.yOffset = 80.f;
                hud.removeFromSuperViewOnHide = YES;
                hud.labelText = @"请您输入账号!";
                [hud hide:YES afterDelay:2];
                
            }
            else{
                self.forgetAccount = userField.text;
                [self getNewPassWord];
            }
        }
    }];
}

- (void)touchRegisterButton:(UIButton*)sender{
    [self.view endEditing:YES];
    BDRegisterViewController *controller = [[BDRegisterViewController alloc] init];
    controller.customNaviController = self.customNaviController;
    [self.customNaviController pushViewController:controller animated:YES];
}

#pragma mark - HNYCheckButtonDelegate
- (void)checkButton:(HNYCheckButton *)checkButton selectedBySender:(UIButton *)sender{
    if (checkButton.exTag == 1) {
        [[NSUserDefaults standardUserDefaults] setBool:checkButton.selected forKey:AutoLogin];
        if (checkButton.selected == YES) {
            self.rememberBtn.selected = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:RememberPassWord];
        }
    }
    else if (checkButton.exTag == 0){
        [[NSUserDefaults standardUserDefaults] setBool:checkButton.selected forKey:RememberPassWord];
        if (checkButton.selected == NO) {
            self.autoBtn.selected = NO;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PASSWORD];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:AutoLogin];
        }
    }
}

#pragma mark - http request

- (void)login{
    
    [self showRequestingTips:@"正在登录..."];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  self.userNameField.text,USER_ACCOUNT,
                                  self.passwordField.text,USER_PASSWORD,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionLogin];
    NSURL *url = [NSURL URLWithString:urlString];    
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionLogin,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];

}

- (void)getNewPassWord{
//    [self showRequestingTips:nil];
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.forgetAccount,@"ACCOUNT",nil];
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionLoginActionCheckAccountPhone];
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSLog(@"url = %@ \n param = %@",urlString,param);
//    
//    NSString *jsonString = [param JSONRepresentation];
//    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *base64Data = [[data base64EncodedString] dataUsingEncoding:NSUTF8StringEncoding];
//    
//    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
//    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionLoginActionCheckAccountPhone,@"userInfo", nil];
//    [formRequest appendPostData:base64Data];
//    [formRequest setDelegate:self];
//    [formRequest startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",string);
    [self.hud removeFromSuperview];

    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionLogin isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationActionLogin object:nil userInfo:nil ];

            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IS_LOGIN];
            [[NSUserDefaults standardUserDefaults] setValue:self.userNameField.text forKey:USER_ACCOUNT];
            [[NSUserDefaults standardUserDefaults] setValue:[dictionary objectForKey:HTTP_TOKEN] forKey:HTTP_TOKEN];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([ActionLogin isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];

        }
    }

}

- (void)popViewController{
    [self.customNaviController popViewControllerAnimated:YES];
}

@end
