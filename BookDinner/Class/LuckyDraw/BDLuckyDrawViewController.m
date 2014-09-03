//
//  BDLuckyDrawViewController.m
//  BookDinner
//
//  Created by zqchen on 7/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDLuckyDrawViewController.h"

@interface BDLuckyDrawViewController ()

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
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, self.view.frame.size.height - 100, 80, 44)];
    [self.view addSubview:self.label1];
    
    self.labelTextField = [[HNYTextField alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 100, self.view.frame.size.width - 160, 44)];
    self.labelTextField.placeholder = @"请输入要抽中的奖项";
    [self.view addSubview:self.labelTextField];
    
    
    self.plateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, self.view.frame.size.width, self.view.frame.size.width)];
    self.plateImageView.contentMode = UIViewContentModeScaleToFill;
    self.plateImageView.image = [UIImage imageNamed:@"ly-plate"];
    [self.view addSubview:self.plateImageView];
    
    self.rotateStaticImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 136, 250, 250)];
    self.rotateStaticImageView.contentMode = UIViewContentModeScaleToFill;
    self.rotateStaticImageView.image = [UIImage imageNamed:@"rotate-static"];
    [self.view addSubview:self.rotateStaticImageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(108, 158, 105, 105);
    [button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
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

-(float)fetchResult{
    
    //todo: fetch result from remote service
    srand((unsigned)time(0));
    random = rand() %4;
    int i = random;
    result = data[i];  //TEST DATA ,shoud fetch result from remote service
    if (_labelTextField.text != nil && ![_labelTextField.text isEqualToString:@""]) {
        result = _labelTextField.text;
    }
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
    _label1.text = result;
    NSLog(@"endValue = %f\n",endValue);
}

@end
