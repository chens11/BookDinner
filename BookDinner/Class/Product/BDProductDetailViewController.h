//
//  BDProductDetailViewController.h
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDProductModel.h"

@interface BDProductDetailViewController : HNYBaseViewController
@property (nonatomic,strong) BDProductModel *product;
@property (nonatomic,strong) NSMutableArray *products;

@end
