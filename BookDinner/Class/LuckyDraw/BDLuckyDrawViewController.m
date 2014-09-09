//
//  BDLuckyDrawViewController.m
//  BookDinner
//
//  Created by zqchen on 7/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDLuckyDrawViewController.h"

@interface BDLuckyDrawViewController ()
@property (strong, nonatomic) UILabel *pointLabel;
@property (strong, nonatomic) UILabel *resultLabel;

@end
@implementation BDLuckyDrawViewController{
    float random;
    float startValue;
    float endValue;
    NSDictionary *awards;
    NSArray *miss;
    NSArray *data;
    NSString *result;
}

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
    self.title = @"幸运大转盘";
    
    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.naviBar.frame.size.height, self.view.frame.size.width - 10, 30)];
    self.pointLabel.backgroundColor = [UIColor clearColor];
    self.pointLabel.text = [NSString stringWithFormat:@"我的积分: %d",self.personModel.score];
    [self.view addSubview:self.pointLabel];

    self.plateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*5/6, self.view.frame.size.width*5/6)];
    self.plateImageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.width*1/2 + self.naviBar.frame.size.height);
    self.plateImageView.contentMode = UIViewContentModeScaleToFill;
    self.plateImageView.image = [UIImage imageNamed:@"ly-plate"];
    [self.view addSubview:self.plateImageView];
    
    self.rotateStaticImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.width/2)];
    self.rotateStaticImageView.center = self.plateImageView.center;
    self.rotateStaticImageView.contentMode = UIViewContentModeScaleToFill;
    self.rotateStaticImageView.image = [UIImage imageNamed:@"rotate-static"];
    [self.view addSubview:self.rotateStaticImageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(108, 158, 105, 105);
    [button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.plateImageView.frame.origin.y + self.plateImageView.frame.size.height + 10, self.view.frame.size.width - 10, 80)];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.resultLabel.backgroundColor = [UIColor clearColor];
    self.resultLabel.text = @"抽奖规则:大转盘是采用用户积分消耗来抽奖领取优惠券，200积分一次抽奖";
    [self.view addSubview:self.resultLabel];
    


    
    data = @[@"一等奖",@"二等奖",@"三等奖",@"再接再厉"];
    
    //中奖和没中奖之间的分隔线设有2个弧度的盲区，指针不会旋转到的，避免抽奖的时候起争议。
    miss = @[
             @{@"min": @47,
               @"max":@89
               },
             @{@"min": @90,
               @"max":@133
               },
             @{@"min": @182,
               @"max":@223
               },
             @{@"min": @272,
               @"max":@314
               },
             @{@"min": @315,
               @"max":@358
               }
             ];
    
    
    awards = @{
               @"一等奖": @[
                       @{
                           @"min": @137,
                           @"max":@178
                           }
                       ],
               @"二等奖": @[
                       @{
                           @"min": @227,
                           @"max":@268
                           }
                       ],
               @"三等奖": @[
                       @{
                           @"min": @2,
                           @"max":@43
                           }
                       ],
               @"再接再厉":miss
               };
    
}

- (IBAction)start:(id)sender {
    [self luckDraw];
    
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    endValue = [self fetchResult];
//    rotationAnimation.delegate = self;
//    rotationAnimation.fromValue = @(startValue);
//    rotationAnimation.toValue = @(endValue);
//    rotationAnimation.duration = 2.0f;
//    rotationAnimation.autoreverses = NO;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    rotationAnimation.removedOnCompletion = NO;
//    rotationAnimation.fillMode = kCAFillModeBoth;
//    [_rotateStaticImageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

-(float)fetchResult{
    
    //todo: fetch result from remote service
    srand((unsigned)time(0));
    random = rand() %4;
    int i = random;
    result = data[i];  //TEST DATA ,shoud fetch result from remote service
//    if (_labelTextField.text != nil && ![_labelTextField.text isEqualToString:@""]) {
//        result = _labelTextField.text;
//    }
    for (NSString *str in [awards allKeys]) {
        if ([str isEqualToString:result]) {
            NSDictionary *content = awards[str][0];
            int min = [content[@"min"] intValue];
            int max = [content[@"max"] intValue];
            
            
            srand((unsigned)time(0));
            random = rand() % (max - min) +min;
            
            return radians(random + 360*5);
        }
    }
    
    random = rand() %5;
    i = random;
    NSDictionary *content = miss[i];
    int min = [content[@"min"] intValue];
    int max = [content[@"max"] intValue];
    
    srand((unsigned)time(0));
    random = rand() % (max - min) +min;
    
    return radians(random + 360*5);
    
}

//角度转弧度
double radians(float degrees) {
    return degrees*M_PI/180;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    startValue = endValue;
    if (startValue >= endValue) {
        startValue = startValue - radians(360*10);
    }
    
    NSLog(@"startValue = %f",startValue);
    NSLog(@"result = %@",result);
    NSLog(@"endValue = %f\n",endValue);
    self.resultLabel.text = result;
}
#pragma mark - http request

- (void)luckDraw{
    self.resultLabel.text = @"正在抽奖...";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[NSUserDefaults standardUserDefaults] valueForKey:HTTP_TOKEN],HTTP_TOKEN,
                                  [AppInfo headInfo],HTTP_HEAD,nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ServerUrl,ActionLuckyDraw];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@ \n param = %@",urlString,param);
    
    NSString *jsonString = [param JSONRepresentation];
    NSData *pData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    formRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ActionLuckyDraw,HTTP_USER_INFO, nil];
    [formRequest appendPostData:pData];
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string =[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [string JSONValue];
    NSLog(@"result = %@",string);
    [self.hud removeFromSuperview];
    if ([[dictionary objectForKey:HTTP_RESULT] intValue] == 1) {
        if ([ActionLuckyDraw isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]]) {
            NSDictionary *value = [dictionary valueForKey:@"value"];
            self.personModel.score = [[value valueForKey:@"scroe"] intValue];
            self.pointLabel.text = [NSString stringWithFormat:@"我的积分: %d",self.personModel.score];
            [self.delegate viewController:self actionWitnInfo:nil];
            
            BDCouponModel *coupon = [HNYJSONUitls mappingDictionary:value toObjectWithClassName:@"BDCouponModel"];
            result = [NSString stringWithFormat:@"%@",[dictionary valueForKey:HTTP_INFO]];

            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            endValue = [self fetchResult];
            rotationAnimation.delegate = self;
            rotationAnimation.fromValue = @(startValue);
            rotationAnimation.toValue = @(endValue);
            rotationAnimation.duration = 2.0f;
            rotationAnimation.autoreverses = NO;
            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            rotationAnimation.removedOnCompletion = NO;
            rotationAnimation.fillMode = kCAFillModeBoth;
            [_rotateStaticImageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
        }
    }
    
    else{
        if ([ActionGetOrderList isEqualToString:[request.userInfo objectForKey:HTTP_USER_INFO]])
            result = [dictionary valueForKey:HTTP_INFO];
    }
}

@end
