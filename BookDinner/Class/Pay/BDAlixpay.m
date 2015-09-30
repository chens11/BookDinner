//
//  BDAlixpay.m
//  BookDinner
//
//  Created by zqchen on 24/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAlixpay.h"
#import "DataSigner.h"

@implementation BDAlixpay

#pragma mark -
#pragma mark - alipay

+ (NSString*)getOrderInfo:(BDOrderModel*)model{
    
    NSMutableString * discription = [NSMutableString string];
    [discription appendFormat:@"partner=\"%@\"", PartnerID];
    
    [discription appendFormat:@"&seller_id=\"%@\"", SellerID];
    
    [discription appendFormat:@"&out_trade_no=\"%@\"", model.ids];
    
    [discription appendFormat:@"&subject=\"%@\"", model.title];
    
    [discription appendFormat:@"&body=\"%@\"", model.product.description];
    
    [discription appendFormat:@"&total_fee=\"%@\"", [NSString stringWithFormat:@"%.2f",[model.price floatValue]]];
    
    [discription appendFormat:@"&notify_url=\"%@\"", NotifyURL];
    
    [discription appendFormat:@"&service=\"%@\"",@"mobile.securitypay.pay"];
    
    [discription appendFormat:@"&payment_type=\"%@\"",@1];//1
    
    [discription appendFormat:@"&_input_charset=\"%@\"",@"utf-8"];//utf-8
    
    [discription appendFormat:@"&it_b_pay=\"%@\"",@"30m"];//30m
    
    [discription appendFormat:@"&show_url=\"%@\"",@"m.alipay.com"];//m.alipay.com

//    if (self.rsaDate) {
//        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
//    }
//    if (self.appID) {
//        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
//    }
//    for (NSString * key in [self.extraParams allKeys]) {
//        [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
//    }

    /*
     *点击获取prodcut实例并初始化订单信息
     */
//    AlixPayOrder *order = [[AlixPayOrder alloc] init];
//    order.partner = PartnerID;
//    order.seller = SellerID;
//    order.tradeNO = [NSString stringWithFormat:@"%@",model.ids];//[self generateTradeNO]; //订单ID（由商家自行制定）
//    //1表示充值
//    if (model.type == 1) {
//        order.tradeNO = [NSString stringWithFormat:@"%@",model.ids];//[self generateTradeNO]; //订单ID（由商家自行制定）
//    }
//    order.productName = model.title; //商品标题
//    order.productDescription = model.product.description; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",[model.price floatValue]]; //商品价格
//    order.notifyURL =  NotifyURL; //回调URL
//    
//    return [order description];
    return discription;
}

+ (NSString*)doRsa:(NSString*)orderInfo{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

@end
