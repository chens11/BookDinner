//
//  BDOrderDetailViewController.h
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDDinnerModel.h"
#import "BDAddressModel.h"
#import "BDLoginViewController.h"
#import "BDPayViewController.h"
#import "BDOrderModel.h"

@interface BDOrderDetailViewController : HNYBaseViewController
@property (nonatomic,strong) BDDinnerModel *dinnerModel;
@property (nonatomic,strong) BDAddressModel *addressModel;
@property (nonatomic,strong) BDCouponModel *couponModel;
@property (nonatomic) BOOL editAble;

@end
