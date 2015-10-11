//
//  BDOrderModel.m
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderModel.h"

@implementation BDOrderModel
@synthesize state = _state;
@synthesize product = _product;
@synthesize state_refund = _state_refund;

- (void)setState:(NSInteger)state{
    _state = state;
    if (_state == 0) {
        self.stateName = @"待付款";
    }
    else if (_state == 1){
        self.stateName = @"已付款";
    }
    else if (_state == 2){
        self.stateName = @"派送中";
    }
    else if (_state == 3){
        self.stateName = @"成交";
    }
    else if (_state == 4){
        self.stateName = @"失效";
    }
}
- (void)setTicker:(id)ticker{
    if ([ticker isKindOfClass:[BDCouponModel class]]) {
        _ticker = ticker;
    }
    else if ([ticker isKindOfClass:[NSDictionary class]]){
        _ticker = [HNYJSONUitls mappingDictionary:ticker toObjectWithClassName:@"BDCouponModel"];
    }
    else
        _ticker = nil;
}

- (void)setProduct:(NSMutableArray *)product{

    NSMutableArray *array = [NSMutableArray array];
    for (id object in product) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            BDProductModel *model = [[BDProductModel alloc] init];
            model.ids = [[object valueForKey:@"product_id"] integerValue];
            model.img = [object valueForKey:@"product_img"];
            model.money = [object valueForKey:@"product_money"];
            model.number = [[object valueForKey:@"product_number"] integerValue];
            model.title = [object valueForKey:@"product_title"];
            
            [array addObject:model];
        }
        else if ([object isKindOfClass:[BDProductModel class]]) {
            _product = product;
            return;
        }
    }
    _product = array;
}
- (void)setAddress:(id)address{
    if ([address isKindOfClass:[BDAddressModel class]]) {
        _address = address;
    }
    else if ([address isKindOfClass:[NSDictionary class]]){
        _address = [HNYJSONUitls mappingDictionary:address toObjectWithClassName:@"BDAddressModel"];
    }
    else
        _address = nil;
}
- (void)setState_refund:(NSInteger)state_refund{
    _state_refund = state_refund;
    // ： 退款状态（0无，1有退款，2不同意退款，3等买家退货，4等卖家收货，5退款成功，6退款关闭）
    if (_state_refund == 0) {
        self.state_refund_name = @"";
    }
    else if (_state_refund == 1){
        self.state_refund_name = @"有退款";
    }
    else if (_state_refund == 2){
        self.state_refund_name = @"不同意退款";
    }
    else if (_state_refund == 3){
        self.state_refund_name = @"等买家退货";
    }
    else if (_state_refund == 4){
        self.state_refund_name = @"等卖家收货";
    }
    else if (_state_refund == 5){
        self.state_refund_name = @"退款成功";
    }
    else if (_state_refund == 6){
        self.state_refund_name = @"退款关闭";
    }

}
- (NSString *)title{
    
    if (!_title) {
        return _title;
    }
    else if (1 == self.type) {
        return  @"充值";
    }
    else {
        return  @"订餐";
    }
}
@end
