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
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *miss;
@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *info;

@end
@implementation BDLuckyDrawViewController{
    float random;
    float startValue;
    float endValue;
    NSDictionary *awards;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        BDCouponModel *coupon = [[BDCouponModel alloc] init];
        coupon.name = @"再接再厉";
        coupon.type = 0;
        
        BDCouponModel *coupon1 = [[BDCouponModel alloc] init];
        coupon1.name = @"一等奖";
        coupon1.type = 1;
        
        BDCouponModel *coupon2 = [[BDCouponModel alloc] init];
        coupon2.name = @"二等奖";
        coupon2.type = 2;
        
        BDCouponModel *coupon3 = [[BDCouponModel alloc] init];
        coupon3.name = @"三等奖";
        coupon3.type = 3;
        
        BDCouponModel *coupon4 = [[BDCouponModel alloc] init];
        coupon4.name = @"特等奖";
        coupon4.type = 4;
        
        //中奖和没中奖之间的分隔线设有2个弧度的盲区，指针不会旋转到的，避免抽奖的时候起争议。
        self.data = [NSArray arrayWithObjects:coupon,coupon1,coupon2,coupon3,coupon4, nil];
        self.miss = @[@{@"min": @47,@"max":@88},
                      @{@"min": @137,@"max":@178},
                      @{@"min": @227,@"max":@268},
                      @{@"min": @317,@"max":@358},];

        awards = [NSDictionary dictionaryWithObjectsAndKeys:
                  @[@{@"min": @2,@"max":@43}],[NSString stringWithFormat:@"%d",coupon1.type],
                  @[@{@"min": @92,@"max":@133}],[NSString stringWithFormat:@"%d",coupon2.type],
                  @[@{@"min": @182,@"max":@223}],[NSString stringWithFormat:@"%d",coupon3.type],
                  @[@{@"min": @272,@"max":@313}],[NSString stringWithFormat:@"%d",coupon4.type],
                  self.miss,[NSString stringWithFormat:@"%d",coupon.type],nil];
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
}

- (IBAction)start:(id)sender {
    if (self.personModel.score < 199) {
        [self showTips:@"您的积分不够200，无法参与抽奖"];
        return;
    }
    if (self.result) {
        [self showTips:@"正在抽奖，请您稍等"];
        return;
    }
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
    if (!self.result){
//        BDCouponModel *coupon = self.data[i];
        BDCouponModel *coupon = self.data[0];
        self.result = [NSString stringWithFormat:@"%d",coupon.type];
    }
//TEST DATA ,shoud fetch result from remote service
//    if (_labelTextField.text != nil && ![_labelTextField.text isEqualToString:@""]) {
//        result = _labelTextField.text;
//    }
    
    if ([@"0" isEqualToString:self.result]) {
        random = rand() %4;
        i = random;
        NSDictionary *content = self.miss[i];
        int min = [content[@"min"] intValue];
        int max = [content[@"max"] intValue];
        
        srand((unsigned)time(0));
        random = rand() % (max - min) +min;
        
        return radians(random + 360*5);
    }
    
    for (NSString *str in [awards allKeys]) {
        if ([str isEqualToString:self.result]) {
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
    NSDictionary *content = self.miss[i];
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
    NSLog(@"result = %@",self.result);
    NSLog(@"endValue = %f\n",endValue);
    self.resultLabel.text = self.info;
    self.result = nil;
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
            self.result = [NSString stringWithFormat:@"%d",coupon.type];
            if (coupon.type == 0) {
                self.info = [NSString stringWithFormat:@"%@",coupon.prize];
            }else{
                BDCouponModel *tmp = [self.data objectAtIndex:coupon.type];
                self.info = [NSString stringWithFormat:@"恭喜您抽中-张%@(%@)",coupon.prize,tmp.name];
            }
            
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
            self.info = [dictionary valueForKey:HTTP_INFO];
    }
}

@end
