//
//  BDChangePasswordViewController.m
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDChangePasswordViewController.h"
#import "HNYDetailTableViewController.h"

@interface BDChangePasswordViewController ()<UITextFieldDelegate,HNYDetailTableViewControllerDelegate>
@property (nonatomic,strong) UITextField *oldPasswordField;
@property (nonatomic,strong) UITextField *newpPasswordField;
@property (nonatomic,strong) UITextField *passwordConformField;

@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;


@end

@implementation BDChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    self.title = @"修改密码";
    [self createTable];
    [self setContent];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(10, self.naviBar.frame.size.height + 155, self.view.frame.size.width - 20, 40);
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"提交修改密码" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(touchSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark - create subview
- (void)createTable{
    self.tableViewController = [[HNYDetailTableViewController alloc] init];
    self.tableViewController.delegate = self;
    self.tableViewController.customDelegate = self;
    self.tableViewController.nameLabelWidth = 100;
    self.tableViewController.nameTextAlignment = NSTextAlignmentLeft;
    self.tableViewController.cellHeight = 50;
    self.tableViewController.cellBackGroundColor = [UIColor whiteColor];
    [self addChildViewController:self.tableViewController];
    self.tableViewController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.tableViewController.cellHeight * 4);
    [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:self.tableViewController.view];
    [self addChildViewController:self.tableViewController];
}

- (void)setContent{
    
    HNYDetailItemModel *passwordItem = [[HNYDetailItemModel alloc] init];
    passwordItem.viewType = TextField;
    passwordItem.editable = YES;
    passwordItem.key = KUSER_PASSWORD;
    passwordItem.secureTextEntry = YES;
    passwordItem.placeholder = @"请您输入原密码";
    passwordItem.name = @"  原始密码";
    passwordItem.height = @"one";
    [_viewAry addObject:passwordItem];
    
    HNYDetailItemModel *newItem = [[HNYDetailItemModel alloc] init];
    newItem.viewType = TextField;
    newItem.editable = YES;
    newItem.name = @"  新密码 ";
    newItem.secureTextEntry = YES;
    newItem.placeholder = @"请您输入新密码";
    newItem.key = KUSER_NEW_PASSWORD;
    newItem.height = @"one";
    [_viewAry addObject:newItem];
    
    HNYDetailItemModel *confirmItem = [[HNYDetailItemModel alloc] init];
    confirmItem.viewType = TextField;
    confirmItem.editable = YES;
    confirmItem.height = @"one";
    confirmItem.key = KUSER_CONFIRM_PASSWORD;
    confirmItem.name = @"  确认密码";
    confirmItem.secureTextEntry = YES;
    confirmItem.placeholder = @"请您输入确认密码";
    [_viewAry addObject:confirmItem];
    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}
#pragma mark - HNYDetailTableViewControllerDelegate

#pragma mark - IBAction
- (void)touchSaveButton:(UIButton*)sender{
    [self.view endEditing:YES];
    HNYDetailItemModel *oldItem = [self.tableViewController getItemWithKey:KUSER_PASSWORD];
    HNYDetailItemModel *newItem = [self.tableViewController getItemWithKey:KUSER_NEW_PASSWORD];
    HNYDetailItemModel *confirmItem = [self.tableViewController getItemWithKey:KUSER_CONFIRM_PASSWORD];

    if (!oldItem.value) {
        [self showTips:@"请您输入旧密码"];
        return;
    }
    
    if (!newItem.value) {
        [self showTips:@"请您输入新密码"];
        return;
    }
    
    if (!confirmItem.value) {
        [self showTips:@"请您输入确认密码"];
        return;
    }
    if (![newItem.value isEqualToString:confirmItem.value]) {
        [self showTips:@"请您输入相同的新密码"];
        return;
        
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:oldItem.value forKey:@"old_password"];
    [dictionary setValue:newItem.value forKey:KUSER_NEW_PASSWORD];
    [dictionary setValue:confirmItem.value forKey:KUSER_CONFIRM_PASSWORD];
    [dictionary setValue:[AppInfo headInfo] forKey:HTTP_HEAD];

    [self changePassword:dictionary];
}

#pragma mark - http request
- (void)changePassword:(NSDictionary*)param{
    [self showRequestingTips:@"正在修改密码..."];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",KAPI_ServerUrl,KAPI_ActionChangePassWord];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:KAPI_ActionChangePassWord,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    [self.hud removeFromSuperview];
    NSLog(@"result = %@",dictionary);
    
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([KAPI_ActionChangePassWord isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KAPPINFO_RememberPassWord];
            HNYDetailItemModel *newItem = [self.tableViewController getItemWithKey:KUSER_NEW_PASSWORD];

            if ([[NSUserDefaults standardUserDefaults] boolForKey:KAPPINFO_RememberPassWord])
                [[NSUserDefaults standardUserDefaults] setValue:newItem.value forKey:KUSER_PASSWORD];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0];
        }
    }
    else{
        if ([KAPI_ActionChangePassWord isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
        }
    }
}

@end
