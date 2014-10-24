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
@synthesize ticker = _ticker;
@synthesize product = _product;
@synthesize address = _address;

- (void)setState:(int)state{
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
        _ticker = ticker;
}
- (void)setProduct:(id)product{
    if ([product isKindOfClass:[BDDinnerModel class]]) {
        _product = product;
        self.img = _product.img;
        self.title = _product.title;
        self.money = _product.money;
    }
    else if ([product isKindOfClass:[NSDictionary class]]){
        _product = [HNYJSONUitls mappingDictionary:product toObjectWithClassName:@"BDDinnerModel"];
        self.img = _product.img;
        self.title = _product.title;
        self.money = _product.money;
    }
    else
        _product = product;
}

- (void)setAddress:(id)address{
    if ([address isKindOfClass:[BDAddressModel class]]) {
        _address = address;
    }
    else if ([address isKindOfClass:[NSDictionary class]]){
        _address = [HNYJSONUitls mappingDictionary:address toObjectWithClassName:@"BDAddressModel"];
    }
    else
        _address = address;
}

@end
