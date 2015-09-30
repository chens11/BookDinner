//
//  BDAddressDetailViewController.h
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDAddressModel.h"

@interface BDAddressDetailViewController : HNYBaseViewController
@property (nonatomic,strong) BDAddressModel *addressModel;
@property (nonatomic) BOOL isAddAddress;

@end
