//
//  BDOrderModel.h
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"
#import "BDCouponModel.h"
#import "BDDinnerModel.h"
#import "BDAddressModel.h"

@interface BDOrderModel : HNYModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *order_date;
@property (nonatomic) int id;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *paytime;
@property (nonatomic,strong) NSString *pricemoney;
//（0待付款，1已付款，2派送中，3成交，4失效）
@property (nonatomic) int state;
@property (nonatomic,strong) NSString *stateName;
@property (nonatomic) int order_number;
@property (nonatomic,strong) BDCouponModel *ticker;
@property (nonatomic,strong) BDDinnerModel *product;
@property (nonatomic,strong) BDAddressModel *address;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic) int using;
// ： 退款状态（0无，1有退款，2不同意退款，3等买家退货，4等卖家收货，5退款成功，6退款关闭）
@property (nonatomic) int state_refund;
@property (nonatomic,strong) NSString *state_refund_name;
@end
