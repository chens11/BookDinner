//
//  BDPayViewController.h
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDPayTableViewCell.h"
#import "AlixLibService.h"
#import "BDOrderModel.h"
#import "BDAlixpay.h"

@interface BDPayViewController : HNYBaseViewController
@property (nonatomic,strong) BDOrderModel *orderModel;

@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。

@end
