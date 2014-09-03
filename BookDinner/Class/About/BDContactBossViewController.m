//
//  BDContactBossViewController.m
//  BookDinner
//
//  Created by zqchen on 17/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDContactBossViewController.h"

@interface BDContactBossViewController ()<HNYRefreshTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HNYRefreshTableViewController *tableController;
@property (nonatomic,strong) BDContactBossInputView *inputView;
@property (nonatomic,strong) NSString *sendMsg;

@end

@implementation BDContactBossViewController

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
    self.title = @"联系老板";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.inputView = [[BDContactBossInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 55, self.view.frame.size.width, 55)];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];

    
    self.tableController = [[HNYRefreshTableViewController alloc] init];
    self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.inputView.frame.size.height);
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    self.tableController.tableView.separatorColor = [UIColor clearColor];
    self.tableController.view.backgroundColor = [UIColor clearColor];
    self.tableController.enbleFooterLoad = NO;
    self.tableController.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableController.delegate = self;
    self.tableController.pageNum = 1;
    self.tableController.pageSize = 20;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
//    for (int i = 0; i < 4 ; i++) {
//        [self.tableController.list addObject:[NSString stringWithFormat:@"联系老板联系老板联系老板联系老板联系老板联系老板联系老板联系老板联系老板联系老板联系老板联系老板%@",[NSDate date]]];
//    }
    
    [self getMessage];
    [self.tableController.tableView reloadData];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
#pragma mark - UITableViewDataSource,UITableViewDelegate,UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableController scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableController.list.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BDContactMessageModel *model = [self.tableController.list objectAtIndex:indexPath.row];
    NSString *string = model.message;
    if (model.type == 1)
        string = model.admin_reply;
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake(self.view.frame.size.width - 65, 999) lineBreakMode:NSLineBreakByWordWrapping];
    size.height = size.height + 30;
    return size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"BDCouponTableViewCell";
    BDContactBossTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BDContactBossTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell iniDataWithModel:[self.tableController.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}


#pragma mark - HNYRefreshTableViewControllerDelegate
- (void)pullDownTable{
    self.tableController.pageNum += 1;
    self.tableController.loadType = 1;
    [self getMessage];
}

- (void)pullUpTable{
    for (int i = 0; i < 5 ; i++) {
        [self.tableController.list addObject:[NSString stringWithFormat:@"%@",[NSDate date]]];
    }
    self.tableController.footerIsLoading = NO;
    [self.tableController.tableView reloadData];
    
}
- (NSString *)descriptionOfTableCellAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableController.list objectAtIndex:indexPath.row];
}

#pragma mark - UIKeyboardWillShowNotification,UIKeyboardWillHideNotification
- (void)keyboardShow:(NSNotification*)fication{
//    CGRect rect = [[fication valueForKey:@"userInfo"] valueForKey:@"UIKeyboardBoundsUserInfoKey"] ;
    NSValue *value = [[fication valueForKey:@"userInfo"] valueForKey:@"UIKeyboardBoundsUserInfoKey"] ;
    CGRect rect = value.CGRectValue;
    [UIView animateWithDuration:0.05 animations:^{
        self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.inputView.frame.size.height - rect.size.height);
        self.inputView.frame = CGRectMake(0, self.view.frame.size.height - self.inputView.frame.size.height - rect.size.height, self.view.frame.size.width, self.inputView.frame.size.height);

    }];
}
- (void)keyboardHide:(NSNotification*)fication{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableController.view.frame = CGRectMake(0, self.naviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.naviBar.frame.size.height - self.inputView.frame.size.height);
        self.inputView.frame = CGRectMake(0, self.view.frame.size.height - self.inputView.frame.size.height, self.view.frame.size.width, self.inputView.frame.size.height);
        
    }];

}

#pragma mark - http request
- (void)getMessage{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:self.tableController.pageNum],@"pagenum",
                                  [NSNumber numberWithInt:self.tableController.pageSize],@"pagesize",
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionGetMessage];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionGetMessage,HTTP_USER_INFO, nil];
    [formRequest appendPostData:data];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}
- (void)addMessage:(NSString*)msg{
    [self showRequestingTips:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  msg,@"message",
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,
                                  nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionAddMessage];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionAddMessage,HTTP_USER_INFO, nil];
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
        if ([ActionGetMessage isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSArray *array = [dictionary valueForKey:@"value"];
            self.tableController.headerIsUpdateing = NO;
            if (self.tableController.loadType == 0) {
                for (int i = array.count - 1; i > -1; i--) {
                    BDContactMessageModel *model = [HNYJSONUitls mappingDictionary:[array objectAtIndex:i] toObjectWithClassName:@"BDContactMessageModel"];
                    BDContactMessageModel *bossModel = [HNYJSONUitls mappingDictionary:[array objectAtIndex:i] toObjectWithClassName:@"BDContactMessageModel"];
                    
                        [self.tableController.list addObject:model];
                        if (bossModel.admin_reply.length > 0) {
                            bossModel.type = 1;
                            [self.tableController.list addObject:bossModel];
                        }
                }
                [self.tableController.tableView reloadData];
                if (array.count > 1) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tableController.list.count - 1 inSection:0];
                    [self.tableController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            }
            else{
                for (int i = 0; i < array.count; i++) {
                    BDContactMessageModel *model = [HNYJSONUitls mappingDictionary:[array objectAtIndex:i] toObjectWithClassName:@"BDContactMessageModel"];
                    BDContactMessageModel *bossModel = [HNYJSONUitls mappingDictionary:[array objectAtIndex:i] toObjectWithClassName:@"BDContactMessageModel"];
                    
                    if (bossModel.admin_reply.length > 0) {
                        bossModel.type = 1;
                        [self.tableController.list insertObject:bossModel atIndex:0];
                    }
                    [self.tableController.list insertObject:model atIndex:0];

                }
                [self.tableController.tableView reloadData];
            }

            

            if (array.count < self.tableController.pageSize)
                self.tableController.enbleHeaderRefresh = NO;
            else
                self.tableController.enbleHeaderRefresh = YES;
        }
       else if ([ActionAddMessage isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            BDContactMessageModel *model = [[BDContactMessageModel alloc] init];
            model.message = self.sendMsg;
            [self.tableController.list addObject:model];
            [self.tableController.tableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tableController.list.count - 1 inSection:0];
            [self.tableController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    //token is out of date login again
    else if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 2){
        [self showTips:[dictionary valueForKey:HTTP_INFO]];
        [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
    }

    else{
        if ([ActionAddMessage isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            [self showTips:[dictionary valueForKey:HTTP_INFO]];
            self.inputView.msgTextView.text = self.sendMsg;
        }
        else if ([ActionGetMessage isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
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


#pragma mark - HNYDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    if ([aView isEqual:self.inputView]) {
        NSString *string = [info valueForKey:@"message"];
        self.sendMsg = string;
        [self addMessage:string];
    }
}

@end
