//
//  BDAlixpay.m
//  BookDinner
//
//  Created by zqchen on 24/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAlixpay.h"

@implementation BDAlixpay

#pragma mark -
#pragma mark - alipay

+ (NSString*)getOrderInfo:(BDOrderModel*)model{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [NSString stringWithFormat:@"%d",model.id];//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = model.title; //商品标题
    order.productDescription = @"ddd";//self.orderModel.description; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[model.pricemoney floatValue]]; //商品价格
    order.notifyURL =  NotifyURL; //回调URL
    
    return [order description];
}

+ (NSString*)doRsa:(NSString*)orderInfo{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

@end
