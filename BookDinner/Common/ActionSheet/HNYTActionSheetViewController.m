//
//  HNYTActionSheetViewController.m
//  Demo
//
//  Created by chenzq on 4/30/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTActionSheetViewController.h"
#import "HNYActionSheet.h"
#import "HNYPopoverView.h"

@interface HNYTActionSheetViewController ()
<HNYActionSheetDelegate,
HNYPopoverViewDelegate,
UIActionSheetDelegate>

@property (nonatomic,strong) HNYActionSheet *sheet;
@property (nonatomic,strong) HNYPopoverView *popover;

@end

@implementation HNYTActionSheetViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 7; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1;
        button.frame = CGRectMake(20,self.navigationController.navigationBar.frame.size.height + 20 + 60*i, self.view.frame.size.width - 40, 40);
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    if (sender.tag == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor whiteColor];
        if (self.sheet)
            [self.sheet show];
        else
            self.sheet = [HNYActionSheet showWithTitle:@"Test ActionSheet With Content View" contentView:label cancelBtnTitle:@"Cancel" sureBtnTitle:@"Sure" delegate:self];
    }
    else if (sender.tag == 1) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.text = @"add custom view here";
        label.backgroundColor = [UIColor whiteColor];
        [HNYActionSheet showWithTitle:nil contentView:label cancelBtnTitle:nil sureBtnTitle:nil delegate:self];
    }
    else if (sender.tag == 2) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i< 5; i++) {
            NSString *string = [NSString stringWithFormat:@"%@ + %d",[NSDate date],i];
            [array addObject:string];
        }
        [HNYActionSheet showWithTitle:@"test string ary" withStringAry:array cancelBtnTitle:@"cancel" sureBtnTitle:@"sure" delegate:self];
    }
    else if (sender.tag == 3) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor blackColor];
        if (self.popover) {
        }
//        self.popover = [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view  withText:@"implemented -[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:], but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" delegate:self];
        self.popover = [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view withTitle:@"test" withText:@"implemented -[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:], but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" delegate:self];
    }
    else if (sender.tag == 4) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 280, 200);
        label.numberOfLines =5;
        label.text = @"add custom view here";
        label.backgroundColor = [UIColor clearColor];
//        [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view withContentView:label delegate:self];
        [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view withTitle:@"but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" withContentView:label delegate:self];
    }
    
    else if (sender.tag == 5) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i< 5; i++) {
            NSString *string = [NSString stringWithFormat:@"%@ + %d",[NSDate date],i];
            [array addObject:string];
        }
        [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view withTitle:nil withStringAry:array delegate:self];
//        [HNYPopoverView presentPopoverFromRect:sender.frame inView:self.view withTitle:@"test" withStringAry:array delegate:self];
    }

    else if (sender.tag == 6) {
    }


}


@end
