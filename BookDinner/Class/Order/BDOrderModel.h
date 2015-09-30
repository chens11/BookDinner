//
//  BDOrderModel.h
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"
#import "BDCouponModel.h"
#import "BDProductModel.h"
#import "BDAddressModel.h"

@interface BDOrderModel : HNYModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *order_date;
@property (nonatomic,strong) NSString *ids;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *paytime;
@property (nonatomic,strong) NSString *price;//订单价格
//（0待付款，1已付款，2派送中，3成交，4失效）
@property (nonatomic) NSInteger state;
@property (nonatomic,strong) NSString *stateName;
@property (nonatomic) int order_number;
@property (nonatomic,strong) NSString *ticker_id;
@property (nonatomic,strong) NSString *ticker_money;
@property (nonatomic,strong) NSString *ticker_name;
@property (nonatomic,strong) NSMutableArray *product;
@property (nonatomic,strong) BDAddressModel *address;
@property (nonatomic,strong) BDCouponModel *ticker;

@property (nonatomic,strong) NSString *address_address;
@property (nonatomic) NSInteger address_id;
@property (nonatomic,strong) NSString *address_name;
@property (nonatomic,strong) NSString *address_tel;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic) int using;
// ： 退款状态（0无，1有退款，2不同意退款，3等买家退货，4等卖家收货，5退款成功，6退款关闭）
@property (nonatomic) NSInteger state_refund;
@property (nonatomic,strong) NSString *state_refund_name;
//0 菜单订单 1充值订单
@property (nonatomic) int type;
@property (nonatomic,strong) NSString *descriptions;

@end
