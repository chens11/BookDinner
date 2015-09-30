//
//  BDOrderDetailViewController.h
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDAddressModel.h"
#import "BDLoginViewController.h"
#import "BDPayViewController.h"
#import "BDOrderModel.h"

@interface BDOrderDetailViewController : HNYBaseViewController
@property (nonatomic,strong) BDOrderModel *orderModel;
@property (nonatomic) BOOL editAble;
//（0待付款，1已付款，2派送中，3成交，4失效）
@property (nonatomic,strong) NSString *orderState;

@end
