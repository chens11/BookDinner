//
//  HNYTJSONViewController.m
//  Demo
//
//  Created by chenzq on 5/13/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTJSONViewController.h"
#import "HNTTestModel.h"
#import "JSON.h"
#import "HNYJSONUitls.h"

@interface HNYTJSONViewController ()

@end

@implementation HNYTJSONViewController

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
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"id",[NSArray arrayWithObjects:@"fjkds",@"fddddslj", nil],@"list",[NSNumber numberWithInt:222],@"number", nil];
    NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"id",[NSArray arrayWithObjects:dictionary,dictionary, nil],@"list",[NSNumber numberWithInt:222],@"number", nil];

    
    HNTTestModel *test = [HNYJSONUitls mappingDictionary:object toObjectWithClassName:@"HNTTestModel"];
    HNTTestModel *model = [[HNTTestModel alloc] init];
    [HNYJSONUitls mappingDictionary:object toObject:model];
    
//    NSString *jsonString = [dictionary JSONRepresentation];
//    NSDictionary *jsonDic = [jsonString JSONValue];
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

@end
