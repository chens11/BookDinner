//
//  BDOrderModel.h
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDOrderModel : HNYModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic) int id;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *paytime;
//（0待付款，1已付款，2派送中，3成交，4失效）
@property (nonatomic) int state;
@property (nonatomic,strong) NSString *stateName;
@property (nonatomic) int order_number;

@end
